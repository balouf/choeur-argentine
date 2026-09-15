import argparse
import subprocess
import re
import os
import tomllib
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from tqdm.auto import tqdm
from string import Template
import json
import shutil


def parse_args(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--lilypond", default="lilypond", help="path to Lilypond executable")
    parser.add_argument("-d", "--dest", default="build", help="destination folder")
    parser.add_argument("-s", "--source", default=None,
                        help="build every .ly of that folder, ignoring the manifest")
    parser.add_argument("-m", "--manifeste", default="saisons.toml",
                        help="season manifest (used unless --source is given)")
    parser.add_argument("--saison", default=None,
                        help="season to build; defaults to the manifest's `actif` key")
    return parser.parse_args(argv)


rtitle = re.compile(r'\Wtitle\s*=.*?"(.*)"')
stitle = re.compile(r'\Wsubtitle\s*=.*?"(.*)"')
instrus = re.compile(r'\WinstrumentName\s*=\s*"(.*)"')

SOURCES = Path("lilypond")


def lire_manifeste(manifeste="saisons.toml"):
    """Parse the season manifest and return (active season name, seasons dict)."""
    with open(manifeste, "rb") as f:
        data = tomllib.load(f)
    saisons = data.get("saisons", {})
    if not saisons:
        raise ValueError(f"{manifeste}: aucune saison déclarée")
    actif = data.get("actif")
    if actif is None:
        raise ValueError(f"{manifeste}: clé `actif` manquante")
    if actif not in saisons:
        raise ValueError(f"{manifeste}: saison active `{actif}` non déclarée")
    return actif, saisons


def pieces_de_saison(manifeste="saisons.toml", saison=None, sources=SOURCES):
    """Resolve the pieces of a season into existing .ly paths under `sources`."""
    actif, saisons = lire_manifeste(manifeste)
    saison = saison or actif
    if saison not in saisons:
        connues = ", ".join(sorted(saisons))
        raise ValueError(f"saison inconnue `{saison}` (connues : {connues})")
    files = [Path(sources) / f"{nom}.ly" for nom in saisons[saison]["pieces"]]
    manquants = [str(f) for f in files if not f.is_file()]
    if manquants:
        raise FileNotFoundError(
            f"saison `{saison}` : fichiers déclarés mais absents : {', '.join(manquants)}"
        )
    return files


def run(cmd):
    result = subprocess.run(
        cmd,
        shell=True,
        capture_output=True,
        text=True,
        encoding='utf-8',
        errors='replace'  # Replace undecodable bytes instead of crashing
    )
    if result.returncode != 0:
        raise RuntimeError(f"Command failed: {cmd}\n{result.stderr}")
    return result


def run_lily(file, lily, dest):
    with open(file, encoding='utf8') as f:
        src = f.read()
        try:
            title = rtitle.findall(src)[0]
        except IndexError:
            raise IndexError(f"{file}")
        subtitle = stitle.findall(src)
        if subtitle:
            title = f"{title} - {subtitle[0]}"
        voix = instrus.findall(src)
    pdfs = []
    stem = file.stem
    target = dest / stem
    target.mkdir(parents=True, exist_ok=True)
    # Le chemin de l'exécutable se met entre guillemets : sous Windows il
    # contient des espaces (« Program Files (x86) ») et `shell=True` le
    # coupait au premier, sur `C:/Program`.
    run(f'"{lily}" -o {str(target)} -dno-point-and-click {str(file)}')
    for midi in target.glob('*.mid*'):
        wav = midi.with_suffix(".wav")
        mp3 = midi.with_suffix(".mp3")
        run(f"timidity {str(midi)} -Ow -o {str(wav)}")
        run(f'ffmpeg-normalize {str(wav)} -nt peak -t -1 -c:a mp3 -o {str(mp3)}')
        wav.unlink()
        if midi.suffix == '.mid':
            midi.replace(midi.with_suffix('.midi'))
    for f in target.glob('*'):
        if f.is_file():
            suf = f.suffix
            if suf not in ['.pdf', '.midi', '.mp3']:
                continue
            new_name = f.stem.replace('--', '-')
            f.replace(target / f"{new_name}{suf}")
            if suf == '.pdf':
                if new_name.endswith('-piano'):
                    pdfs.append({'name': 'Piano', 'suffix': '-piano'})
                elif new_name.endswith('-full'):
                    pdfs.append({'name': 'Conducteur', 'suffix': '-full'})
                elif new_name.endswith('-violon1'):
                    pdfs.append({'name': 'Violon 1', 'suffix': '-violon1'})
                elif new_name.endswith('-violon2'):
                    pdfs.append({'name': 'Violon 2', 'suffix': '-violon2'})
                else:
                    pdfs.append({'name': 'Choeurs', 'suffix': ''})
    pdfs = sorted(pdfs, key=lambda pdf: pdf['name'])
    return title, stem, voix, pdfs


def run_everything(lily, input_files, dest):
    dest = Path(dest)
    # Use os.walk for Python 3.10+ compatibility (Path.walk is 3.12+)
    if dest.exists():
        for root, dirs, files in os.walk(dest, topdown=False):
            for name in files:
                (Path(root) / name).unlink()
            for name in dirs:
                (Path(root) / name).rmdir()
    dest.mkdir(exist_ok=True)

    with ThreadPoolExecutor() as executor:
        print("Lilypond compilation started...")
        futures = [
            executor.submit(run_lily, file, lily, dest)
            for file in input_files
        ]
        tracks = []
        for future in tqdm(as_completed(futures), total=len(futures)):
            try:
                tracks.append(future.result())
            except Exception as e:
                print(f"Error processing file: {e}")
                raise
    tracks = [{'name': t[0], 'path':  t[1], 'voix': t[2], 'pdfs': t[3]}
              for t in sorted(tracks, key=lambda t: t[0])]
    # print(tracks)

    with open('choeur_argentine/index.tpl', 'rt', encoding='utf8') as source_file, \
        open(dest / 'index.html', 'wt', encoding='utf8') as target:
        template = Template(source_file.read())
        target.write(template.substitute(tracks=json.dumps(tracks)))

    # Copy styles directory
    styles_src = Path('choeur_argentine/styles')
    styles_dest = dest / 'styles'
    if styles_src.exists():
        shutil.copytree(styles_src, styles_dest, dirs_exist_ok=True)

    # Copy JavaScript modules
    js_src = Path('choeur_argentine/js')
    js_dest = dest / 'js'
    if js_src.exists():
        shutil.copytree(js_src, js_dest, dirs_exist_ok=True)

    # Copy assets if they exist
    assets_src = Path('choeur_argentine/assets')
    assets_dest = dest / 'assets'
    if assets_src.exists():
        shutil.copytree(assets_src, assets_dest, dirs_exist_ok=True)


if __name__ == '__main__':
    args = parse_args()
    if args.source is not None:
        input_files = sorted(Path(args.source).glob('*.ly'))
        print(f"{len(input_files)} pièce(s) depuis {args.source}/")
    else:
        input_files = pieces_de_saison(args.manifeste, args.saison)
        saison = args.saison or lire_manifeste(args.manifeste)[0]
        print(f"{len(input_files)} pièce(s) de la saison {saison}")
    run_everything(args.lilypond, input_files, args.dest)

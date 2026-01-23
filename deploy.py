import argparse
import subprocess
import re
import os
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from tqdm.auto import tqdm
from string import Template
import json
import shutil


parser = argparse.ArgumentParser()
parser.add_argument("-l", "--lilypond", default="lilypond", help="path to Lilypond executable")
parser.add_argument("-d", "--dest", default="build", help="destination folder")
parser.add_argument("-s", "--source", default="lilypond", help="source folder")
args = parser.parse_args()
lily = args.lilypond
dest = args.dest
source = args.source
rtitle = re.compile(r'\Wtitle\s*=.*?"(.*)"')
stitle = re.compile(r'\Wsubtitle\s*=.*?"(.*)"')
instrus = re.compile(r'\WinstrumentName\s*=\s*"(.*)"')

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
    run(f'{lily} -o {str(target)} -dno-point-and-click {str(file)}')
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
                else:
                    pdfs.append({'name': 'Choeurs', 'suffix': ''})
    return title, stem, voix, pdfs


def run_everything(lily, source, dest):
    input_files = [file for file in Path(source).glob('*.ly')]

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
    run_everything(lily, source, dest)

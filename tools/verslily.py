#!/usr/bin/env python3
"""Écrit le `.ly` à partir de l'extraction de `pdfglyphs.py`.

Ne sort que ce qui a été **vérifié** : une mesure dont les durées ne sont pas
lues et confirmées par l'un des contrôles de `durees.py` est écrite en clair,
avec sa lecture brute et un commentaire `% À RELIRE`, plutôt que devinée. Le
fichier compile quand même — les contrôles de mesure de LilyPond signaleront
ces endroits-là, et eux seuls.

    python tools/verslily.py notes.json -o lilypond/balderrama.ly \\
        --titre "Balderrama" --compositeur "Gustavo Leguizamón" \\
        --voix Soprano Alto Ténor Basse

Ce qui reste à la main après coup : la césure des paroles, que le PDF ne porte
pas (le graveur écrit « Tra la la » sans lier les syllabes), les liaisons, et
les nuances.
"""

import argparse
import json
import re
import sys
from collections import defaultdict
from fractions import Fraction as F
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import durees as D                                          # noqa: E402

DIATO = "cdefgab"
# Ordre canonique des altérations, pour retrouver la tonalité écrite.
MAJEURES_DIESES = ["c", "g", "d", "a", "e", "b", "fis", "cis"]
MAJEURES_BEMOLS = ["c", "f", "bes", "ees", "aes", "des", "ges", "ces"]
# `\relative` a besoin d'un point de départ ; celui qu'emploie le dépôt.
ANCRE = {"sol": ("c'", 4 * 7), "sol8": ("c'", 4 * 7), "fa": ("c", 3 * 7)}
STYLE = {"sol": "soprano_style", "sol8": "tenor_style", "fa": "hommes_style"}


def note_lily(nom):
    """« C4is » → (« cis », 4). Le nom porte la hauteur *écrite*."""
    m = re.fullmatch(r"([A-G])(-?\d+)(is|es)?", nom)
    lettre, octave, alt = m.group(1).lower(), int(m.group(2)), m.group(3) or ""
    return lettre + alt, octave


def octaves(precedent, step):
    """Apostrophes ou virgules à ajouter, dans un bloc `\\relative`.

    Sans marque, LilyPond choisit la hauteur la plus proche de la précédente ;
    la marque compte les octaves qui séparent celle-là de celle qu'on veut.
    """
    naturelle = round((precedent - step % 7) / 7)
    ecart = step // 7 - naturelle
    return "'" * ecart if ecart > 0 else "," * -ecart


def duree_lily(d):
    """Durée en noires → figure LilyPond, ou None si elle n'en est pas une."""
    for points in (0, 1, 2):
        base = d / (2 - F(1, 2 ** points))
        for k in range(7):
            if base == F(4, 2 ** k):
                return str(2 ** k) + "." * points
    return None


def tonalite(portees, dieses, bemols, force=None):
    """Armure → tonalité écrite, majeure ou relative mineure.

    L'armure seule ne distingue pas une tonalité de sa relative mineure : deux
    dièses valent ré majeur comme si mineur. Ce qui les sépare est la note
    finale de la basse, qui est la tonique — Balderrama s'achève sur un si,
    donc si mineur, quand l'armure seule aurait fait écrire ré majeur.
    Le choix est rendu avec la finale sur laquelle il s'appuie, pour qu'il se
    démente d'un coup d'œil ; `--majeur` et `--mineur` l'imposent.
    """
    majeure = (MAJEURES_BEMOLS if bemols else MAJEURES_DIESES)[min(bemols or dieses, 7)]
    relative = DIATO[(DIATO.index(majeure[0]) - 2) % 7] + majeure[1:]
    finale = None
    graves = [p for p in sorted(portees, key=lambda p: (p["page"], p["portee"]))
              if p["portee"] % portees[0]["portees_par_systeme"]
              == portees[0]["portees_par_systeme"] - 1 and p["notes"]]
    if graves:
        finale = max(graves[-1]["notes"], key=lambda n: n["x"])["nom"]
        finale = finale[0].lower() + ("is" if finale.endswith("is")
                                      else "es" if finale.endswith("es") else "")
    if force == "major" or (force is None and finale != relative):
        return majeure, "major", finale
    return relative, "minor", finale


class Plume:
    """Écrit une voix, en gardant la hauteur de référence de `\\relative`."""

    def __init__(self, reference):
        self.reference = reference

    def evenement(self, e, duree, longueur):
        figure = duree_lily(duree) if duree is not None else None
        if not e["notes"]:
            if e["signe"] == "pause" and duree == longueur:
                return "R" + (duree_lily(longueur) or "")
            return "r" + (figure or "")
        rendus = []
        for nom in e["notes"]:
            lettre, octave = note_lily(nom)
            step = octave * 7 + DIATO.index(lettre[0])
            rendus.append(lettre + octaves(self.reference, step))
            if len(rendus) == 1:               # l'accord se réfère à sa basse
                self.reference = step
        corps = rendus[0] if len(rendus) == 1 else "<" + " ".join(rendus) + ">"
        return corps + (figure or "")


def mesure_lily(m, longueur, plume):
    """Une mesure, en LilyPond. Rend aussi son sort, pour le rapport."""
    if m["etat"] == "deux voix":
        dessus, dessous, sur = m["voix"]
        depart = plume.reference
        haut = " ".join(plume.evenement(e, D.duree_lue(e, longueur), longueur)
                        for e in dessus)
        arrivee = plume.reference
        plume.reference = depart          # la voix du bas repart du même point
        bas = " ".join(plume.evenement(e, D.duree_lue(e, longueur), longueur)
                       for e in dessous)
        plume.reference = arrivee         # et la suite reprend celle du haut
        doute = "" if sur else "   % partage des silences incertain"
        return f"\\duo {{ {haut} }} {{ {bas} }}{doute}", m["etat"]

    durees = m["durees"]
    if m["etat"] not in ("lue", "levée", "clôture") or durees is None:
        durees = [D.duree_lue(e, longueur) for e in m["mesure"]]
    corps = " ".join(plume.evenement(e, d, longueur)
                     for e, d in zip(m["mesure"], durees))
    if m["etat"] in ("lue", "levée", "clôture"):
        return corps, m["etat"]
    return corps + f"   % À RELIRE ({m['etat']})", m["etat"]


def ligne_chantee(portee, xs, colle):
    """La ligne de texte qui est le premier couplet, parmi celles du dessous.

    Sous une portée il n'y a pas que des paroles : un numéro de page, un
    repère de reprise, la mention d'éditeur du bas de page. On garde celle
    dont les syllabes tombent le plus souvent sous une note.
    """
    meilleure, score = [], 0
    for ligne in portee.get("paroles") or []:
        n = sum(1 for s in ligne
                if xs and abs(min(xs, key=lambda x: abs(x - s["x"])) - s["x"]) <= colle)
        if n > score:
            meilleure, score = ligne, n
    return meilleure


def paroles_lily(portees, periode, voix, colle=8.0):
    """Aligne les syllabes sur les notes, portée par portée.

    Chaque syllabe est gravée sous sa note : l'abscisse suffit à les apparier,
    et une note sans syllabe reçoit le `_` que LilyPond attend — c'est le cas
    d'un mélisme, que faute de lire les liaisons on ne peut pas prolonger.

    Deux syllabes sous une même note ne sont pas une césure mais une élision :
    « Si‿u », que LilyPond écrit `Si~u`.
    """
    lignes = []
    for p in sorted(portees, key=lambda q: (q["page"], q["portee"])):
        if p["portee"] % periode != voix:
            continue
        xs = sorted({round(n["x"], 2) for n in p["notes"]})
        syl = ligne_chantee(p, xs, colle)
        if not syl or not xs:
            continue
        # L'appariement avance avec la lecture et ne revient jamais en
        # arrière : une syllabe va à la note la plus proche parmi celles qui
        # restent. Prendre la plus proche dans toute la portée donnait deux
        # syllabes à une note et rien à sa voisine, et une note sur trois se
        # retrouvait muette au milieu d'un mot.
        par_note = defaultdict(list)
        j = 0
        for s in syl:
            k = j
            while k + 1 < len(xs) and abs(xs[k + 1] - s["x"]) < abs(xs[k] - s["x"]):
                k += 1
            if abs(xs[k] - s["x"]) > colle and k == j and not par_note:
                continue
            # Seule une élision partage une note. Deux syllabes liées par un
            # tiret sont deux notes : les empiler ferait lire « pa -- ga »
            # comme deux syllabes sur une seule note, et LilyPond décalerait
            # tout le reste de la ligne d'un cran.
            if par_note.get(xs[k]) and par_note[xs[k]][-1]["lie"]:
                k = min(k + 1, len(xs) - 1)
            par_note[xs[k]].append(s)
            j = k          # la suivante peut retomber ici : c'est une élision
        mots = []
        for x in xs:
            groupe = par_note.get(x)
            if not groupe:
                mots.append("_")
                continue
            mot = groupe[0]["texte"]
            for precedent, suivant in zip(groupe, groupe[1:]):
                mot += ("~" if not precedent["lie"] else " -- ") + suivant["texte"]
            if groupe[-1]["lie"]:
                mot += " --"
            mots.append(mot)
        lignes.append(" ".join(mots))
    return lignes


def voix_lily(portees, periode, voix, longueur, nom_var, instrument):
    """Le bloc `<nom>_music` d'une voix, et le compte de ses mesures douteuses."""
    portees_voix = [p for p in sorted(portees, key=lambda p: (p["page"], p["portee"]))
                    if p["portee"] % periode == voix]
    cle = portees_voix[0]["cle"]
    ancre, reference = ANCRE[cle]
    plume = Plume(reference)
    lignes, douteuses, systeme = [], 0, None
    premiere = True
    for p in portees_voix:
        mesures = D.analyser(p, longueur)
        if systeme is not None and (p["page"], p["systeme"]) != systeme:
            lignes.append("")
        systeme = (p["page"], p["systeme"])
        morceaux = []
        for m in mesures:
            texte, etat = mesure_lily(m, longueur, plume)
            if etat == "levée" and premiere:
                somme = sum(D.duree_lue(e, longueur) for e in m["mesure"])
                morceaux.append("\\partial " + (duree_lily(somme) or "4"))
            if etat not in ("lue", "levée", "clôture", "deux voix"):
                douteuses += 1
            morceaux.append(texte)
            morceaux.append("|")
            premiere = False
        lignes.append("  " + " ".join(morceaux))
    return "\n".join(lignes), douteuses, cle, ancre


def ecrire(portees, args):
    periode = portees[0]["portees_par_systeme"]
    chiffrage = next(p["chiffrage"] for p in portees if p.get("chiffrage"))
    longueur = F(chiffrage[0] * 4, chiffrage[1])
    dieses = portees[0]["armure_dieses"]
    bemols = portees[0]["armure_bemols"]
    force = "minor" if args.mineur else "major" if args.majeur else None
    note, mode, finale = tonalite(portees, dieses, bemols, force)
    print(f"   armure {dieses}# {bemols}b, basse finale {finale} → "
          f"{note} {mode}", file=sys.stderr)

    noms = args.voix or [f"voix{i}" for i in range(periode)]
    variables = [re.sub(r"\W+", "", n.lower()) or f"voix{i}"
                 for i, n in enumerate(noms)]

    out = [f'\\version "{args.version}"', "",
           '#(set-default-paper-size "a4")', "",
           "\\header {",
           f'  title = \\markup {{ \\fontsize #5 \\bold "{args.titre}" }}']
    if args.sous_titre:
        out.append(f'  subtitle = "{args.sous_titre}"')
    if args.compositeur:
        out.append(f'  composer = "{args.compositeur}"')
    if args.poete:
        out.append(f'  poet = "{args.poete}"')
    if args.arrangeur:
        out.append(f'  arranger = "{args.arrangeur}"')
    out += ['  tagline = ""', "}", "",
            "conductor_size = 17", "individual_size = 20", "",
            '\\include "utils/macros.ly"', "",
            "armure = {",
            "  \\accidentalStyle modern-cautionary",
            "  \\compressEmptyMeasures",
            f"  \\time {chiffrage[0]}/{chiffrage[1]}"]
    if args.tempo:
        out.append(f"  \\tempo {args.tempo}")
    out += [f"  \\key {note} \\{mode}",
            "}", ""]

    bilan = {}
    for v, (nom_affiche, var) in enumerate(zip(noms, variables)):
        corps, douteuses, cle, ancre = voix_lily(
            portees, periode, v, longueur, var, nom_affiche)
        bilan[nom_affiche] = douteuses
        lignes_paroles = paroles_lily(portees, periode, v)
        out.append(f"{var}_music = {{")
        out.append(corps)
        out.append("}")
        out.append("")
        out.append(f"{var}_lyrics = \\lyricmode {{")
        for ligne in lignes_paroles:
            out.append("  " + ligne)
        out.append("}")
        out.append("")
        court = nom_affiche[0].upper() + "."
        out.append(f'{var} = \\new Staff \\with {{instrumentName="{nom_affiche}"')
        out.append(f'  shortInstrumentName ="{court}"}} <<')
        out.append(f"  \\{STYLE[cle]}")
        out.append("  \\armure")
        out.append(f"  \\relative {ancre} {{\\{var}_music}}")
        out.append(f"  \\addlyrics {{\\{var}_lyrics}}")
        out.append(">>")
        out.append("")

    appel = "\n".join(f"      \\{v}" for v in variables)
    out += ["#(set-global-staff-size conductor_size)",
            "\\book {",
            "  \\score {",
            "    \\layout {",
            "      \\context {",
            "        \\Staff",
            "        \\RemoveEmptyStaves",
            "      }",
            "    }",
            "    \\new ChoirStaff",
            "    <<",
            appel,
            "    >>",
            "  }",
            "  \\score {",
            "    \\unfoldRepeats",
            "    <<",
            appel,
            "    >>",
            "    \\midi {}",
            "  }",
            "}"]
    return "\n".join(out) + "\n", bilan


def main():
    for flux in (sys.stdout, sys.stderr):
        flux.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("json", type=Path)
    ap.add_argument("-o", "--out", type=Path)
    ap.add_argument("--titre", default="Sans titre")
    ap.add_argument("--sous-titre", default=None)
    ap.add_argument("--compositeur", default=None)
    ap.add_argument("--tempo", default=None, help='ex. "4 = 108"')
    ap.add_argument("--mineur", action="store_true",
                    help="imposer la relative mineure")
    ap.add_argument("--majeur", action="store_true",
                    help="imposer la majeure")
    ap.add_argument("--poete", default=None)
    ap.add_argument("--arrangeur", default=None)
    ap.add_argument("--version", default="2.22.0")
    ap.add_argument("--voix", nargs="*", help="noms des pupitres, de haut en bas")
    args = ap.parse_args()

    portees = json.loads(args.json.read_text(encoding="utf8"))
    texte, bilan = ecrire(portees, args)
    if args.out:
        args.out.write_text(texte, encoding="utf8")
        print(f"→ {args.out}")
    else:
        print(texte)
    total = sum(bilan.values())
    for nom, n in bilan.items():
        print(f"   {nom:12s} {n} mesure(s) à relire", file=sys.stderr)
    print(f"   {total} mesure(s) marquées « À RELIRE »", file=sys.stderr)


if __name__ == "__main__":
    main()

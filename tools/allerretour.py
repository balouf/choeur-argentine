#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = ["mido"]
# ///
"""Confronte le MIDI que LilyPond produit aux hauteurs lues dans le PDF.

C'est le contrôle qui porte sur la **génération** et non sur la lecture : les
trois autres (somme de la mesure, concordance des voix, partage en deux voix)
vérifient ce qu'on a lu du dessin ; celui-ci vérifie que le `.ly` écrit bien
ce qu'on avait lu. Piste par piste, note par note, octave comprise. Exhaustif
et gratuit, là où relire la gravure ne l'est ni l'un ni l'autre.

    uv run tools/allerretour.py lilypond/balderrama.ly notes.json

Le `.ly` est recompilé dans un répertoire temporaire, `\\unfoldRepeats` retiré :
la comparaison porte sur ce qui est **écrit**, une fois, comme le PDF source.
Déplier ferait diverger les deux suites à la première reprise sans que rien
soit faux.
"""

import argparse
import json
import re
import subprocess
import sys
import tempfile
from collections import defaultdict
from fractions import Fraction as F
from pathlib import Path

import mido

sys.path.insert(0, str(Path(__file__).parent))
import durees as D                                          # noqa: E402

DIATO = "CDEFGAB"
DEMI_TONS = {"C": 0, "D": 2, "E": 4, "F": 5, "G": 7, "A": 9, "B": 11}
LILYPOND = r"C:\Program Files (x86)\lilypond-2.26.0\bin\lilypond.exe"


NOMS = ["do", "do#", "ré", "ré#", "mi", "fa", "fa#", "sol", "sol#", "la",
        "la#", "si"]


def nom_midi(h):
    """61 → « do#4 ». Les dièses plutôt que les bémols : tout le corpus l'est."""
    return "—" if h is None else f"{NOMS[h % 12]}{h // 12 - 1}"


def hauteur_midi(nom):
    """« C4is » → 61. Le nom porte la hauteur écrite, en notation scientifique."""
    m = re.fullmatch(r"([A-G])(-?\d+)(is|es)?", nom)
    lettre, octave, alt = m.group(1), int(m.group(2)), m.group(3)
    return (12 * (octave + 1) + DEMI_TONS[lettre]
            + (1 if alt == "is" else -1 if alt == "es" else 0))


def suite_vecteur(portees, periode, voix):
    """Les hauteurs d'une voix dans l'ordre de lecture, accords triés."""
    suite = []
    for p in sorted(portees, key=lambda q: (q["page"], q["portee"])):
        if p["portee"] % periode != voix:
            continue
        for n in sorted(p["notes"], key=lambda n: (n["x"], n["step"])):
            suite.append(hauteur_midi(n["nom"]))
    return suite


def suites_midi(chemin):
    """Les hauteurs de chaque piste : la suite, et le même découpé en mesures.

    La suite suffit tant qu'une portée est monodique ; dès qu'elle porte deux
    voix, l'ordre de lecture du dessin et l'ordre du temps cessent de
    coïncider — deux notes simultanées sont écrites l'une après l'autre au
    PDF, et le MIDI ne sait pas laquelle vient d'abord. Le découpage en
    mesures s'en moque : il ne compare que des contenus.
    """
    fichier = mido.MidiFile(chemin)
    pistes = []
    for piste in fichier.tracks:
        instants, t = defaultdict(list), 0
        for message in piste:
            t += message.time
            if message.type == "note_on" and message.velocity > 0:
                instants[t].append(message.note)
        if instants:
            pistes.append(instants)
    return pistes, fichier.ticks_per_beat


def en_suite(instants):
    return [h for t in sorted(instants) for h in sorted(instants[t])]


def en_mesures(instants, tpb, longueur, levee):
    """Les hauteurs par mesure écrite, dans l'ordre du grave.

    La levée occupe la mesure 0 et n'en remplit que la fin : le décalage la
    recale sur une mesure pleine, de sorte que la mesure 1 commence bien à la
    première barre.
    """
    par_mesure = defaultdict(list)
    pas = int(longueur * tpb)
    decalage = int((longueur - levee) * tpb) if levee else 0
    for t, hauteurs in instants.items():
        par_mesure[(t + decalage) // pas] += hauteurs
    if not par_mesure:
        return []
    return [sorted(par_mesure.get(i, [])) for i in range(max(par_mesure) + 1)]


def mesures_vecteur(portees, periode, voix, longueur):
    """Les hauteurs lues au PDF, une liste par mesure écrite."""
    return [sorted(hauteur_midi(nom) for e in m["mesure"] for nom in e["notes"])
            for v, p, m in D.par_voix(portees, longueur) if v == voix]


def compiler(source, dossier):
    """Compile une copie repliée du `.ly` et rend le chemin de son `.mid`."""
    texte = source.read_text(encoding="utf8").replace("\\unfoldRepeats", "")
    copie = dossier / source.name
    copie.write_text(texte, encoding="utf8")
    subprocess.run([LILYPOND, "-dno-point-and-click", "-o", str(dossier / "sortie"),
                    str(copie)],
                   cwd=source.parent, check=True,
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    mids = sorted(dossier.glob("*.mid"))
    if not mids:
        sys.exit("LilyPond n'a pas produit de MIDI — le .ly a-t-il un bloc \\midi ?")
    return mids[0]


def main():
    for flux in (sys.stdout, sys.stderr):
        flux.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("ly", type=Path, help="la partition LilyPond")
    ap.add_argument("json", type=Path, help="sortie de pdfglyphs.py")
    ap.add_argument("--max", type=int, default=12, help="écarts affichés par voix")
    args = ap.parse_args()

    portees = json.loads(args.json.read_text(encoding="utf8"))
    periode = portees[0]["portees_par_systeme"]
    chiffrage = next(p["chiffrage"] for p in portees if p.get("chiffrage"))
    longueur = F(chiffrage[0] * 4, chiffrage[1])
    levee = next((m["somme"] for _, _, m in D.par_voix(portees, longueur)
                  if m["etat"] == "levée"), F(0)) or F(0)
    with tempfile.TemporaryDirectory() as tmp:
        pistes, tpb = suites_midi(compiler(args.ly, Path(tmp)))

    if len(pistes) != periode:
        print(f"ATTENTION : {len(pistes)} piste(s) MIDI pour {periode} voix "
              f"— appariement dans l'ordre, à vérifier")
    total, liees = 0, 0
    for v, instants in enumerate(pistes):
        attendu = suite_vecteur(portees, periode, v) if v < periode else []
        suite = en_suite(instants)
        tenues, ecarts = confronter(attendu, suite)
        if not ecarts:
            liees += tenues
            détail = f", {tenues} absorbée(s) par une liaison" if tenues else ""
            print(f"voix {v} : {len(attendu)} notes — identique{détail}")
            continue
        # Repli : la confrontation par mesure, insensible à l'ordre des voix
        # simultanées. Elle est plus faible — elle ne vérifie plus l'ordre
        # à l'intérieur d'une mesure — mais c'est le seul ordre qui n'ait pas
        # de sens sur une portée polyphonique.
        tenues, ecarts = confronter_mesures(
            mesures_vecteur(portees, periode, v, longueur),
            en_mesures(instants, tpb, longueur, levee))
        liees += tenues
        total += len(ecarts)
        if not ecarts:
            print(f"voix {v} : {len(attendu)} notes — identique mesure à "
                  f"mesure, {tenues} absorbée(s) par une liaison "
                  f"(l'ordre des voix simultanées diffère, sans conséquence)")
            continue
        print(f"voix {v} : {len(attendu)} lues, {len(suite)} au MIDI — "
              f"{len(ecarts)} désaccord(s) sur {len(set(e[0] for e in ecarts))} "
              f"mesure(s), {tenues} liaison(s) de tenue")
        for mesure, a, b in ecarts[:args.max]:
            print(f"    mesure {mesure + 1:4d}  PDF {nom_midi(a):>6s}"
                  f"   .ly {nom_midi(b):>6s}")
    if liees:
        print(f"\n{liees} note(s) absorbée(s) par une liaison de tenue — "
              f"le MIDI n'en réattaque qu'une, c'est le comportement voulu.")
    print(f"{total} note(s) en désaccord.")
    return 1 if total else 0


def confronter_mesures(attendu, obtenu):
    """Mesure par mesure : le MIDI doit avoir le même contenu, aux liaisons
    près. Une hauteur manquante n'est admise que si une liaison peut l'avoir
    absorbée, c'est-à-dire si la même hauteur est déjà dans la mesure ou dans
    celle d'avant.
    """
    ecarts, tenues, precedente = [], 0, []
    for i in range(max(len(attendu), len(obtenu))):
        a = list(attendu[i]) if i < len(attendu) else []
        b = list(obtenu[i]) if i < len(obtenu) else []
        reste = list(a)
        for h in b:
            if h in reste:
                reste.remove(h)
            else:
                ecarts.append((i, None, h))
        for h in reste:
            if a.count(h) > 1 or h in precedente:
                tenues += 1
            else:
                ecarts.append((i, h, None))
        precedente = a
    return tenues, ecarts


def confronter(attendu, piste):
    """Le MIDI doit se déduire du PDF en n'ôtant que des notes liées.

    Une liaison de tenue est la **seule** raison légitime pour que le MIDI
    soit plus court que la gravure, et elle n'ôte qu'une note égale à celle
    qui la précède. La confrontation est donc exacte et non approchée : à
    chaque pas, ou les deux suites concordent, ou la note du PDF répète sa
    voisine et une liaison l'a absorbée, ou c'est un désaccord.

    Un appariement par ressemblance ne suffisait pas : sur le candombe, où
    les notes répétées abondent, `difflib` rendait des blocs déplacés de
    cinquante notes là où tout était juste, et aucune règle sur ces blocs ne
    pouvait plus distinguer une liaison d'une faute.
    """
    i = j = 0
    tenues, ecarts = 0, []
    while i < len(attendu) and j < len(piste):
        if attendu[i] == piste[j]:
            i, j = i + 1, j + 1
        elif i and attendu[i] == attendu[i - 1]:
            i, tenues = i + 1, tenues + 1
        else:
            ecarts.append((i, j, attendu[i], piste[j]))
            i, j = i + 1, j + 1        # on resynchronise pour voir la suite
    while i < len(attendu):
        if i and attendu[i] == attendu[i - 1]:
            tenues += 1
        else:
            ecarts.append((i, None, attendu[i], None))
        i += 1
    ecarts += [(None, k, None, piste[k]) for k in range(j, len(piste))]
    return tenues, ecarts


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""Confronte les hauteurs du PDF vectoriel à celles de l'OMR.

Deux sources indépendantes : `pdfglyphs.py` lit les têtes de notes dans le
vectoriel (géométrie exacte, mais ni durées ni voix) et Audiveris reconstruit
la partition entière (durées, voix, liaisons, mais reconnaissance faillible).
Là où elles s'accordent, la hauteur est sûre ; là où elles divergent, il faut
regarder. C'est ce qui remplace la relecture intégrale par une vingtaine de
points à vérifier.

    python tools/pitchdiff.py notes.json partition.mxl

Deux niveaux de sévérité, parce que les deux grandeurs n'ont pas la même
solidité côté vectoriel. Le **degré diatonique** vient de l'ordonnée de la tête
sur la portée : il est exact. L'**altération** est déduite de l'armure et des
accidents voisins, et cette déduction ignore qu'un accident vaut pour toute la
fin de la mesure — donc un désaccord d'altération est un signalement, pas une
erreur établie.

Rien n'est présumé de la correspondance entre portées et parties MusicXML :
Audiveris n'unifie pas toujours les pupitres d'une feuille à l'autre et peut
inventer des parties fantômes. Les voix sont donc appariées par ressemblance
de leurs suites de hauteurs, et ce qui reste sans correspondant est signalé.
"""

import argparse
import json
import sys
import zipfile
import xml.etree.ElementTree as ET
from collections import defaultdict
from difflib import SequenceMatcher
from pathlib import Path

DIATO = "CDEFGAB"
PAS = {lettre: i for i, lettre in enumerate(DIATO)}


def colonnes_vecteur(portees, periode):
    """Une suite de colonnes (accords) par voix, dans l'ordre de lecture."""
    voix = defaultdict(list)
    for p in sorted(portees, key=lambda p: (p["page"], p["portee"])):
        v = p["portee"] % periode
        groupes = defaultdict(list)
        for n in p["notes"]:
            groupes[round(n["x"] / 2)].append(n)      # même abscisse = accord
        for x in sorted(groupes):
            notes = sorted(groupes[x], key=lambda n: n["step"])
            voix[v].append({
                "steps": tuple(n["step"] for n in notes),
                "alterations": tuple(alteration_de(n["nom"]) for n in notes),
                "ou": f"p{p['page']} portée {p['portee']} x={notes[0]['x']:.0f}",
            })
    return voix


def alteration_de(nom):
    if nom.endswith("is"):
        return 1
    if nom.endswith("es"):
        return -1
    return 0


def lire_musicxml(chemin):
    chemin = Path(chemin)
    if chemin.suffix.lower() == ".mxl":
        with zipfile.ZipFile(chemin) as z:
            nom = next(n for n in z.namelist()
                       if n.endswith(".xml") and not n.startswith("META-INF"))
            racine = ET.fromstring(z.read(nom))
    else:
        racine = ET.parse(chemin).getroot()
    noms = {p.get("id"): (p.findtext("part-name") or "").strip()
            for p in racine.findall("part-list/score-part")}
    parties = {}
    for partie in racine.findall("part"):
        colonnes = []
        for mesure in partie.findall("measure"):
            numero = mesure.get("number")
            for note in mesure.findall("note"):
                hauteur = note.find("pitch")
                if hauteur is None:                    # silence
                    continue
                step = (PAS[hauteur.findtext("step")]
                        + 7 * int(hauteur.findtext("octave")))
                alt = int(float(hauteur.findtext("alter") or 0))
                if note.find("chord") is not None and colonnes:
                    colonnes[-1]["steps"].append(step)
                    colonnes[-1]["alterations"].append(alt)
                else:
                    colonnes.append({"steps": [step], "alterations": [alt],
                                     "ou": f"mesure {numero}"})
        for c in colonnes:
            ordre = sorted(range(len(c["steps"])), key=lambda i: c["steps"][i])
            c["steps"] = tuple(c["steps"][i] for i in ordre)
            c["alterations"] = tuple(c["alterations"][i] for i in ordre)
        parties[partie.get("id")] = {"nom": noms.get(partie.get("id"), ""),
                                     "colonnes": colonnes}
    return parties


def noms_seuls(colonne):
    """Clé d'alignement : les noms de notes, sans l'octave.

    Audiveris n'est pas constant sur l'octave des pupitres en clé de sol
    octaviée — sur le jangadero il donne la hauteur écrite pendant quatre
    notes puis bascule sur la hauteur sonnante pour le reste de la partie.
    Aligner sur les octaves ferait donc échouer l'appariement entier là où
    seule une convention diverge. On aligne sur les noms, et l'octave devient
    une catégorie de désaccord à part.
    """
    return tuple(s % 7 for s in colonne["steps"])


def apparier(voix, parties):
    """Associe chaque voix vectorielle à la partie qui lui ressemble le plus."""
    libres = dict(parties)
    couples, orphelines = [], []
    for v in sorted(voix):
        suite_v = [noms_seuls(c) for c in voix[v]]
        meilleur, score = None, 0.0
        for pid, p in libres.items():
            if not p["colonnes"]:
                continue
            r = SequenceMatcher(
                None, suite_v, [noms_seuls(c) for c in p["colonnes"]],
                autojunk=False).ratio()
            if r > score:
                meilleur, score = pid, r
        if meilleur is None or score < 0.3:
            orphelines.append((v, score))
        else:
            couples.append((v, meilleur, score))
            del libres[meilleur]
    return couples, orphelines, libres


def comparer(colonnes_v, colonnes_a):
    """Désaccords entre deux suites de colonnes, alignées sur les noms de notes.

    Trois sévérités, par ordre de solidité de la source vectorielle. Le **nom**
    de la note vient de l'ordonnée de la tête sur la portée : un désaccord est
    une vraie erreur de l'un des deux. L'**octave** dépend en plus de la clé,
    qu'Audiveris interprète de façon instable sur les pupitres octaviés.
    L'**altération** est déduite de l'armure et des accidents voisins, déduction
    qui ignore qu'un accident vaut jusqu'à la fin de la mesure.
    """
    a = [noms_seuls(c) for c in colonnes_v]
    b = [noms_seuls(c) for c in colonnes_a]
    ecarts = []
    for op, i1, i2, j1, j2 in SequenceMatcher(None, a, b, autojunk=False).get_opcodes():
        if op == "equal":
            for i, j in zip(range(i1, i2), range(j1, j2)):
                if colonnes_v[i]["steps"] != colonnes_a[j]["steps"]:
                    ecarts.append(("octave", colonnes_v[i], colonnes_a[j]))
                elif colonnes_v[i]["alterations"] != colonnes_a[j]["alterations"]:
                    ecarts.append(("altération", colonnes_v[i], colonnes_a[j]))
            continue
        for k in range(max(i2 - i1, j2 - j1)):
            cv = colonnes_v[i1 + k] if i1 + k < i2 else None
            ca = colonnes_a[j1 + k] if j1 + k < j2 else None
            ecarts.append(("note", cv, ca))
    return ecarts


def rendu(colonne):
    if colonne is None:
        return "—"
    noms = []
    for step, alt in zip(colonne["steps"], colonne["alterations"]):
        noms.append(DIATO[step % 7] + str(step // 7)
                    + {1: "is", -1: "es", 0: ""}.get(alt, "?"))
    return "<" + " ".join(noms) + ">" if len(noms) > 1 else noms[0]


def main():
    # La console Windows est en cp1252 : sans cela, la moindre flèche ou
    # lettre accentuée du rapport fait planter l'outil au lieu de l'afficher.
    for flux in (sys.stdout, sys.stderr):
        flux.reconfigure(encoding="utf-8", errors="replace")

    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("json", type=Path, help="sortie de pdfglyphs.py")
    ap.add_argument("musicxml", type=Path, help=".mxl ou .xml d'Audiveris")
    ap.add_argument("--voix", type=int, help="portées par système (sinon déduit)")
    ap.add_argument("--max", type=int, default=40, help="désaccords affichés par voix")
    args = ap.parse_args()

    portees = json.loads(args.json.read_text(encoding="utf8"))
    if not portees:
        sys.exit("JSON vide")
    periode = args.voix or portees[0].get("portees_par_systeme")
    if not periode:
        sys.exit("le JSON ne porte pas `portees_par_systeme` : régénérer "
                 "avec pdfglyphs.py, ou passer --voix")
    print(f"{len(portees)} portées, {periode} par système → {periode} voix"
          + ("" if args.voix else " (déduit des clés par pdfglyphs)"))

    voix = colonnes_vecteur(portees, periode)
    parties = lire_musicxml(args.musicxml)
    couples, orphelines, restantes = apparier(voix, parties)

    for pid, p in restantes.items():
        n = len(p["colonnes"])
        if n:
            print(f"ATTENTION : partie MusicXML {pid} « {p['nom']} » sans "
                  f"correspondant vectoriel ({n} notes) — partie fantôme "
                  f"probable, pupitres non unifiés entre feuilles")
    for v, score in orphelines:
        print(f"ATTENTION : voix {v} sans partie correspondante "
              f"(meilleure ressemblance {score:.0%})")

    total = 0
    for v, pid, score in couples:
        cv, ca = voix[v], parties[pid]["colonnes"]
        ecarts = comparer(cv, ca)
        par_genre = {g: [e for e in ecarts if e[0] == g]
                     for g in ("note", "octave", "altération")}
        total += len(par_genre["note"])
        print(f"\n--- voix {v} ↔ {pid} « {parties[pid]['nom']} » "
              f"(ressemblance {score:.0%}, {len(cv)} vs {len(ca)} colonnes)")
        print("    " + ", ".join(f"{len(v_)} {g}" for g, v_ in par_genre.items()))
        ordonnes = par_genre["note"] + par_genre["octave"] + par_genre["altération"]
        for genre, a, b in ordonnes[:args.max]:
            ou = (a or b)["ou"]
            print(f"    {genre:<10s} {ou:<26s} vectoriel {rendu(a):<14s} "
                  f"OMR {rendu(b)}")
    print(f"\n{total} désaccord(s) de note au total — à relire dans la partition.")


if __name__ == "__main__":
    main()

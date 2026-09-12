#!/usr/bin/env python3
"""Résout les durées d'une partition extraite par `pdfglyphs.py`.

La durée se lit, elle ne se devine pas : le dessin de la tête, le nombre de
crochets portés par la hampe (ligatures comprises) et les points d'augmentation
la déterminent entièrement. La somme de la mesure, que le chiffrage fixe, sert
alors de **contrôle** et non de solveur — si elle ne tombe pas juste, c'est
qu'un signe a été mal lu, et la mesure est signalée.

Une première version se passait des ligatures et cherchait, parmi toutes les
répartitions compatibles avec la somme, celle dont l'espacement horizontal était
le plus vraisemblable. Elle ne tenait pas : sur deux mesures visuellement
identiques de Balderrama elle rendait deux réponses différentes, toutes deux
fausses. L'espacement est un indice trop faible pour départager une croche
d'une double ; la ligature, elle, le dit.

Le solveur par somme subsiste en recours, pour les mesures dont un signe reste
ambigu — le rectangle de silence, qui vaut pause ou demi-pause selon sa
position — et pour signaler celles qui ne tombent pas juste.

    python tools/durees.py notes.json
    python tools/durees.py notes.json --detail --portee 0
"""

import argparse
import json
import sys
from collections import Counter, defaultdict
from fractions import Fraction as F
from pathlib import Path

# Durées de base, exprimées en noires.
RONDE, BLANCHE, NOIRE = F(4), F(2), F(1)
CROCHE, DOUBLE, TRIPLE = F(1, 2), F(1, 4), F(1, 8)

BASES = {
    "tete_blanche": [RONDE, BLANCHE],
    "tete_pleine": [NOIRE, CROCHE, DOUBLE, TRIPLE],
    "ronde": [RONDE],
    "silence_noire": [NOIRE],
    "silence_croche": [CROCHE],
    "silence_double_croche": [DOUBLE],
    "demi_pause": [BLANCHE],
    # La pause tient la mesure entière quel que soit le chiffrage : trois
    # noires en 3/4 comme en 6/8. Sa valeur dépend donc de la mesure et se
    # complète à la lecture.
    "pause": [RONDE],
}
POINTS = {0: F(1), 1: F(3, 2), 2: F(7, 4)}


def duree_lue(e, longueur_mesure):
    """Durée déterminée par le dessin, ou None si le signe reste ambigu."""
    mult = POINTS.get(e["points"], F(1))
    signe = e["signe"]
    if signe == "tete_pleine":
        return NOIRE / (2 ** e["crochets"]) * mult
    if signe == "tete_blanche":
        # une ronde n'a pas de hampe ; une blanche en a une
        return (BLANCHE if e["hampe"] else RONDE) * mult
    if signe == "pause":
        return longueur_mesure * mult
    if signe in BASES:
        return BASES[signe][0] * mult
    return None


def candidats(evenement, longueur_mesure):
    mult = POINTS.get(evenement["points"], F(1))
    bases = list(BASES.get(evenement["signe"], []))
    if evenement["signe"] == "pause":
        bases.append(longueur_mesure)      # pause de mesure entière
    vus, sortie = set(), []
    for b in bases:
        d = b * mult
        if d not in vus and d <= longueur_mesure:
            vus.add(d)
            sortie.append(d)
    return sortie


def solutions(evenements, longueur, plafond=200000):
    """Répartitions de durées dont la somme fait exactement la mesure."""
    listes = [candidats(e, longueur) for e in evenements]
    if any(not c for c in listes):
        return [], True
    trouvees, noeuds = [], 0
    # Bornes de la somme encore atteignable à partir de chaque rang. Les deux
    # servent : la borne haute élague les branches déjà trop courtes, la borne
    # basse celles déjà trop longues. N'élaguer que sur la première laissait
    # exploser les mesures denses du candombe, où chaque double croche ouvre
    # quatre possibilités.
    hautes, basses, hi, lo = [], [], F(0), F(0)
    for c in reversed(listes):
        hi += max(c)
        lo += min(c)
        hautes.append(hi)
        basses.append(lo)
    hautes.reverse()
    basses.reverse()

    def explorer(i, somme, choix):
        nonlocal noeuds
        noeuds += 1
        if noeuds > plafond:
            return
        if i == len(listes):
            if somme == longueur:
                trouvees.append(tuple(choix))
            return
        if somme + hautes[i] < longueur or somme + basses[i] > longueur:
            return
        for d in listes[i]:
            if somme + d <= longueur:
                choix.append(d)
                explorer(i + 1, somme + d, choix)
                choix.pop()

    explorer(0, F(0), [])
    return trouvees, noeuds <= plafond


def cout_espacement(durees, ecarts):
    """Écart au principe « plus c'est long, plus c'est large ».

    On ne modélise pas la loi d'espacement du graveur, qui varie d'un logiciel
    à l'autre et qu'on ne connaît pas ; on compte seulement les inversions,
    c'est-à-dire les paires où la note la plus longue occupe le moins de place.
    Le compte est invariant par toute loi croissante, donc il n'a pas besoin
    d'être calibré.
    """
    inversions = 0
    for i in range(len(durees)):
        for j in range(i + 1, len(durees)):
            if durees[i] == durees[j]:
                continue
            if (durees[i] > durees[j]) != (ecarts[i] > ecarts[j]):
                inversions += 1
    return inversions


def decouper(evenements, barres, fin):
    """Répartit les évènements entre les barres de mesure."""
    mesures, i = [], 0
    for b in list(barres) + [fin]:
        paquet = []
        while i < len(evenements) and evenements[i]["x"] < b:
            paquet.append(evenements[i])
            i += 1
        mesures.append(paquet)
    if i < len(evenements):
        mesures.append(evenements[i:])
    return mesures


def evenements_de(portee):
    """Notes groupées en accords, et silences, dans l'ordre de lecture."""
    par_x = {}
    for n in portee["notes"]:
        cle = round(n["x"] / 2)
        e = par_x.setdefault(cle, {"x": n["x"], "signe": n["tete"], "points": n["points"],
                                   "crochets": n.get("crochets", 0),
                                   "hampe": n.get("hampe"), "notes": []})
        e["notes"].append(n["nom"])
        if n["tete"] in ("tete_blanche", "ronde"):   # dans un accord, la plus longue commande
            e["signe"] = n["tete"]
        e["points"] = max(e["points"], n["points"])
        e["crochets"] = max(e["crochets"], n.get("crochets", 0))
        e["hampe"] = e["hampe"] or n.get("hampe")
    for s in portee.get("silences", []):
        par_x[round(s["x"] / 2) + 100000] = {
            "x": s["x"], "signe": s["silence"], "points": s["points"],
            "crochets": 0, "hampe": None, "notes": []}
    return sorted(par_x.values(), key=lambda e: e["x"])


def analyser(portee, longueur):
    """Rend, mesure par mesure, l'état de la résolution."""
    debut_du_morceau = portee.get("page") == 1 and portee.get("systeme") == 0
    evs = evenements_de(portee)
    if not evs:
        return []
    fin = max(e["x"] for e in evs) + 1e6
    sortie = []
    for rang, mesure in enumerate(decouper(evs, portee["barres"], fin)):
        if not mesure:
            continue
        xs = [e["x"] for e in mesure]
        suivantes = [b for b in portee["barres"] if b > xs[-1]]
        bord = suivantes[0] if suivantes else xs[-1] + 20
        ecarts = [b - a for a, b in zip(xs, xs[1:])] + [bord - xs[-1]]
        lues = [duree_lue(e, longueur) for e in mesure]
        if all(d is not None for d in lues):
            somme = sum(lues, F(0))
            if somme == longueur:
                sortie.append({"rang": rang, "mesure": mesure, "etat": "lue",
                               "durees": tuple(lues), "candidates": 1,
                               "somme": somme})
                continue
            if rang == 0 and somme < longueur and debut_du_morceau:
                # Une levée est légitimement plus courte que la mesure, mais
                # il n'y en a qu'une, au tout début. Ailleurs, la première
                # mesure d'un système suit une barre comme les autres : la
                # tolérer partout faisait passer pour des levées sept mesures
                # du candombe qui étaient de vraies erreurs de lecture.
                sortie.append({"rang": rang, "mesure": mesure, "etat": "levée",
                               "durees": tuple(lues), "candidates": 1,
                               "somme": somme})
                continue
        somme_lue = (sum(lues, F(0)) if all(d is not None for d in lues) else None)
        sols, complet = solutions(mesure, longueur)
        if not complet:
            etat, durees = "explosif", None
        elif not sols:
            etat, durees = "somme fausse", None
        elif len(sols) == 1:
            etat, durees = "unique par somme", sols[0]
        else:
            classees = sorted(sols, key=lambda d: cout_espacement(d, ecarts))
            proches = [d for d in classees
                       if cout_espacement(d, ecarts) == cout_espacement(classees[0], ecarts)]
            etat = "ambigu" if len(proches) > 1 else "par espacement"
            durees = classees[0]
        sortie.append({"rang": rang, "mesure": mesure, "etat": etat,
                       "durees": durees, "candidates": len(sols),
                       "somme": somme_lue})
    return sortie


def par_voix(portees, longueur):
    """Analyse la partition voix par voix, dans l'ordre de lecture.

    Le regroupement par voix n'est pas un confort d'affichage : deux mesures
    ne peuvent être confrontées l'une à l'autre qu'à l'intérieur d'une même
    voix, et c'est ce qui permet de reconnaître la mesure de clôture.
    """
    periode = portees[0]["portees_par_systeme"]
    voix = {}
    for p in sorted(portees, key=lambda p: (p["page"], p["portee"])):
        voix.setdefault(p["portee"] % periode, []).append(p)
    for v, suite in sorted(voix.items()):
        mesures = [(p, m) for p in suite for m in analyser(p, longueur)]
        if not mesures:
            continue
        # Quand le morceau commence par une levée et se termine sur une
        # reprise, la dernière mesure est écourtée d'autant : les deux
        # réunies font une mesure pleine. Le candombe finit ainsi sur 3,25
        # noires pour une levée de 0,75 — lecture juste, somme apparemment
        # fausse.
        levee = next((m["somme"] for _, m in mesures if m["etat"] == "levée"), None)
        if levee:
            p, m = mesures[-1]
            if m["etat"] == "somme fausse" and m["somme"] is not None                     and m["somme"] + levee == longueur:
                m["etat"] = "clôture"
                m["durees"] = tuple(duree_lue(e, longueur) for e in m["mesure"])
        for p, m in mesures:
            yield v, p, m


def concordance(portees, longueur):
    """Nombre de mesures par système, voix par voix.

    Contrôle complémentaire de celui de la somme, et il attrape ce que
    l'autre ne peut pas voir : une mesure entièrement perdue. Un système est
    barré d'un seul tenant, donc ses voix ont le même nombre de mesures ; une
    voix qui en compte une de moins a perdu tout le contenu d'une mesure, et
    la somme ne s'en plaint pas puisqu'il ne reste rien à sommer. C'est ainsi
    qu'on a retrouvé les rondes du candombe, dont le glyphe manquait à la
    table : deux mesures de ténor vides, et pas une alerte ailleurs.
    """
    par_systeme = defaultdict(Counter)
    for v, p, m in par_voix(portees, longueur):
        par_systeme[v][(p["page"], p["systeme"])] += 1
    suites = {v: [n for _, n in sorted(c.items())] for v, c in par_systeme.items()}
    reference = suites[min(suites)]
    return reference, {v: s for v, s in suites.items() if s != reference}


def main():
    for flux in (sys.stdout, sys.stderr):
        flux.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("json", type=Path)
    ap.add_argument("--portee", type=int, help="n'examiner qu'un pupitre (0 = le premier)")
    ap.add_argument("--detail", action="store_true", help="détailler chaque mesure")
    ap.add_argument("--page", type=int, help="n'examiner qu'une page")
    args = ap.parse_args()

    portees = json.loads(args.json.read_text(encoding="utf8"))
    chiffrage = next((p["chiffrage"] for p in portees if p.get("chiffrage")), None)
    if not chiffrage:
        sys.exit("aucun chiffrage trouvé dans le JSON")
    longueur = F(chiffrage[0] * 4, chiffrage[1])
    print(f"chiffrage {chiffrage[0]}/{chiffrage[1]} → mesure de {longueur} noire(s)")

    bilan = Counter()
    for v, p, m in par_voix(portees, longueur):
        if args.portee is not None and v != args.portee:
            continue
        if args.page is not None and p["page"] != args.page:
            continue
        bilan[m["etat"]] += 1
        if args.detail:
            signes = " ".join(e["signe"].replace("silence_", "r:")
                              .replace("tete_", "") for e in m["mesure"])
            print(f"  p{p['page']} voix {v} portée {p['portee']} mes.{m['rang']} "
                  f"[{signes}] → {m['etat']}"
                  + (f" ({m['candidates']} candidates)" if m["candidates"] > 1 else ""))
            if m["durees"]:
                print(f"       {' '.join(str(d) for d in m['durees'])}")

    reference, ecarts = concordance(portees, longueur)
    print(f"\nmesures par système : {reference} — {sum(reference)} par voix")
    for v, suite in sorted(ecarts.items()):
        print(f"ATTENTION : la voix {v} n'a pas le même découpage : {suite} — "
              f"une mesure y est vide, donc perdue")

    total = sum(bilan.values())
    print(f"{total} mesures analysées")
    for cle in ("lue", "levée", "clôture", "unique par somme", "par espacement",
                "ambigu", "somme fausse", "explosif"):
        if bilan[cle]:
            print(f"   {bilan[cle]:5d}  {cle:16s} {bilan[cle] / total:6.1%}")


if __name__ == "__main__":
    main()

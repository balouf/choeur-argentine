# /// script
# requires-python = ">=3.11"
# dependencies = ["pdfplumber", "pillow"]
# ///
"""Extrait les hauteurs exactes d'un PDF de partition produit par un éditeur.

Les PDF sortis de Sibelius, Finale ou consorts ne contiennent pas une image de la
partition : les têtes de notes y sont des glyphes d'une police musicale, posés à
des coordonnées exactes, et les lignes de portée sont des traits vectoriels. La
hauteur d'une note est donc une simple division — pas une reconnaissance de forme.

C'est précisément la grandeur que l'OMR rate en silence (une fausse note sonne,
elle ne fait pas échouer la compilation, là où une fausse durée est attrapée par
les contrôles de mesure de LilyPond). D'où cet outil : il ne sort que ce qui est
exact — géométrie des portées et suite des têtes de notes — et laisse durées,
voix et liaisons au moteur OMR, pour que `pitchdiff.py` confronte les deux.

    uv run tools/pdfglyphs.py partition.pdf --codes        # relever l'encodage
    uv run tools/pdfglyphs.py partition.pdf -o notes.json
    uv run tools/pdfglyphs.py partition.pdf --overlay v.png --pages 1

L'overlay est la vérification : chaque tête détectée y est cerclée sur le rendu.
Un cercle sur un silence ou une tête sans cercle se voient d'un coup d'œil.
"""

import argparse
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

import pdfplumber

DIATO = "CDEFGAB"
ORDRE_DIESES = [3, 0, 4, 1, 5, 2, 6]     # fa do sol ré la mi si
ORDRE_BEMOLS = [6, 2, 5, 1, 4, 0, 3]     # si mi la ré sol do fa

# Deux dispositions de police coexistent dans le corpus, et elles ne se
# recouvrent pas : le même code y désigne des symboles différents (0x62 vaut
# bémol chez Maestro et tête d'agrément chez l'Opus symbolique). D'où deux
# tables distinctes, et non une table commune avec un décalage.
LEGACY = {          # Maestro (Finale), Opus (Sibelius), sous-polices Ghostscript
    0x153: "tete_pleine",
    0x2D9: "tete_blanche",
    0x2030: "silence_croche",
    0x152: "silence_noire",
    0x23: "diese",
    0x62: "bemol",
    0x6E: "becarre",
    0x2E: "point",
    0x26: "cle_sol",
    0x56: "cle_sol8",   # clé de sol octaviée : un glyphe à part, pas sol + « 8 »
    0x3F: "cle_fa",
}
SYMBOLIQUE = {      # police symbolique, codes décalés de 0xF000
    0xCF: "tete_pleine",
    0xFA: "tete_blanche",
    0x62: "tete_agrement",
    0xCE: "silence_noire",
    0x23: "diese",
    0x2E: "point",
    0x26: "cle_sol",
    0x3F: "cle_fa",
}
# Deux entrées ont d'abord été devinées, et les deux étaient fausses : 0x2030
# passait pour une tête blanche (c'est un soupir de croche, toujours sur la
# ligne médiane) et 0x62 pour un bémol (c'est une acciaccatura, collée à gauche
# d'une vraie tête, même hauteur). Un symbole plausible par la largeur et la
# fréquence ne l'est pas par la position. D'où la règle : toute entrée ajoutée
# ici se vérifie avec --overlay avant d'être crue.
TETES = {"tete_pleine", "tete_blanche", "ronde"}
ALTERATIONS = {"diese": 1, "bemol": -1, "becarre": 0}

# Ligne du bas de la portée, en degrés diatoniques au-dessus de do0.
BASE_CLE = {
    "sol": 4 * 7 + 2,        # mi3  (E4)
    "sol8": 3 * 7 + 2,       # mi2  (E3) — ténors, clé de sol octaviée
    "fa": 2 * 7 + 4,         # sol1 (G2)
}


def nom(step, alteration=0):
    lettre = DIATO[step % 7]
    suffixe = {1: "is", -1: "es", 0: ""}[alteration]
    return f"{lettre}{step // 7}{suffixe}"


def codes_police(page, motif=None):
    """Distribution des codes de glyphes, pour établir la table d'une police."""
    chars = [c for c in page.chars if motif is None or motif.lower() in c["fontname"].lower()]
    return Counter((c["fontname"], ord(c["text"])) for c in chars)


def police_musicale(page):
    """Police musicale et disposition : celle qui porte le plus de têtes de notes."""
    scores = Counter()
    for c in page.chars:
        code = ord(c["text"])
        if LEGACY.get(code) in TETES:
            scores[(c["fontname"], "legacy")] += 1
        elif code >= 0xF000 and SYMBOLIQUE.get(code - 0xF000) in TETES:
            scores[(c["fontname"], "symbolique")] += 1
    if not scores:
        return None, LEGACY
    (fonte, disposition), _ = scores.most_common(1)[0]
    return fonte, (SYMBOLIQUE if disposition == "symbolique" else LEGACY)


def symbole(c, table):
    """Nom du symbole porté par un glyphe, ou None."""
    code = ord(c["text"])
    if table is SYMBOLIQUE:
        return table.get(code - 0xF000) if code >= 0xF000 else None
    return table.get(code)


def traits_horizontaux(page, largeur_min=0.35, epaisseur_max=3.0, fusion=1.2):
    """Ordonnées des lignes de portée, quelle que soit la façon de les dessiner.

    Trois graveurs, trois façons : Finale sort des `lines` d'épaisseur nulle,
    OpenOffice des `rects` de 0,6 pt, et le redistillage Ghostscript empile des
    centaines de filets décalés de 0,06 pt qu'il faut refondre en une ligne.
    """
    seuil = page.width * largeur_min
    ys = []
    for o in list(page.lines) + list(page.rects):
        if o["width"] > seuil and o["height"] <= epaisseur_max:
            ys.append((o["top"] + o["bottom"]) / 2)
    if not ys:
        return []
    ys.sort()
    fusionnees, paquet = [], [ys[0]]
    for y in ys[1:]:
        if y - paquet[0] <= fusion:
            paquet.append(y)
        else:
            fusionnees.append(sum(paquet) / len(paquet))
            paquet = [y]
    fusionnees.append(sum(paquet) / len(paquet))
    return fusionnees


def portees(page, ecart_max=None):
    """Regroupe les lignes en portées de cinq."""
    ys = traits_horizontaux(page)
    if len(ys) < 5:
        return []
    if ecart_max is None:
        # l'interligne est l'écart le plus fréquent entre lignes voisines ;
        # au-delà de deux fois cet écart, on a changé de portée
        ecarts = sorted(b - a for a, b in zip(ys, ys[1:]))
        median = ecarts[len(ecarts) // 2]
        ecart_max = median * 1.8
    groupes, courant = [], [ys[0]]
    for y in ys[1:]:
        if y - courant[-1] <= ecart_max:
            courant.append(y)
        else:
            groupes.append(courant)
            courant = [y]
    groupes.append(courant)
    return [g for g in groupes if len(g) == 5]


def y_baseline(page, c):
    """Ordonnée (origine en haut) de la baseline du glyphe = centre de la tête."""
    return page.height - c["matrix"][5]


def cle_de(page, glyphes_portee, bas, interligne, table, taille_musique):
    """Type de clé de la portée.

    Deux graveurs, deux conventions pour la clé des ténors : Maestro a un glyphe
    dédié pour la clé de sol octaviée, tandis qu'Opus pose un « 8 » sous une clé
    de sol ordinaire — et ce « 8 » appartient à une *autre* police que les têtes
    de notes (OpusSpecial), donc il faut le chercher hors de la police musicale.
    On le reconnaît à sa taille : celle des glyphes musicaux, pas des paroles.
    """
    cles = [c for c in glyphes_portee
            if symbole(c, table) in ("cle_sol", "cle_sol8", "cle_fa")]
    if not cles:
        return "sol"
    c = min(cles, key=lambda c: c["x0"])
    sym = symbole(c, table)
    if sym == "cle_fa":
        return "fa"
    if sym == "cle_sol8":
        return "sol8"
    # Le « 8 » se tient juste sous la portée, dans l'axe de la clé. La fenêtre
    # doit être bornée des deux côtés : les clés de toutes les portées sont
    # alignées sur la même abscisse, donc sans borne basse on attrape celle de
    # la portée suivante et tout devient octavié.
    x0, x1 = c["x0"] - 1, c["x1"] + 1
    for g in page.chars:
        if not (x0 < (g["x0"] + g["x1"]) / 2 < x1):
            continue
        if not (bas + 0.5 * interligne < y_baseline(page, g) < bas + 3 * interligne):
            continue
        if symbole(g, table) in TETES:      # une note sur ligne supplémentaire
            continue
        if abs(g["size"] - taille_musique) < 0.25 * taille_musique:
            return "sol8"
    return "sol"


def armure_de(glyphes_portee, x_cle, x_premiere_tete, table):
    """Altérations de l'armure, par comptage dans l'ordre canonique.

    Renvoie aussi l'abscisse de fin de l'armure : ses dièses sont des glyphes
    d'altération comme les autres, et le dernier d'entre eux se retrouve collé
    à la première note quand aucun chiffrage ne les sépare (systèmes 2 et
    suivants). Sans cette borne il est pris pour une altération accidentelle.
    """
    entre = [
        c for c in glyphes_portee
        if x_cle < c["x0"] < x_premiere_tete and symbole(c, table) in ("diese", "bemol")
    ]
    x_fin = max((c["x1"] for c in entre), default=x_cle)
    dieses = sum(1 for c in entre if symbole(c, table) == "diese")
    bemols = sum(1 for c in entre if symbole(c, table) == "bemol")
    armure = {}
    for i in range(min(dieses, 7)):
        armure[ORDRE_DIESES[i]] = 1
    for i in range(min(bemols, 7)):
        armure[ORDRE_BEMOLS[i]] = -1
    return armure, x_fin


def codes_suspects(page, seuil_occurrences=5, seuil_hauteurs=4):
    """Codes non répertoriés qui se comportent comme des têtes de notes.

    Deux propriétés y suffisent : la tête se promène en hauteur (un silence ou
    une clé reste posé au même endroit) et elle tombe sur la grille des
    demi-interlignes (un accent se place à un décalage quelconque).

    Un crochet de croche passe parfois ces deux tests et sera signalé à tort ;
    une vérification visuelle par partition est le prix à payer. Une troisième
    condition « n'est pas attaché à une hampe voisine » l'écartait bien, mais
    écartait aussi les blanches, qui en écriture dense ont presque toujours une
    autre tête proche en abscisse et éloignée en ordonnée — le filet ne
    rattrapait alors plus rien. Mieux vaut une alerte de trop qu'un garde-fou
    qui se tait : sans lui, un trou dans la table reste invisible tant qu'aucune
    partition n'exhibe le symbole manquant, ce qui est exactement ce qui est
    arrivé à la blanche d'Opus, absente d'une partition entièrement en croches.
    """
    staves = portees(page)
    fonte, table = police_musicale(page)
    if not staves or not fonte:
        return []
    niveaux = defaultdict(set)
    effectifs = Counter()
    sur_grille = Counter()
    for c in page.chars:
        if c["fontname"] != fonte or symbole(c, table) is not None:
            continue
        y = y_baseline(page, c)
        for st in staves:
            haut, bas = st[0], st[-1]
            demi = (bas - haut) / 8
            if not (haut - 8 * demi < y < bas + 8 * demi):
                continue
            code = ord(c["text"])
            niv = (bas - y) / demi
            effectifs[code] += 1
            niveaux[code].add(round(niv))
            if abs(niv - round(niv)) < 0.15:
                sur_grille[code] += 1
            break
    return sorted(
        (code, effectifs[code], len(niveaux[code]))
        for code in effectifs
        if effectifs[code] >= seuil_occurrences
        and len(niveaux[code]) >= seuil_hauteurs
        and sur_grille[code] >= 0.9 * effectifs[code]
    )


def lire_page(page, numero):
    staves = portees(page)
    if not staves:
        return []
    fonte, table = police_musicale(page)
    glyphes = [c for c in page.chars if c["fontname"] == fonte] if fonte else []
    if not glyphes:
        return []
    taille_musique = Counter(round(c["size"], 1) for c in glyphes).most_common(1)[0][0]

    resultat = []
    for idx, st in enumerate(staves):
        haut, bas = st[0], st[-1]
        interligne = (bas - haut) / 4
        demi = interligne / 2
        # Un glyphe appartient à la portée si sa baseline tombe dans la bande
        # élargie de quatre interlignes (lignes supplémentaires comprises).
        bande = [
            c for c in glyphes
            if haut - 4 * interligne < y_baseline(page, c) < bas + 4 * interligne
        ]
        bande.sort(key=lambda c: c["x0"])

        têtes = [c for c in bande if symbole(c, table) in TETES]
        if not têtes:
            continue
        cle = cle_de(page, bande, bas, interligne, table, taille_musique)
        cles = [c for c in bande if symbole(c, table) in ("cle_sol", "cle_sol8", "cle_fa")]
        x_cle = min(c["x1"] for c in cles) if cles else bande[0]["x0"]
        armure, x_fin_armure = armure_de(bande, x_cle, têtes[0]["x0"], table)
        base = BASE_CLE[cle]

        accidentelles = [
            c for c in bande
            if symbole(c, table) in ALTERATIONS and c["x0"] > x_fin_armure
        ]
        notes = []
        for c in têtes:
            y = y_baseline(page, c)
            step = base + round((bas - y) / demi)
            # une altération accidentelle est collée à gauche, à la même hauteur
            alt = None
            for a in accidentelles:
                if (0 < c["x0"] - a["x1"] < 2.2 * interligne
                        and abs(y_baseline(page, a) - y) < demi):
                    alt = ALTERATIONS[symbole(a, table)]
            if alt is None:
                alt = armure.get(step % 7, 0)
            notes.append({
                "x": round(c["x0"], 2),
                "y": round(y, 2),
                "step": step,
                "nom": nom(step, alt),
                "tete": symbole(c, table),
            })
        resultat.append({
            "page": numero,
            "portee": idx,
            "y_haut": round(haut, 2),
            "y_bas": round(bas, 2),
            "interligne": round(interligne, 3),
            "cle": cle,
            "armure_dieses": sum(1 for v in armure.values() if v > 0),
            "armure_bemols": sum(1 for v in armure.values() if v < 0),
            "notes": notes,
        })
    return resultat


def dessiner_overlay(pdf_path, pages, sortie, dpi=300):
    """Cercle chaque tête détectée sur le rendu — la vérification à l'œil."""
    import subprocess
    import tempfile

    from PIL import Image, ImageDraw

    echelle = dpi / 72
    with tempfile.TemporaryDirectory() as tmp:
        gabarit = str(Path(tmp) / "p%d.png")
        subprocess.run(
            ["gswin64c" if sys.platform == "win32" else "gs",
             "-q", "-dNOPAUSE", "-dBATCH", "-sDEVICE=png16m", f"-r{dpi}",
             f"-dFirstPage={pages[0]}", f"-dLastPage={pages[-1]}",
             f"-sOutputFile={gabarit}", str(pdf_path)],
            check=True,
        )
        rendus = sorted(Path(tmp).glob("p*.png"), key=lambda p: int(p.stem[1:]))
        with pdfplumber.open(pdf_path) as pdf:
            vignettes = []
            for rendu, no in zip(rendus, pages):
                page = pdf.pages[no - 1]
                img = Image.open(rendu).convert("RGB")
                d = ImageDraw.Draw(img)
                for st in lire_page(page, no):
                    for n in st["notes"]:
                        x = n["x"] * echelle
                        y = n["y"] * echelle
                        d.ellipse([x - 2, y - 9, x + 16, y + 9],
                                  outline=(220, 0, 0), width=3)
                vignettes.append(img)
        if len(vignettes) == 1:
            vignettes[0].save(sortie)
        else:
            largeur = max(i.width for i in vignettes)
            hauteur = sum(i.height for i in vignettes)
            planche = Image.new("RGB", (largeur, hauteur), "white")
            y = 0
            for i in vignettes:
                planche.paste(i, (0, y))
                y += i.height
            planche.save(sortie)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("pdf", type=Path)
    ap.add_argument("-o", "--out", type=Path, help="sortie JSON (défaut : stdout)")
    ap.add_argument("--pages", help="pages, ex. 1 ou 1-3 (défaut : toutes)")
    ap.add_argument("--overlay", type=Path, help="PNG de vérification")
    ap.add_argument("--codes", action="store_true",
                    help="relever l'encodage de la police au lieu d'extraire")
    ap.add_argument("--resume", action="store_true", help="résumé lisible sur stdout")
    args = ap.parse_args()

    with pdfplumber.open(args.pdf) as pdf:
        if args.pages:
            a, _, b = args.pages.partition("-")
            pages = list(range(int(a), int(b or a) + 1))
        else:
            pages = list(range(1, len(pdf.pages) + 1))

        if args.codes:
            fonte, table = police_musicale(pdf.pages[pages[0] - 1])
            print(f"police musicale détectée : {fonte}")
            for (f, code), n in codes_police(pdf.pages[pages[0] - 1]).most_common(20):
                if f != fonte:
                    continue
                sym = table.get(code) or table.get(code - 0xF000) or "?"
                print(f"  {hex(code):>8s}  n={n:5d}  {sym}")
            return

        staves = []
        suspects = {}
        for no in pages:
            staves.extend(lire_page(pdf.pages[no - 1], no))
            for code, n, h in codes_suspects(pdf.pages[no - 1]):
                a, b = suspects.get(code, (0, 0))
                suspects[code] = (a + n, max(b, h))

    for code, (n, h) in sorted(suspects.items()):
        print(f"ATTENTION : code {hex(code)} non répertorié, {n} occurrences sur "
              f"{h} hauteurs distinctes — probablement une tête de note manquante",
              file=sys.stderr)

    if args.resume:
        for st in staves:
            print(f"p{st['page']} portée {st['portee']} clé={st['cle']} "
                  f"#{st['armure_dieses']} b{st['armure_bemols']} "
                  f"({len(st['notes'])} notes)")
            print("   ", " ".join(n["nom"] for n in st["notes"]))
    else:
        texte = json.dumps(staves, ensure_ascii=False, indent=1)
        if args.out:
            args.out.write_text(texte, encoding="utf8")
            n = sum(len(s["notes"]) for s in staves)
            print(f"{len(staves)} portées, {n} notes → {args.out}")
        else:
            print(texte)

    if args.overlay:
        dessiner_overlay(args.pdf, pages, args.overlay)
        print(f"overlay → {args.overlay}")


if __name__ == "__main__":
    main()

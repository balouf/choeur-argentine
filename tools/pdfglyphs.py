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
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path
from statistics import median

import pdfplumber

DIATO = "CDEFGAB"
ORDRE_DIESES = [3, 0, 4, 1, 5, 2, 6]     # fa do sol ré la mi si
ORDRE_BEMOLS = [6, 2, 5, 1, 4, 0, 3]     # si mi la ré sol do fa

# Deux dispositions coexistent dans le corpus. Le même *numéro* y désigne des
# symboles différents — 0x62 vaut bémol chez Maestro et tête d'agrément chez
# l'Opus symbolique — mais les codes, eux, ne se recouvrent jamais : le second
# s'écrit 0xF062. C'est donc le code du glyphe, et non la police qui le porte,
# qui dit dans quelle table le chercher (voir `decoder`).
LEGACY = {          # Maestro (Finale), Opus (Sibelius), sous-polices Ghostscript
    0x153: "tete_pleine",
    0x2D9: "tete_blanche",
    0x77: "ronde",
    0x2030: "silence_croche",
    0x152: "silence_noire",
    0x2248: "silence_double_croche",
    0xD3: "demi_pause",
    0x2211: "pause",               # sert aussi de pause de mesure entière
    0x23: "diese",
    0x62: "bemol",
    0x6E: "becarre",
    0x2E: "point",
    0x2122: "point",    # point d'augmentation, dans la police d'ornements
    0x26: "cle_sol",
    0x56: "cle_sol8",   # clé de sol octaviée : un glyphe à part, pas sol + « 8 »
    0x3F: "cle_fa",
    0x6A: "crochet",    # crochet de croche, hampe en haut
    0x4A: "crochet",    # idem, hampe en bas
}
SYMBOLIQUE = {      # police symbolique, codes décalés de 0xF000
    0xCF: "tete_pleine",
    0xFA: "tete_blanche",
    0x77: "ronde",
    0x6E: "becarre",
    0x62: "bemol",
    0xCE: "silence_noire",
    0xB7: "pause",                 # sert aussi de pause de mesure entière
    0xEE: "demi_pause",
    0xAA: "point",      # point d'augmentation, dans la police d'ornements
    0x23: "diese",
    0x2E: "point",
    0x26: "cle_sol",
    0x3F: "cle_fa",
    0x6A: "crochet",
    0x4A: "crochet",
}
# 0x2030 a d'abord été deviné tête blanche : c'est un soupir de croche, toujours
# sur la ligne médiane. Un symbole plausible par la largeur et la fréquence ne
# l'est pas par la position. D'où la règle : toute entrée ajoutée ici se vérifie
# avec --overlay avant d'être crue.
#
# 0xF062 a été retourné deux fois, et la position ne pouvait pas trancher : une
# acciaccatura comme un bémol se collent à gauche d'une tête, à la même bande
# d'ordonnées. Ce qui tranche est que les deux hauteurs **coïncident** — sur le
# jangadero, 26 fois sur 29 le glyphe est exactement à la hauteur de la tête
# qu'il précède, ce qui ne veut rien dire d'un ornement et tout d'une
# altération. Le rendu de la zone le confirme à l'œil : c'est un bémol.
TETES = {"tete_pleine", "tete_blanche", "ronde"}
SILENCES = {"silence_noire", "silence_croche", "silence_double_croche",
            "pause", "demi_pause"}
ALTERATIONS = {"diese": 1, "bemol": -1, "becarre": 0}
# Symboles qu'aucune police de texte ne produit par accident, contrairement
# aux altérations et au point, qui sont des lettres ordinaires.
DISCRIMINANTS = TETES | SILENCES | {"cle_sol", "cle_sol8", "cle_fa"}
# Les chiffres du chiffrage sont les codes ASCII ordinaires dans les deux
# dispositions ; inutile de les lister un par un dans les tables.
CHIFFRES = {0x30 + i: str(i) for i in range(10)}


# La police de **texte musical** que chaque graveur adjoint à sa police de
# notation : `EngraverFontSet` chez Finale, `OpusText` chez Sibelius, une
# sous-police anonyme chez Ghostscript. Elle est gravée au corps du texte, donc
# l'admission par le corps l'écarte à raison — ses lettres ne sont pas des
# notes — mais elle porte les nuances, la marque d'élision et le métronome.
# Elle se reconnaît à son répertoire, qui tient dans une poignée de signes là
# où la moindre police de paroles en aligne cinquante.
ALPHABET_MUSICAL = set("fmpszr") | set("qI_.= ") | set("0123456789")
NUANCES = {"ppppp", "pppp", "ppp", "pp", "p", "mp", "mf", "f", "ff", "fff",
           "ffff", "fffff", "fp", "sf", "sff", "sp", "spp", "sfz", "rfz"}


def polices_texte_musical(page, tables):
    """Polices de texte musical : répertoire entier dans l'alphabet des signes.

    Le critère est l'ensemble des glyphes employés, pas le nom : `Fine` du
    candombe ajoute un `e`, un `i` et un `n` à ses chiffres, et sort donc de
    l'alphabet — c'est une police de titres, pas de nuances.
    """
    repertoire = defaultdict(set)
    for c in page.chars:
        if c["fontname"] not in tables:
            repertoire[c["fontname"]].add(c["text"])
    return {police for police, chars in repertoire.items()
            if chars and chars <= ALPHABET_MUSICAL}


def nuances_de(page, polices, ecart=0.6):
    """Les nuances de la page : `{x, y, texte}`, avant attribution aux portées.

    Une nuance est une suite horizontale de lettres collées — `pp`, `mf`,
    `sfz`. Le reste de la police (le `q` du métronome, le `_` de l'élision,
    les chiffres) n'en est pas, et la liste blanche des nuances de LilyPond
    suffit à l'écarter.
    """
    lettres = [c for c in page.chars
               if c["fontname"] in polices and c["text"] in "fmpszr"]
    sortie = []
    for groupe in fusionner(lettres, lambda c: c["top"], 2.0):
        mot, debut, fin = "", None, None
        for c in sorted(groupe, key=lambda c: c["x0"]):
            if mot and c["x0"] - fin > ecart:
                if mot in NUANCES:
                    sortie.append({"x": round(debut, 2), "y": round(haut, 2),
                                   "texte": mot})
                mot = ""
            if not mot:
                debut, haut = c["x0"], c["top"]
            mot += c["text"]
            fin = c["x1"]
        if mot in NUANCES:
            sortie.append({"x": round(debut, 2), "y": round(haut, 2),
                           "texte": mot})
    return sortie


def decoder(code):
    """Symbole porté par un code de glyphe, ou None.

    L'encodage est une propriété du glyphe, pas de la police : au-delà de
    0xF000 il est symbolique, en deçà il est textuel. Une même sous-police
    peut porter les deux — un des trois Maestro de Balderrama grave ses
    pauses en 0x2211 et ses demi-pauses en 0xF0EE — et trancher une fois pour
    toute la police en perdait la moitié.
    """
    if code >= 0xF000:
        return SYMBOLIQUE.get(code - 0xF000)
    return LEGACY.get(code)


def chiffre(c, tables):
    """Valeur du chiffre porté par un glyphe de police musicale, ou None."""
    if c["fontname"] not in tables:
        return None
    code = ord(c["text"])
    if code >= 0xF000:
        code -= 0xF000
    return CHIFFRES.get(code)


def chiffrage_de(page, bande, bas, demi, x_max, tables):
    """Chiffrage de la mesure : (numérateur, dénominateur), ou None.

    Les deux chiffres se superposent à la même abscisse, le numérateur dans
    la moitié haute de la portée et le dénominateur dans la basse.
    """
    chiffres = sorted(((c, v) for c in bande
                       for v in [chiffre(c, tables)]
                       if v is not None and c["x0"] <= x_max),
                      key=lambda cv: cv[0]["x0"])
    # Regrouper par proximité, et non en arrondissant : les deux chiffres du
    # jangadero sont à 163,30 et 163,60, que tout découpage en cases fixes
    # finit par séparer au mauvais endroit.
    colonne = []
    for cv in chiffres:
        if colonne and cv[0]["x0"] - colonne[0][0]["x0"] > 3.0:
            if len(colonne) >= 2:
                break
            colonne = []
        colonne.append(cv)
    if len(colonne) < 2:
        return None
    colonne.sort(key=lambda cv: (bas - y_baseline(page, cv[0])) / demi, reverse=True)
    return int(colonne[0][1]), int(colonne[-1][1])

# Pause et demi-pause se ressemblent — deux rectangles que seule leur position
# sur la portée sépare à l'œil — mais elles ont bien deux codes distincts dans
# chaque police, et c'est le code qui les départage, pas l'ordonnée : la
# baseline des deux glyphes est posée sur la ligne médiane, donc la position
# transmise par le PDF est la même pour les deux.
# Quel code vaut quoi a été établi, et non deviné : dans les mesures où toutes
# les autres durées se lisent, le résidu vaut la mesure entière pour 0x2211 /
# 0xB7 (4 noires en 4/4, 3 en 3/4 comme en 6/8) et deux noires pour 0xD3 /
# 0xEE, sur les quatre partitions du corpus.

# Ligne du bas de la portée, en degrés diatoniques au-dessus de do0.
# Ce sont des hauteurs *écrites* : la clé de sol octaviée des ténors partage
# la base de la clé de sol, et son octave est reportée à part, dans le champ
# `octave` de la portée. C'est la seule convention sur laquelle les deux
# sources peuvent s'accorder — Audiveris donne lui aussi la position sur la
# portée — et c'est celle des .ly du dépôt, qui écrivent le ténor en clé de
# sol simple. Transposer ici ferait diverger 30 notes par page pour rien.
BASE_CLE = {
    "sol": 4 * 7 + 2,        # mi3  (E4)
    "sol8": 4 * 7 + 2,
    "fa": 2 * 7 + 4,         # sol1 (G2)
}
OCTAVE_CLE = {"sol": 0, "sol8": -1, "fa": 0}


def nom(step, alteration=0):
    lettre = DIATO[step % 7]
    suffixe = {1: "is", -1: "es", 0: ""}[alteration]
    return f"{lettre}{step // 7}{suffixe}"


def enharmonie(step, alteration, bemols_armure):
    """Ramène au nom usuel les enharmonies que la tonalité rend absurdes.

    Un fa bémol sous une armure de dièses n'est pas une orthographe, c'est le
    reste d'une transposition faite sur les degrés sans regarder la tonalité :
    il se lit mi. Un do bémol de même se lit si, une octave plus bas — `step`
    étant un indice diatonique continu, l'octave suit toute seule.

    Le miroir vaut pour un mi dièse ou un si dièse sous une armure de bémols.
    Hors de ces deux cas on ne touche à rien : les mi dièses de Balderrama et
    le si dièse de Caminito sont écrits ainsi par leurs graveurs, et c'est la
    bonne orthographe de leur sensible sous trois et quatre dièses.
    """
    lettre = DIATO[step % 7]
    if alteration == -1 and not bemols_armure and lettre in ("F", "C"):
        return step - 1, 0
    if alteration == 1 and bemols_armure and lettre in ("E", "B"):
        return step + 1, 0
    return step, alteration


def codes_police(page, motif=None):
    """Distribution des codes de glyphes, pour établir la table d'une police."""
    chars = [c for c in page.chars if motif is None or motif.lower() in c["fontname"].lower()]
    return Counter((c["fontname"], ord(c["text"])) for c in chars)


def taille_dominante(page, fontes):
    """Corps auquel sont gravés les glyphes de ces polices."""
    tailles = Counter(round(c["size"], 1) for c in page.chars
                      if c["fontname"] in fontes)
    return tailles.most_common(1)[0][0] if tailles else None


def polices_musicales(page, part_minimale=0.5):
    """Toutes les polices musicales de la page, chacune avec sa disposition.

    Un PDF ne grave pas forcément sa musique dans une seule police : Balderrama
    pose ses têtes dans un sous-ensemble de Maestro, ses pauses dans un
    deuxième et une blanche isolée dans un troisième. Ne décoder que la police
    majoritaire perdait silencieusement ces glyphes-là — et une pause perdue
    fausse la somme d'une mesure entière.

    L'admission se fait en deux tours. Le premier retient les polices qui
    portent la musique elle-même, le second les polices d'ornements, qui
    n'ont ni tête ni clé ni silence à exhiber et ne se reconnaissent qu'au
    corps auquel elles sont gravées.
    """
    par_fonte = defaultdict(Counter)
    for c in page.chars:
        par_fonte[c["fontname"]][ord(c["text"])] += 1

    def bilan(codes):
        total = sum(codes.values())
        symbolique = sum(n for k, n in codes.items() if k >= 0xF000) > total / 2
        vus = [(decoder(k), n) for k, n in codes.items()]
        connus = sum(n for sym, n in vus if sym)
        signature = any(sym in DISCRIMINANTS for sym, _ in vus)
        return total, symbolique, connus, signature

    tables = {}
    for fonte, codes in par_fonte.items():
        total, symbolique, connus, signature = bilan(codes)
        # L'encodage symbolique tranche à lui seul : aucune police de texte
        # n'encode ses lettres en 0xF000+.
        #
        # Pour les polices encodées en ASCII, il faut les deux conditions :
        # une police de paroles décode ses « b », « n » et « . » en bémol,
        # bécarre et point, donc elle a des symboles connus, mais ils restent
        # minoritaires parmi ses lettres et elle n'a aucune signature.
        if symbolique or (signature and connus > part_minimale * total):
            tables[fonte] = SYMBOLIQUE if symbolique else LEGACY

    # Second tour. Une police d'ornements — points d'augmentation, accolades,
    # points d'orgue, le « 8 » des clés octaviées — n'a ni tête, ni clé, ni
    # silence à exhiber, et une part de glyphes connus trop faible pour un
    # critère de couverture : sur une page de Caminito, six points sur treize
    # glyphes. Ce qui la sépare d'une police de paroles est le corps. L'écart
    # est une constante de gravure et non un hasard du corpus : les paroles
    # sont réglées à peu près à la moitié des glyphes musicaux, et aucune
    # police de texte des quatre partitions n'approche la taille de la
    # musique à 10 % près. Sans ce tour, les points de Caminito, que son
    # OpusSpecialStd code en 0x2122, étaient perdus, et une noire pointée sur
    # deux devenait une noire.
    taille = taille_dominante(page, tables)
    if taille:
        for fonte, codes in par_fonte.items():
            if fonte in tables:
                continue
            corps = taille_dominante(page, {fonte})
            if abs(corps - taille) < 0.1 * taille:
                _, symbolique, _, _ = bilan(codes)
                tables[fonte] = SYMBOLIQUE if symbolique else LEGACY
    return tables


def symbole(c, tables):
    """Nom du symbole porté par un glyphe, ou None.

    `tables` ne sert plus qu'à dire si la police est musicale : une police de
    paroles décode ses « b », « n » et « . » en bémol, bécarre et point, et
    c'est `polices_musicales` qui l'écarte. La disposition, elle, se lit sur
    le code lui-même.
    """
    if c["fontname"] not in tables:
        return None
    return decoder(ord(c["text"]))


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


def barres_de_mesure(page, haut, bas, interligne, tetes=(), fusion=6.0):
    """Abscisses des barres de mesure traversant une portée.

    Même précaution que pour les lignes de portée : selon le graveur une barre
    est un trait, un rectangle fin, ou une pile de filets quasi confondus qu'il
    faut refondre. Une double barre, et plus encore un signe de reprise, compte
    pour une seule frontière.

    Deux filtres, et le second fait tout le travail. Contraindre les extrémités
    du trait à rejoindre les lignes du haut et du bas écarte les hampes
    ordinaires, mais pas celle d'une note posée sur la ligne du bas : sa hampe
    montante couvre exactement la hauteur de la portée. C'est le second filtre
    qui la reconnaît — une barre de mesure ne passe jamais par une tête de
    note, une hampe y est toujours accolée. Avec lui, chaque portée retrouve
    seule le bon découpage ; sans lui le jangadero annonçait treize barres là
    où il en a six.
    """
    marge = 0.5 * interligne
    spans = [(t["x0"] - 1.5, t["x1"] + 1.5) for t in tetes]
    xs = []
    for o in list(page.lines) + list(page.rects):
        if o["width"] > 2.0:
            continue
        if abs(o["top"] - haut) > marge or abs(o["bottom"] - bas) > marge:
            continue
        x = (o["x0"] + o["x1"]) / 2
        if any(a < x < b for a, b in spans):
            continue
        xs.append(x)
    if not xs:
        return []
    xs.sort()
    fusionnees, paquet = [], [xs[0]]
    for x in xs[1:]:
        if x - paquet[0] <= fusion:
            paquet.append(x)
        else:
            fusionnees.append(sum(paquet) / len(paquet))
            paquet = [x]
    fusionnees.append(sum(paquet) / len(paquet))
    return fusionnees


def barres_consensus(page, geometries, tol=6.0):
    """Barres de mesure d'un système, recoupées entre ses portées.

    Un système est barré d'un seul tenant, donc ses portées doivent s'accorder.
    Depuis que `barres_de_mesure` écarte les hampes, elles s'accordent déjà
    toutes seules : ce recoupement n'est plus qu'un filet, qui rattrape une
    portée ayant manqué une barre, et une majorité suffit.
    """
    if not geometries:
        return []
    # Les portées d'un piano sont barrées d'un seul trait couvrant les deux :
    # il ne coïncide avec les bornes d'aucune d'elles, donc elles ne détectent
    # rien. Le vote porte sur les portées qui votent, sinon une seule portée
    # muette abaisserait le seuil pour tout le système.
    listes = [barres_de_mesure(page, haut, bas, interligne, tetes)
              for haut, bas, interligne, tetes in geometries]
    listes = [b for b in listes if b]
    if not listes:
        return []
    votes = sorted(x for b in listes for x in b)
    grappes, paquet = [], [votes[0]]
    for x in votes[1:]:
        if x - paquet[0] <= tol:
            paquet.append(x)
        else:
            grappes.append(paquet)
            paquet = [x]
    grappes.append(paquet)
    seuil = max(1, (len(listes) + 1) // 2)
    return [sum(g) / len(g) for g in grappes if len(g) >= seuil]


def fusionner(objets, cle, tol):
    """Regroupe des objets quasi confondus, et rend les groupes.

    Le chaînage se fait de proche en proche, sur l'élément précédent et non
    sur le premier du paquet : une ligature redistillée en trente-cinq filets
    décalés de six centièmes de point couvre au total plus que la tolérance,
    et une comparaison au premier la scinderait en plusieurs ligatures — donc
    en autant de crochets fictifs.
    """
    objets = sorted(objets, key=cle)
    groupes, paquet = [], []
    for o in objets:
        if paquet and cle(o) - cle(paquet[-1]) > tol:
            groupes.append(paquet)
            paquet = []
        paquet.append(o)
    if paquet:
        groupes.append(paquet)
    return groupes


def hampes(page, haut, bas, interligne, tol=1.0):
    """Hampes de la portée : (x, y_haut, y_bas).

    Une hampe fait au moins deux interlignes et reste fine. Le redistillage
    Ghostscript en empile une dizaine de filets décalés d'un dixième de point,
    qu'il faut refondre — sinon une hampe compte pour dix.
    """
    # Le plancher de longueur doit rester bien sous la hampe canonique de trois
    # interlignes et demi : une hampe se raccourcit quand sa note s'éloigne de
    # la portée, et la plus courte du corpus, celle d'une blanche posée
    # au-dessus de la cinquième ligne dans Caminito, ne fait qu'un interligne
    # et trois quarts. Calé à deux, il la perdait, et sa blanche devenait une
    # ronde faute de hampe.
    bruts = [o for o in list(page.lines) + list(page.rects)
             if o["width"] <= 2.0 and o["height"] >= 1.5 * interligne
             and haut - 6 * interligne < (o["top"] + o["bottom"]) / 2 < bas + 6 * interligne]
    sortie = []
    for groupe in fusionner(bruts, lambda o: (o["x0"] + o["x1"]) / 2, tol):
        # Même abscisse ne veut pas dire même hampe : deux portées voisines
        # alignent souvent leurs hampes, et les réunir en donne une qui
        # traverse l'entre-portées. Sur le piano de Caminito elle faisait onze
        # interlignes, et la tête se retrouvait à son extrémité basse — donc
        # hampe montante, donc voix du dessus, donc partage impossible. Une
        # hampe est continue : ce qui s'interrompt est une autre hampe.
        for morceau in morceaux_contigus(groupe, 0.5 * interligne):
            if max(o["bottom"] for o in morceau) - min(o["top"] for o in morceau) \
                    < 1.5 * interligne:
                continue
            xs = [(o["x0"] + o["x1"]) / 2 for o in morceau]
            sortie.append((sum(xs) / len(xs),
                           min(o["top"] for o in morceau),
                           max(o["bottom"] for o in morceau)))
    return sortie


def liaisons_de(page, haut, bas, interligne, tetes, marge=1.5):
    """Arcs de liaison : ceux dont les **deux bouts** sont posés sur une tête.

    C'est le seul critère qui vaille pour les quatre graveurs. La hauteur de
    la boîte ne sert pas : Finale et Sibelius rendent un arc par liaison,
    plate pour une tenue et bombée pour un phrasé, mais Ghostscript en rend
    **deux**, les deux bords d'une forme pleine, tous deux plats. Ce qui
    sépare la tenue du phrasé se lit ailleurs, sur les hauteurs : deux notes
    voisines de même hauteur sous un arc sont tenues.

    Une liaison relie deux têtes ; un point d'orgue, un accent ou le crochet
    d'une hampe sont des courbes aussi, mais trop courtes, ou posées sur une
    seule note.

    Reste la **ligature** de croches, qui relie elle aussi deux têtes, à leur
    abscisse près : chez Finale elle sort en courbe à quatre points comme un
    arc, et les deux bouts posés sur une tête ne la distinguent pas. Sur la
    page 1 de Balderrama, vingt des vingt-deux courbes sont des ligatures.
    C'est `ligature()` qui les écarte.
    """
    spans = [(t["x0"], t["x1"]) for t in tetes]

    def sur_une_tete(x):
        return any(a - marge * interligne < x < b + marge * interligne
                   for a, b in spans)

    arcs = set()
    for o in page.curves:
        if not (haut - 4 * interligne < o["top"]
                and o["bottom"] < bas + 4 * interligne):
            continue
        if not (1.5 * interligne < o["x1"] - o["x0"] < 0.6 * page.width):
            continue
        if ligature(o, interligne):
            continue
        if sur_une_tete(o["x0"]) and sur_une_tete(o["x1"]):
            arcs.add((round(o["x0"], 2), round(o["x1"], 2)))
    return sorted(arcs)


def ligature(o, interligne, part=0.25):
    """Une barre de croches, que sa section constante trahit.

    Un arc de liaison s'amincit jusqu'à rien à ses deux bouts, où il touche la
    tête ; une ligature est un parallélogramme, aussi épais à droite qu'à
    gauche. Les deux sortent en courbe fermée à quatre points et leurs boîtes
    se ressemblent — 4,4 points de haut pour la ligature des trois croches de
    « la ra la », page 1 de Balderrama, contre 3,3 pour un vrai phrasé. C'est
    l'épaisseur **aux extrémités** qui les sépare sans appel : une demi-
    interligne pour la ligature, moins d'un trentième pour la liaison.
    """
    pts = o.get("pts") or []
    if len(pts) != 4:
        return False
    bouts = min(abs(pts[0][1] - pts[3][1]), abs(pts[1][1] - pts[2][1]))
    return bouts > part * interligne


def morceaux_contigus(objets, marge):
    """Découpe une pile de filets là où elle s'interrompt verticalement."""
    sortie, courant, bord = [], [], None
    for o in sorted(objets, key=lambda o: o["top"]):
        if courant and o["top"] > bord + marge:
            sortie.append(courant)
            courant, bord = [], None
        courant.append(o)
        bord = o["bottom"] if bord is None else max(bord, o["bottom"])
    if courant:
        sortie.append(courant)
    return sortie


def meme_portee_horizontale(objets, tol):
    """Groupe les filets qui couvrent la même tranche d'abscisses.

    Les filets d'une même ligature en partagent les deux extrémités à la
    virgule près, et c'est ce qui sépare deux ligatures superposées : la
    seconde ne couvre qu'une partie des notes de la première. S'en remettre à
    leur écart vertical ne suffit pas — entre la ligature principale et la
    secondaire du candombe il n'y a que 0,84 pt, moins que le pas qui sépare
    deux ligatures franchement distinctes ailleurs dans la même page.
    """
    groupes = []
    for o in sorted(objets, key=lambda o: (o["x0"], o["x1"])):
        for g in groupes:
            if abs(g[0]["x0"] - o["x0"]) <= tol and abs(g[0]["x1"] - o["x1"]) <= tol:
                g.append(o)
                break
        else:
            groupes.append([o])
    return groupes


def ligatures(page, haut, bas, interligne, hampes_portee=()):
    """Barres de ligature : (x0, x1, y).

    Une ligature est une surface pleine, large et basse. Selon le graveur c'est
    un rectangle franc ou, après redistillation, une pile de filets décalés de
    six centièmes de point qu'il faut refondre.
    """
    # Ni le type d'objet ni le remplissage ne sont des critères : selon le
    # graveur une ligature est un rectangle plein, une courbe pleine ou une
    # pile de lignes tracées. Seule la géométrie après fusion l'identifie.
    #
    # Le plafond de largeur écarte les lignes de portée, qui passent par
    # ailleurs tous les tests : elles sont larges, plates, et à la bonne
    # ordonnée. Sur le candombe, les onze filets de la première ligne et ceux
    # de la deuxième se rejoignaient à travers les vraies ligatures posées
    # entre elles, et la barre fictive ainsi formée courait sous toutes les
    # hampes du système — un crochet de trop sur presque chaque note. Le seuil
    # est celui qui définit une ligne de portée dans `traits_horizontaux` :
    # ce qui est assez large pour en être une n'est pas une ligature.
    # Le préfiltre en hauteur porte sur un objet isolé, le contrôle d'après
    # fusion sur l'enveloppe du groupe : le premier ne voit que le dénivelé,
    # le second y ajoute l'épaisseur. Le premier doit donc être plus bas que
    # le second d'une épaisseur de ligature, soit environ un demi-interligne.
    # Calé trop bas, il rejetait avant toute fusion les ligatures les plus
    # inclinées de Balderrama, dont un sixième des mesures devenait insoluble.
    bruts = [o for o in list(page.rects) + list(page.curves) + list(page.lines)
             if 0.8 * interligne < o["width"] < 0.35 * page.width
             and o["height"] < 1.2 * interligne
             and haut - 7 * interligne < (o["top"] + o["bottom"]) / 2 < bas + 7 * interligne]
    sortie = []
    for tranche in meme_portee_horizontale(bruts, 0.25 * interligne):
        # deux ligatures de même portée horizontale (une croche doublée sur
        # tout le groupe) ne se séparent plus que par leur écart vertical
        for morceau in fusionner(tranche, lambda o: (o["top"] + o["bottom"]) / 2,
                                 0.2 * interligne):
            x0 = min(o["x0"] for o in morceau)
            x1 = max(o["x1"] for o in morceau)
            y0 = min(o["top"] for o in morceau)
            y1 = max(o["bottom"] for o in morceau)
            # L'épaisseur se juge après fusion, jamais avant. Une ligature est
            # une barre franche ; une liaison est un filet, même quand son
            # tracé est plein et large. Le redistillage Ghostscript découpe la
            # barre en une pile de filets qui, pris un à un, ressemblent à des
            # liaisons — et pris ensemble redonnent la barre.
            # Le plafond doit tolérer la pente : l'enveloppe verticale d'une
            # ligature inclinée vaut son épaisseur plus son dénivelé, et un
            # plafond calé sur l'épaisseur seule rejetait toutes les ligatures
            # penchées du candombe.
            if 0.18 * interligne < y1 - y0 < 1.6 * interligne:
                sortie.append((x0, x1, (y0 + y1) / 2))
    if not hampes_portee:
        return sortie
    # Une ligature s'appuie sur des hampes : elle part de l'une et s'arrête
    # sur une autre, ou, fractionnaire, déborde d'un seul côté. Une liaison
    # de phrasé, elle, ne s'appuie sur rien — et c'est le seul critère qui
    # l'écarte, car pdfplumber aplatit son arc sur ses deux extrémités et en
    # rend une boîte englobante large, plate et inclinée : une ligature, au
    # pixel près. Sur Caminito, où les phrasés sont longs, elles ajoutaient
    # un crochet à des noires isolées.
    xs = [h[0] for h in hampes_portee]
    marge = 0.15 * interligne
    return [(x0, x1, y) for (x0, x1, y) in sortie
            if any(abs(x - x0) < marge or abs(x - x1) < marge for x in xs)]


def hampes_candidates(tete, y_tete, hampes_portee, interligne):
    """Hampes accolées à une tête, de la plus vraisemblable à la moins.

    La hampe d'une note est celle qui lui est accolée, donc la plus proche —
    et non la plus longue. Une note posée juste avant une barre de mesure voit
    la barre passer le filtre de proximité, et la barre, qui couvre toute la
    portée, est toujours plus longue qu'une hampe : c'est elle qui était
    retenue, et les ligatures se comptaient alors à son abscisse. À égalité de
    distance on garde la plus longue, pour préférer une hampe entière à un
    fragment que la fusion aurait laissé de côté.
    """
    def ecart(h):
        return min(abs(h[0] - tete["x0"]), abs(h[0] - tete["x1"]))

    candidates = [h for h in hampes_portee
                  if ecart(h) < 0.6 * interligne
                  and h[1] - interligne <= y_tete <= h[2] + interligne]
    return sorted(candidates, key=lambda h: (round(ecart(h), 1), -(h[2] - h[1])))


def sens_de(hampe, ys):
    """Sens d'une hampe, d'après les têtes qu'elle porte.

    Le sens se décide par hampe et non par tête : dans un accord étalé, la
    tête la plus éloignée de la tête d'attache est plus près du bout libre que
    de l'autre bout, et une décision prise tête par tête retournait le sens
    pour elle seule. Or les têtes d'un accord partagent une hampe, donc un
    sens — et c'est précisément ce qui distingue un accord de deux voix
    superposées, qui ont chacune la leur.
    """
    _, y0, y1 = hampe
    return "haut" if (min(ys) - y0) > (y1 - max(ys)) else "bas"


def crochets_de(hampe, sens, y_attache, ligatures_portee, interligne,
                crochets_portee=()):
    """Nombre de crochets d'une hampe : 0 noire, 1 croche, 2 double, etc.

    Les ligatures qui croisent la hampe se comptent à son extrémité libre,
    celle qui s'éloigne des têtes. Le compte donne la durée directement, sans
    avoir à la deviner.
    """
    x, y0, y1 = hampe
    bout = y0 if sens == "haut" else y1
    n = 0
    for (bx0, bx1, by) in ligatures_portee:
        # La marge doit rester bien plus étroite qu'un espacement de notes :
        # une ligature fractionnaire — le crochet court qui ne vaut que pour
        # une note du groupe — s'arrête entre deux hampes, et une marge large
        # la fait déborder sur la voisine, qu'elle raccourcit de moitié.
        if bx0 - 0.15 * interligne <= x <= bx1 + 0.15 * interligne:
            # à l'extrémité libre, et pas du côté des têtes
            if (abs(by - bout) <= 2.6 * interligne
                    and abs(by - y_attache) > 1.6 * interligne):
                n += 1
    # Une note isolée porte un crochet dessiné, pas une ligature : même rôle,
    # même compte. Les deux ne coexistent pas sur une même hampe.
    if n == 0:
        for (cx, cy) in crochets_portee:
            if abs(cx - x) < 1.6 * interligne and abs(cy - bout) <= 2.6 * interligne:
                n += 1
    return n


def attribuer_points(page, points, porteurs, interligne, demi):
    """Attribue chaque point d'augmentation à une seule note ou à un silence.

    Compter, pour chaque tête, les points voisins ne marche pas dans un
    accord : les têtes y sont séparées d'un interligne et les points décalés
    d'un demi-interligne, si bien que chaque point tombe dans la fenêtre de
    deux têtes à la fois. Les accords finaux du jangadero devenaient des
    blanches doublement pointées, et leurs mesures insolubles.

    Un point appartient donc à une tête et une seule, la plus proche en
    ordonnée ; à égalité — cas exact d'un point posé entre deux têtes — il va
    à celle qui n'en a pas encore, ce qui rend son point à chaque note de
    l'accord. Une note réellement doublement pointée garde les siens : ses
    deux points sont à la même hauteur, côte à côte, et aucune autre tête ne
    les leur dispute.
    """
    compte, restants = {}, []
    for d in sorted(points, key=lambda d: d["x0"]):
        yd = y_baseline(page, d)
        # La fenêtre verticale se place à mi-chemin entre les deux distances
        # qui la bornent : le point d'une note posée sur une ligne se décale
        # d'un demi-interligne — un peu plus en pratique, 1,17 sur le
        # candombe — et la tête voisine d'un accord est à deux. Trop serrée,
        # elle perdait le point ; trop large, elle le donnerait à la voisine.
        candidats = [c for c in porteurs
                     if 0 < d["x0"] - c["x1"] < 2.5 * interligne
                     and abs(y_baseline(page, c) - yd) <= 1.5 * demi]
        if not candidats:
            restants.append(d)
            continue
        gagnant = min(candidats,
                      key=lambda c: (round(abs(y_baseline(page, c) - yd), 2),
                                     compte.get(id(c), 0), d["x0"] - c["x1"]))
        compte[id(gagnant)] = compte.get(id(gagnant), 0) + 1
    return compte, restants


def attribuer_staccatos(page, points, tetes, interligne,
                        large=1.0, bas=1.5, haut=7.0):
    """Les points qui ne sont pas d'augmentation et qui articulent une note.

    Les deux se séparent par la géométrie, sans ambiguïté sur le corpus : le
    point d'augmentation se pose **à droite** de la tête et à sa hauteur (dx
    ≈ +1,5 interligne, dy ≈ 0, le demi-interligne de décalage près quand la
    note est sur une ligne) ; le point de staccato se pose **au-dessus ou
    au-dessous**, centré sur la tête (dx ≈ +0,5, dy de 4 à 6 selon que le
    graveur le range du côté de la hampe ou de la tête).

    Les rejets sont tout aussi nets : les points d'une barre de reprise, ceux
    d'un point d'orgue ou d'un chiffrage sont tous à plus de deux interlignes
    du centre d'une tête. D'où une fenêtre horizontale serrée — c'est elle qui
    porte la décision — et une fenêtre verticale large, qui ne fait qu'exclure
    le point d'augmentation d'une note posée sur une ligne.

    Sur les quatre partitions : 32 staccatos au jangadero, 12 à Caminito,
    aucun à Balderrama ni au candombe, et rien d'autre retenu.
    """
    marques = set()
    if not tetes:
        return marques
    for d in points:
        yd = y_baseline(page, d)
        xd = (d["x0"] + d["x1"]) / 2
        candidats = [
            c for c in tetes
            if abs(xd - (c["x0"] + c["x1"]) / 2) <= large * interligne
            and bas * interligne <= abs(y_baseline(page, c) - yd) <= haut * interligne
        ]
        if not candidats:
            continue
        # La tête la plus proche, l'ordonnée d'abord : dans un accord, c'est
        # celle du bord qui porte l'articulation.
        marques.add(id(min(candidats,
                           key=lambda c: (abs(y_baseline(page, c) - yd),
                                          abs(xd - (c["x0"] + c["x1"]) / 2)))))
    return marques


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


def armure_de(glyphes_portee, x_cle, x_premiere_tete, table, interligne,
              colle=0.6):
    """Altérations de l'armure, par comptage dans l'ordre canonique.

    Renvoie aussi l'abscisse de fin de l'armure : ses dièses sont des glyphes
    d'altération comme les autres, et le dernier d'entre eux se retrouve collé
    à la première note quand aucun chiffrage ne les sépare (systèmes 2 et
    suivants). Sans cette borne il est pris pour une altération accidentelle.

    La réciproque coûtait plus cher encore : une altération portée par la
    **première note** du système tombe elle aussi entre la clé et cette note,
    et elle était comptée dans l'armure — donc appliquée à toute la portée. Le
    jangadero lisait ainsi six portées sur quarante en « un dièse et un
    bémol », ce qu'aucune armure n'est, et tous ses si devenaient bémols.

    Les deux se séparent à l'écart : une altération d'armure laisse passer la
    note, celle d'une note lui est collée. Sur les quatre partitions, la plus
    serrée des armures garde 1,26 interligne quand les six mauvaises lectures
    sont à 0,02. Le seuil tient au milieu, avec un facteur deux de chaque côté.
    """
    entre = sorted(
        (c for c in glyphes_portee
         if x_cle < c["x0"] < x_premiere_tete
         and symbole(c, table) in ("diese", "bemol")),
        key=lambda c: c["x0"],
    )
    while entre and x_premiere_tete - entre[-1]["x1"] < colle * interligne:
        entre.pop()
    # Une armure ne mêle jamais dièses et bémols : ce qui rompt la série ne lui
    # appartient pas. Garde-fou, et non le ressort principal — l'écart tranche
    # déjà les cas du corpus, celui-ci attrape ceux qu'il laisserait passer.
    if entre:
        premier = symbole(entre[0], table)
        garde = 0
        while garde < len(entre) and symbole(entre[garde], table) == premier:
            garde += 1
        entre = entre[:garde]
    x_fin = max((c["x1"] for c in entre), default=x_cle)
    dieses = sum(1 for c in entre if symbole(c, table) == "diese")
    bemols = sum(1 for c in entre if symbole(c, table) == "bemol")
    armure = {}
    for i in range(min(dieses, 7)):
        armure[ORDRE_DIESES[i]] = 1
    for i in range(min(bemols, 7)):
        armure[ORDRE_BEMOLS[i]] = -1
    return armure, x_fin


def periode_des_cles(cles):
    """Nombre de portées par système, lu sur la périodicité des clés.

    La suite des clés d'une page se répète système après système — sol, sol,
    sol8, fa pour un chœur à quatre voix, sol, sol, sol, fa, sol, fa quand
    s'y ajoute un piano. Sa plus petite période donne la taille d'un système
    sans avoir à deviner les frontières verticales, que les écarts entre
    portées ne trahissent pas de façon fiable : le piano est plus éloigné du
    chœur que les systèmes ne le sont entre eux.
    """
    n = len(cles)
    for periode in range(1, n + 1):
        if n % periode == 0 and all(cles[i] == cles[i % periode] for i in range(n)):
            return periode
    return n


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
    table = polices_musicales(page)
    if not staves or not table:
        return []
    niveaux = defaultdict(set)
    effectifs = Counter()
    sur_grille = Counter()
    for c in page.chars:
        if c["fontname"] not in table or symbole(c, table) is not None:
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


TIRETS = "-‐‑‒–—"


def paroles_de(page, bas, plancher, tables, ecart=0.6):
    """Syllabes chantées sous une portée, avec leur abscisse.

    Elles sont dans le PDF, posées chacune sous sa note : la couche texte les
    donne exactement, là où `pdftotext` rend une suite de mots sans position
    et l'OCR les redevine.

    Le trait d'union de césure y est aussi, tantôt collé à sa syllabe
    (« Bal-de »), tantôt isolé entre deux — c'est l'espacement de la gravure
    qui en décide, pas le texte. On le retire du mot et on le garde comme
    liaison : `lie` dit que la syllabe se rattache à la suivante, ce qui
    donne le `--` de LilyPond. Son absence est une lecture et non un trou :
    Balderrama en a dans ses couplets et pas dans ses « Tra la la », qui sont
    trois mots et non trois syllabes, comme les « Bom » de sa basse.

    Les couplets superposés se séparent par leur ligne de base ; on rend une
    liste de lignes triées de haut en bas, chacune dans l'ordre de lecture.
    L'ordre compte : le premier couplet est toujours gravé au-dessus du
    second, et c'est le seul critère qui les distingue à coup sûr — le second
    a souvent plus de syllabes que le premier.
    """
    sous = [c for c in page.chars
            if c["fontname"] not in tables and bas < c["top"] < plancher
            and c["text"].strip()]
    # On sépare d'abord par le corps, et on ne regroupe en lignes qu'ensuite.
    # Une ligne de paroles n'est pas toujours d'aplomb — page 2 de Caminito
    # elle se brise en deux moitiés décalées de trois points et demi — et il
    # faut donc une tolérance large pour les recoudre ; mais large, elle
    # ramasse au passage le « pp legato » gravé quatre points sous le second
    # couplet. Le corps les sépare sans rien coûter : les paroles sont à 9,01
    # et les nuances à 9,38.
    paquets = defaultdict(list)
    for c in sous:
        paquets[round(c["size"], 1)].append(c)
    lignes = []
    for corps_paquet, chars in paquets.items():
        for groupe in fusionner(chars, lambda c: c["top"], 0.55 * corps_paquet):
            jetons, mot, debut, fin = [], "", None, None
            for c in sorted(groupe, key=lambda c: c["x0"]):
                if mot and c["x0"] - fin > ecart:
                    jetons.append((debut, mot))
                    mot = ""
                if not mot:
                    debut = c["x0"]
                mot += c["text"]
                fin = c["x1"]
            if mot:
                jetons.append((debut, mot))
            # L'ordonnee de la ligne et son corps accompagnent chaque
            # syllabe : ils servent a ranger les couplets.
            y = min(c["top"] for c in groupe)
            corps = median(c["size"] for c in groupe)
            lignes.append([dict(s, y=round(y, 2), corps=round(corps, 2))
                           for s in syllabes(jetons)])
    lignes = sorted((l for l in lignes if l), key=lambda l: l[0]["y"])
    for ligne in lignes:
        prolongations(page, ligne, bas, plancher)
    return lignes


def prolongations(page, ligne, bas, plancher, marge=2.0):
    """Marque les syllabes que la gravure prolonge d'un trait.

    Une syllabe tenue sur plusieurs notes se signale par un trait horizontal
    qui court jusqu'à la dernière : c'est le mélisme, et c'est aussi la
    liaison qui le porte dans la partie chantée. Le trait est posé sur la
    **ligne de base** du texte, à un point près ; ce qui traîne ailleurs dans
    la même bande — et il y en a — sont les lignes supplémentaires des notes
    sous la portée, à une quinzaine de points au-dessus, et de la largeur
    d'une tête. C'est l'ordonnée qui les sépare, pas la largeur : une
    prolongation courte fait la même dizaine de points qu'une ligne
    supplémentaire.

    Chez Sibelius le même trait est une suite de glyphes `_` de la police de
    texte musical ; ils sont alors dans la couche texte et non ici.
    """
    base = ligne[0]["y"] + 0.8 * ligne[0]["corps"]
    traits = [o for o in list(page.lines) + list(page.rects)
              if o["bottom"] - o["top"] < 1.0
              and abs(o["top"] - base) < marge
              and bas < o["top"] < plancher]
    for o in traits:
        avant = [s for s in ligne if s["x"] <= o["x0"]]
        if avant:
            avant[-1]["tenue"] = round(o["x1"], 2)


def syllabes(jetons):
    """Découpe les jetons en syllabes liées ou non par la césure."""
    sortie = []
    lier_la_suivante = False
    for x, mot in jetons:
        if all(c in TIRETS for c in mot):        # tiret isolé entre deux syllabes
            if sortie:
                sortie[-1]["lie"] = True
            lier_la_suivante = False
            continue
        morceaux = [m for m in re.split("[" + TIRETS + "]", mot) if m]
        if not morceaux:
            continue
        # le tiret peut pendre d'un côté comme de l'autre : « Bal-de » lie ce
        # qui suit, « -mos » ce qui précède, et les deux se rencontrent dans
        # la même partition
        if (lier_la_suivante or mot[0] in TIRETS) and sortie:
            sortie[-1]["lie"] = True
        lier_la_suivante = mot[-1] in TIRETS
        for i, m in enumerate(morceaux):
            sortie.append({"x": round(x, 2), "texte": m,
                           "lie": i < len(morceaux) - 1})
    return sortie


def lire_page(page, numero):
    staves = portees(page)
    if not staves:
        return []
    table = polices_musicales(page)
    glyphes = [c for c in page.chars if c["fontname"] in table]
    if not glyphes:
        return []
    signes = polices_texte_musical(page, table)
    nuances = nuances_de(page, signes)
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

        # Une portée muette (mesures de silence) est conservée avec une liste de
        # notes vide : c'est l'indice de portée qui désigne le pupitre, et sauter
        # le Bajo silencieux d'un système décalerait tous les suivants.
        têtes = [c for c in bande if symbole(c, table) in TETES]
        if not bande:
            continue
        cle = cle_de(page, bande, bas, interligne, table, taille_musique)
        cles = [c for c in bande if symbole(c, table) in ("cle_sol", "cle_sol8", "cle_fa")]
        x_cle = min(c["x1"] for c in cles) if cles else bande[0]["x0"]
        fin_armure = têtes[0]["x0"] if têtes else bande[-1]["x1"]
        armure, x_fin_armure = armure_de(bande, x_cle, fin_armure, table,
                                         interligne)
        base = BASE_CLE[cle]

        accidentelles = [
            c for c in bande
            if symbole(c, table) in ALTERATIONS and c["x0"] > x_fin_armure
        ]
        # Un point d'augmentation se pose à droite de sa tête ou de son
        # silence, à la même hauteur à un demi-interligne près (il se décale
        # dans l'interligne voisin quand la note est sur une ligne).
        points = [c for c in bande if symbole(c, table) == "point"]
        porteurs = [c for c in bande
                    if symbole(c, table) in TETES or symbole(c, table) in SILENCES]
        compte, sans_note = attribuer_points(page, points, porteurs,
                                             interligne, demi)
        staccatos = attribuer_staccatos(page, sans_note, têtes, interligne)

        def points_de(c, y):
            return compte.get(id(c), 0)

        hampes_p = hampes(page, haut, bas, interligne)
        ligatures_p = ligatures(page, haut, bas, interligne, hampes_p)
        arcs = liaisons_de(page, haut, bas, interligne, têtes)
        crochets_p = [((c["x0"] + c["x1"]) / 2, y_baseline(page, c)) for c in bande
                      if symbole(c, table) == "crochet"]

        notes = []
        for c in têtes:
            y = y_baseline(page, c)
            step = base + round((bas - y) / demi)
            # Une altération accidentelle est collée à gauche, à la même
            # hauteur — et parfois *collée* au sens propre : les si dièses de
            # Caminito ont leur bord droit quatre centièmes de point à gauche
            # de la tête, donc du mauvais côté d'un écart exigé strictement
            # positif. La tolérance négative reste bien en deçà d'une largeur
            # de tête, pour ne jamais rattraper une altération d'après.
            alt = None
            for a in accidentelles:
                if (-0.3 * interligne < c["x0"] - a["x1"] < 2.2 * interligne
                        and abs(y_baseline(page, a) - y) < demi):
                    alt = ALTERATIONS[symbole(a, table)]
            notes.append({
                "x": round(c["x0"], 2),
                "y": round(y, 2),
                "step": step,
                # provisoire : l'altération ne se fige qu'une fois les barres
                # de mesure connues, la mémoire des altérations s'arrêtant à
                # la barre. Voir `memoire_alterations`.
                "nom": nom(step, armure.get(step % 7, 0) if alt is None else alt),
                "_alt_ecrite": alt,
                "_alt_armure": armure.get(step % 7, 0),
                "tete": symbole(c, table),
                "points": points_de(c, y),
                "staccato": id(c) in staccatos,
                "crochets": 0,
                "hampe": None,
                "hampe_x": None,
                "_candidates": hampes_candidates(c, y, hampes_p, interligne),
            })

        # Une hampe ne porte jamais deux têtes de même hauteur : un accord n'a
        # pas deux fois la même note. Deux têtes superposées à l'identique sont
        # deux voix à l'unisson, et chacune a la sienne — la seconde, plus
        # éloignée, serait sans cela attribuée à la hampe de la première, et
        # la voix du haut perdrait sa note.
        # Et elle ne porte qu'une **durée**, donc qu'un seul type de tête : un
        # accord se lit d'un seul rythme. Deux têtes à la même abscisse dont
        # l'une est pleine et l'autre blanche sont donc deux voix, pas un
        # accord — c'est ce qui manquait au piano de Caminito, où une noire
        # pointée du dessus et une blanche du dessous se retrouvaient dans le
        # même accord, lu blanche, et la mesure ne tombait plus juste.
        prises, portees_par = set(), {}
        for n in notes:
            for h in n["_candidates"]:
                if (h, round(n["y"], 1)) in prises:
                    continue
                if portees_par.get(h, n["tete"]) != n["tete"]:
                    continue
                prises.add((h, round(n["y"], 1)))
                portees_par[h] = n["tete"]
                n["_hampe"] = h
                break
            else:
                # faute de hampe libre, on partage : mieux vaut une tête
                # rattachée à la hampe de sa voisine qu'une tête sans durée
                n["_hampe"] = n["_candidates"][0] if n["_candidates"] else None

        # Sens et crochets se décident par hampe, une fois connues toutes les
        # têtes qu'elle porte. C'est aussi ce qui sépare un accord — plusieurs
        # têtes sur une hampe — de deux voix superposées, qui en ont chacune
        # une : `hampe_x` les distingue là où l'abscisse seule les confond.
        par_hampe = defaultdict(list)
        for n in notes:
            if n["_hampe"]:
                par_hampe[n["_hampe"]].append(n)
        for h, groupe in par_hampe.items():
            sens = sens_de(h, [n["y"] for n in groupe])
            attache = max(n["y"] for n in groupe) if sens == "haut"                 else min(n["y"] for n in groupe)
            crochets = crochets_de(h, sens, attache, ligatures_p, interligne,
                                   crochets_p)
            for n in groupe:
                n["hampe"] = sens
                n["hampe_x"] = round(h[0], 2)
                n["crochets"] = crochets
        for n in notes:
            del n["_hampe"]
            del n["_candidates"]

        silences = []
        for c in bande:
            sym = symbole(c, table)
            if sym not in SILENCES:
                continue
            y = y_baseline(page, c)
            silences.append({
                "x": round(c["x0"], 2),
                "y": round(y, 2),
                # position sur la portée, en demi-interlignes au-dessus de la
                # ligne du bas ; informatif seulement, les silences ayant tous
                # leur baseline sur la ligne médiane
                "niveau": round((bas - y) / demi, 2),
                "silence": sym,
                "points": points_de(c, y),
            })
        silences.sort(key=lambda s: s["x"])

        # Les paroles vivent entre cette portée et la suivante ; sans borne
        # basse on ramasserait celles du pupitre d'en dessous.
        plancher = staves[idx + 1][0] if idx + 1 < len(staves) else page.height
        paroles = paroles_de(page, bas + 0.5 * interligne, plancher,
                             set(table) | signes)

        premiers = [e["x"] for e in notes + silences]
        chiffrage = chiffrage_de(page, bande, bas, demi,
                                 min(premiers) if premiers else bande[-1]["x1"],
                                 table)
        resultat.append({
            "page": numero,
            "portee": idx,
            "y_haut": round(haut, 2),
            "y_bas": round(bas, 2),
            "interligne": round(interligne, 3),
            "cle": cle,
            "octave": OCTAVE_CLE[cle],   # hauteurs écrites ; -1 = sonne une octave plus bas
            "armure_dieses": sum(1 for v in armure.values() if v > 0),
            "armure_bemols": sum(1 for v in armure.values() if v < 0),
            "chiffrage": chiffrage,
            "notes": notes,
            "silences": silences,
            "paroles": paroles,
            "nuances": [],
            "liaisons": arcs,
            "_tetes": têtes,
        })

    # Les nuances se rangent à la portée la plus proche, et non à celle qui
    # les surplombe : celles d'un piano sont gravées entre ses deux portées,
    # donc sous la voix d'à côté. C'est la distance à la portée qui tranche.
    for n in nuances:
        proche = min(resultat,
                     key=lambda p: max(p["y_haut"] - n["y"], n["y"] - p["y_bas"], 0))
        proche["nuances"].append({"x": n["x"], "texte": n["texte"]})
    for p in resultat:
        p["nuances"].sort(key=lambda n: n["x"])

    # Les barres se calculent par système, une fois les clés connues : c'est
    # leur périodicité qui dit où un système s'arrête.
    periode = periode_des_cles([p["cle"] for p in resultat]) if resultat else 1
    for debut in range(0, len(resultat), periode):
        systeme = resultat[debut:debut + periode]
        geometries = [(p["y_haut"], p["y_bas"], p["interligne"], p["_tetes"])
                      for p in systeme]
        barres = [round(x, 2) for x in barres_consensus(page, geometries)]
        for p in systeme:
            p["systeme"] = debut // periode
            p["portees_par_systeme"] = periode
            p["barres"] = barres
            memoire_alterations(p)
    for p in resultat:
        del p["_tetes"]
    return resultat


def memoire_alterations(portee):
    """Fige l'altération de chaque note, la mémoire s'arrêtant à la barre.

    Une altération accidentelle vaut jusqu'à la fin de la mesure, pour la
    seule position exacte où elle est écrite : le graveur ne la répète pas,
    et la lire note à note redonne un bécarre là où le dièse tient encore.
    Le candombe écrit `sol#` puis un `sol` nu deux croches plus loin ; sans
    mémoire il redevenait naturel.

    C'est pour cela que l'altération ne se fige qu'ici : la mémoire s'arrête
    à la barre de mesure, et les barres ne sont connues qu'une fois le
    système entier lu. Les liaisons, elles, la reportent d'une mesure à la
    suivante — voir plus bas.
    """
    barres = portee.get("barres") or []
    notes = sorted(portee["notes"], key=lambda n: n["x"])

    # La mémoire s'arrête à la barre, la liaison de tenue la franchit : une
    # note liée garde l'altération de celle qui la précède, sans que le
    # graveur la réécrive. Le jangadero tient un si bémol d'une mesure sur la
    # suivante ; sans ce report la seconde redevenait naturelle, et l'arc
    # entre deux hauteurs devenues différentes n'était même plus une tenue
    # mais un mélisme.
    #
    # Les bouts d'un arc ne tombent pas sur les têtes — il est tracé de l'une
    # à l'autre sans les toucher — donc chacun se rabat sur la plus proche,
    # comme le fait `couvert_par_arc` du générateur.
    def proche(x):
        return min(notes, key=lambda n: abs(n["x"] - x)) if notes else None

    tenue = {}
    for depart, fin in portee.get("liaisons") or ():
        a, b = proche(depart), proche(fin)
        if a is None or b is None or a is b or a["step"] != b["step"]:
            continue
        if a["x"] > b["x"]:
            a, b = b, a
        # Une tenue joint deux notes **voisines**. Un arc dont les deux bouts
        # retombent sur le même degré mais qui enjambe d'autres notes est un
        # phrasé : Caminito en a un sur si, si dièse, si dièse, si, et reporter
        # le bécarre du premier sur le dernier lui retirait le dièse que la
        # mesure lui devait.
        if any(a["x"] < n["x"] < b["x"] for n in notes):
            continue
        tenue[id(b)] = a

    effective, courant, i = {}, {}, 0
    for n in notes:
        while i < len(barres) and barres[i] <= n["x"]:
            i += 1
            courant.clear()
        source = tenue.get(id(n))
        if n["_alt_ecrite"] is not None:
            courant[n["step"]] = n["_alt_ecrite"]
        elif source is not None and id(source) in effective:
            courant[n["step"]] = effective[id(source)]
        alt = courant.get(n["step"], n["_alt_armure"])
        effective[id(n)] = alt
        # L'enharmonie se règle en dernier : la mémoire raisonne sur le degré
        # écrit, c'est le nom rendu qui se corrige.
        pas, ecrite = enharmonie(n["step"], alt, portee.get("armure_bemols", 0))
        n["nom"] = nom(pas, ecrite)
    for n in portee["notes"]:
        del n["_alt_ecrite"]
        del n["_alt_armure"]


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
    # La console Windows est en cp1252 : sans cela, la moindre lettre accentuée
    # du rapport fait planter l'outil au lieu de l'afficher.
    for flux in (sys.stdout, sys.stderr):
        flux.reconfigure(encoding="utf-8", errors="replace")

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
            table = polices_musicales(pdf.pages[pages[0] - 1])
            print("polices musicales détectées : "
                  + ", ".join(f"{f} ({'symbolique' if t is SYMBOLIQUE else 'héritée'})"
                              for f, t in table.items()))
            for (f, code), n in codes_police(pdf.pages[pages[0] - 1]).most_common(30):
                if f not in table:
                    continue
                sym = decoder(code) or "?"
                print(f"  {f[:18]:20s} {hex(code):>8s}  n={n:5d}  {sym}")
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

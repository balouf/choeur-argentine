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
    0x62: "tete_agrement",
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
# Deux entrées ont d'abord été devinées, et les deux étaient fausses : 0x2030
# passait pour une tête blanche (c'est un soupir de croche, toujours sur la
# ligne médiane) et 0x62 pour un bémol (c'est une acciaccatura, collée à gauche
# d'une vraie tête, même hauteur). Un symbole plausible par la largeur et la
# fréquence ne l'est pas par la position. D'où la règle : toute entrée ajoutée
# ici se vérifie avec --overlay avant d'être crue.
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


def codes_police(page, motif=None):
    """Distribution des codes de glyphes, pour établir la table d'une police."""
    chars = [c for c in page.chars if motif is None or motif.lower() in c["fontname"].lower()]
    return Counter((c["fontname"], ord(c["text"])) for c in chars)


def polices_musicales(page, part_minimale=0.5):
    """Toutes les polices musicales de la page, chacune avec sa disposition.

    Un PDF ne grave pas forcément sa musique dans une seule police : Balderrama
    pose ses têtes dans un sous-ensemble de Maestro, ses pauses dans un
    deuxième et une blanche isolée dans un troisième. Ne décoder que la police
    majoritaire perdait silencieusement ces glyphes-là — et une pause perdue
    fausse la somme d'une mesure entière.
    """
    par_fonte = defaultdict(Counter)
    for c in page.chars:
        par_fonte[c["fontname"]][ord(c["text"])] += 1
    tables = {}
    for fonte, codes in par_fonte.items():
        total = sum(codes.values())
        symbolique = sum(n for k, n in codes.items() if k >= 0xF000) > total / 2
        table = SYMBOLIQUE if symbolique else LEGACY
        vus = [(decoder(k), n) for k, n in codes.items()]
        connus = sum(n for sym, n in vus if sym)
        signature = any(sym in DISCRIMINANTS for sym, _ in vus)
        # L'encodage symbolique tranche à lui seul : aucune police de texte
        # n'encode ses lettres en 0xF000+. Les polices d'ornements (braces,
        # points d'augmentation, « 8 » des clés octaviées) sont de celles-là,
        # et un critère de couverture les rejetterait, faute d'avoir la
        # plupart de leurs signes dans la table — c'est ainsi que les points
        # des blanches pointées du jangadero étaient perdus, rendant un tiers
        # de ses mesures insolubles.
        #
        # Pour les polices encodées en ASCII, il faut les deux conditions :
        # une police de paroles décode ses « b », « n » et « . » en bémol,
        # bécarre et point, donc elle a des symboles connus, mais ils restent
        # minoritaires parmi ses lettres et elle n'a aucune signature.
        if symbolique or (signature and connus > part_minimale * total):
            tables[fonte] = table
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
    bruts = [o for o in list(page.lines) + list(page.rects)
             if o["width"] <= 2.0 and o["height"] >= 2 * interligne
             and haut - 6 * interligne < (o["top"] + o["bottom"]) / 2 < bas + 6 * interligne]
    sortie = []
    for groupe in fusionner(bruts, lambda o: (o["x0"] + o["x1"]) / 2, tol):
        xs = [(o["x0"] + o["x1"]) / 2 for o in groupe]
        sortie.append((sum(xs) / len(xs),
                       min(o["top"] for o in groupe),
                       max(o["bottom"] for o in groupe)))
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


def ligatures(page, haut, bas, interligne):
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
    return sortie


def crochets_de(tete, y_tete, hampes_portee, ligatures_portee, interligne,
                crochets_portee=()):
    """Nombre de crochets d'une note : 0 noire, 1 croche, 2 double, etc.

    La hampe est accolée au bord de la tête ; les ligatures qui la croisent se
    comptent à son extrémité libre, celle qui s'éloigne de la tête. Le compte
    donne la durée directement, sans avoir à la deviner.
    """
    def ecart(h):
        return min(abs(h[0] - tete["x0"]), abs(h[0] - tete["x1"]))

    candidates = [h for h in hampes_portee
                  if ecart(h) < 0.6 * interligne
                  and h[1] - interligne <= y_tete <= h[2] + interligne]
    if not candidates:
        return 0, None
    # La hampe d'une note est celle qui lui est accolée, donc la plus proche —
    # et non la plus longue. Une note posée juste avant une barre de mesure
    # voit la barre passer le filtre de proximité, et la barre, qui couvre
    # toute la portée, est toujours plus longue qu'une hampe : c'est elle qui
    # était retenue, et les ligatures se comptaient alors à son abscisse. À
    # égalité de distance on garde la plus longue, pour préférer une hampe
    # entière à un fragment que la fusion aurait laissé de côté.
    hampe = min(candidates, key=lambda h: (round(ecart(h), 1), -(h[2] - h[1])))
    x, y0, y1 = hampe
    vers_le_haut = abs(y0 - y_tete) > abs(y1 - y_tete)
    bout = y0 if vers_le_haut else y1
    n = 0
    for (bx0, bx1, by) in ligatures_portee:
        # La marge doit rester bien plus étroite qu'un espacement de notes :
        # une ligature fractionnaire — le crochet court qui ne vaut que pour
        # une note du groupe — s'arrête entre deux hampes, et une marge large
        # la fait déborder sur la voisine, qu'elle raccourcit de moitié.
        if bx0 - 0.15 * interligne <= x <= bx1 + 0.15 * interligne:
            # à l'extrémité libre, et pas du côté de la tête
            if abs(by - bout) <= 2.6 * interligne and abs(by - y_tete) > 1.6 * interligne:
                n += 1
    # Une note isolée porte un crochet dessiné, pas une ligature : même rôle,
    # même compte. Les deux ne coexistent pas sur une même hampe.
    if n == 0:
        for (cx, cy) in crochets_portee:
            if abs(cx - x) < 1.6 * interligne and abs(cy - bout) <= 2.6 * interligne:
                n += 1
    return n, ("haut" if vers_le_haut else "bas")


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
    compte = {}
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
            continue
        gagnant = min(candidats,
                      key=lambda c: (round(abs(y_baseline(page, c) - yd), 2),
                                     compte.get(id(c), 0), d["x0"] - c["x1"]))
        compte[id(gagnant)] = compte.get(id(gagnant), 0) + 1
    return compte


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


def lire_page(page, numero):
    staves = portees(page)
    if not staves:
        return []
    table = polices_musicales(page)
    glyphes = [c for c in page.chars if c["fontname"] in table]
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
        armure, x_fin_armure = armure_de(bande, x_cle, fin_armure, table)
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
        compte = attribuer_points(page, points, porteurs, interligne, demi)

        def points_de(c, y):
            return compte.get(id(c), 0)

        hampes_p = hampes(page, haut, bas, interligne)
        ligatures_p = ligatures(page, haut, bas, interligne)
        crochets_p = [((c["x0"] + c["x1"]) / 2, y_baseline(page, c)) for c in bande
                      if symbole(c, table) == "crochet"]

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
            crochets, sens = crochets_de(c, y, hampes_p, ligatures_p, interligne,
                                         crochets_p)
            notes.append({
                "x": round(c["x0"], 2),
                "y": round(y, 2),
                "step": step,
                "nom": nom(step, alt),
                "tete": symbole(c, table),
                "points": points_de(c, y),
                "crochets": crochets,
                "hampe": sens,
            })

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
            "_tetes": têtes,
        })

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
    for p in resultat:
        del p["_tetes"]
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

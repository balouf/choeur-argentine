#!/usr/bin/env python3
"""Écrit le `.ly` à partir de l'extraction de `pdfglyphs.py`.

Ne sort que ce qui a été **vérifié** : une mesure dont les durées ne sont pas
lues et confirmées par l'un des contrôles de `durees.py` est écrite en clair,
avec sa lecture brute et un commentaire `% À RELIRE`, plutôt que devinée. Le
fichier compile quand même — les contrôles de mesure de LilyPond signaleront
ces endroits-là, et eux seuls.

    python tools/verslily.py notes.json -o lilypond/balderrama.ly \\
        --titre "Balderrama" --compositeur "Gustavo Leguizamón" \\
        --voix Soprano=Sopr. Alto Tenor Basse

Ce qui reste à la main après coup : les liaisons, les nuances et les reprises.
Pas la césure des paroles — le graveur écrit « Tra la la » sans lier les
syllabes, et c'est délibéré : ce sont trois mots, comme les « Bom » de la
basse. On reprend ses traits d'union tels quels, absences comprises.
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

    def evenement(self, e, duree, longueur, marque=""):
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
        return corps + (figure or "") + marque


def tacet(voix, longueur):
    """Cette voix se tait-elle la mesure entière ?"""
    return (len(voix) == 1 and not voix[0]["notes"]
            and voix[0]["signe"] == "pause"
            and D.duree_lue(voix[0], longueur) == longueur)


def mesure_lily(m, longueur, plume, marques=(), numero=None):
    """Une mesure, en LilyPond. Rend aussi son sort, pour le rapport.

    Une mesure douteuse porte son **numéro** : c'est par lui qu'on la retrouve
    sur le papier, là où l'avertissement de LilyPond ne donne qu'une ligne et
    une colonne du `.ly`.
    """
    marques = marques or {}
    ou = f" mesure {numero}" if numero is not None else ""
    if m["etat"] == "deux voix":
        dessus, dessous, sur = m["voix"]
        # `\relative` ignore le `<<>>` : il parcourt les notes dans l'ordre où
        # elles sont écrites, donc la voix du bas repart de la fin de celle du
        # haut et la suite repart de la fin de celle du bas. La référence n'est
        # donc ni sauvegardée ni restaurée — la croire remise au même point
        # faisait descendre la basse du jangadero d'une octave par mesure,
        # quatre octaves en quatre mesures. Vérifié sur LilyPond lui-même :
        # `\relative c' { c4 \duo { c4 } { c,4 } c4 }` sonne do3 do3 do2 do2.
        haut = " ".join(plume.evenement(e, D.duree_lue(e, longueur), longueur,
                                        marques.get(e["x"], ""))
                        for e in dessus)
        bas = " ".join(plume.evenement(e, D.duree_lue(e, longueur), longueur,
                                       marques.get(e["x"], ""))
                       for e in dessous)
        # Commentaire de bloc et non de ligne : `%` escamote tout ce qui suit
        # jusqu'au retour à la ligne, et une mesure par système suffisait à
        # faire disparaître le reste du système — barres de contrôle
        # comprises, donc sans que LilyPond s'en plaigne.
        doute = "" if sur else f" %{{ partage des silences incertain{ou} %}}"
        # Une voix qui se tait la mesure entière ne justifie pas un `\duo` :
        # on garde l'autre seule, et la portée reste lisible. Les silences
        # plus courts, eux, restent écrits — c'est au relecteur de décider
        # s'il les garde ou les remplace par un silence invisible.
        if tacet(dessus, longueur):
            return bas + doute, m["etat"]
        if tacet(dessous, longueur):
            return haut + doute, m["etat"]
        return f"\\duo {{ {haut} }} {{ {bas} }}{doute}", m["etat"]

    durees = m["durees"]
    if m["etat"] not in ("lue", "levée", "clôture") or durees is None:
        durees = [D.duree_lue(e, longueur) for e in m["mesure"]]
    corps = " ".join(plume.evenement(e, d, longueur, marques.get(e["x"], ""))
                     for e, d in zip(m["mesure"], durees))
    if m["etat"] in ("lue", "levée", "clôture"):
        return corps, m["etat"]
    return corps + f" %{{ À RELIRE{ou} : {m['etat']} %}}", m["etat"]


def sous_une_note(ligne, xs, colle, part=0.6):
    """Une ligne de texte est-elle chantée ?

    Une parole est posée sous sa note ; un numéro de mesure, une mention
    d'éditeur, un titre de page ne le sont pas. C'est une **proportion** et
    non un compte : la mention d'éditeur de Balderrama court sur toute la
    largeur et en accroche deux ou trois au passage, mais pas les deux tiers.
    """
    if not xs or not ligne:
        return False
    proches = sum(1 for s in ligne
                  if abs(min(xs, key=lambda x: abs(x - s["x"])) - s["x"]) <= colle)
    return proches >= part * len(ligne)


# Les mots que le graveur pose dans la police des paroles sans qu'ils soient
# des paroles. Le « Fine » du candombe est gravé **au-dessus** de la portée
# suivante ; la portée la plus proche étant celle du dessus, il arrive dans
# ses paroles comme une ligne de même corps, 1,4 à 1,75 interligne sous le
# premier couplet — à deux dixièmes d'interligne de la fenêtre du second.
DIRECTIVES = {"fine", "fin", "d.c.", "dc", "d.s.", "ds", "coda", "segno",
              "da capo", "dal segno", "tacet", "solo", "tutti",
              # Termes d'expression. Le graveur les pose sous la portée, à la
              # même hauteur que les paroles et dans la même police ; rien ne
              # les en distingue qu'eux-mêmes. « dim » et « tenuto » du
              # jangadero se retrouvaient chantés.
              "dim", "dim.", "dimin.", "diminuendo",
              "cresc", "cresc.", "crescendo",
              "rit", "rit.", "ritard.", "ritardando",
              "rall", "rall.", "rallentando",
              "accel", "accel.", "accelerando",
              "a tempo", "tempo i", "tempo primo", "l'istesso tempo",
              "ten", "ten.", "tenuto", "marcato", "legato", "staccato",
              "sostenuto", "dolce", "cantabile", "espressivo", "espr.",
              "simile", "sim.", "attacca", "g.p.", "unis.", "unisono",
              "div.", "divisi", "poco a poco", "sempre", "subito"}


def directive(ligne):
    """Une ligne de texte qui n'est qu'un terme de gravure."""
    return " ".join(s["texte"] for s in ligne).strip().lower() in DIRECTIVES


def couplets(portee, xs, colle, marge=(2.0, 3.4)):
    """Les couplets gravés sous une portée, du premier au second.

    Quand la reprise change de texte, le graveur superpose deux lignes de
    paroles. Le premier couplet est **le plus haut**, jamais le mieux garni :
    page 2 de Balderrama le second a plus de syllabes que le premier, et
    garder la ligne la mieux notée faisait passer le soprano d'un couplet à
    l'autre au milieu d'une phrase — « ...del canal cuan- » puis « -chero lo
    acompaña », qui appartiennent à deux couplets différents.

    Sous une portée il n'y a pas que des paroles : un numéro de mesure, la
    mention d'éditeur du bas de page, et les signes d'une police d'ornements.
    Le second couplet se reconnaît à son ordonnée — il est gravé un
    interligne de texte sous le premier, à la ligne près — quand le reste
    tombe ailleurs, ou dans un corps plus petit.
    """
    lignes = [l for l in portee.get("paroles") or []
              if sous_une_note(l, xs, colle) and not directive(l)]
    if not lignes:
        return []
    interligne = portee["interligne"]
    premier = lignes[0]
    corps = premier[0].get("corps") or 0
    # L'écart entre les deux couplets ne se mesure pas en corps de texte : il
    # vaut 1,10 corps chez Balderrama et 1,35 chez Caminito, et une fenêtre
    # calée sur l'un rejetait l'autre de quatre centièmes. Il se mesure sur
    # l'**interligne de la portée**, qui commande l'espacement vertical de la
    # gravure entière — 2,17 au candombe, 2,5 au jangadero, 2,8 à Balderrama
    # et 3,13 à Caminito, pour la même chose.
    #
    # Le corps, lui, doit être le **même** à la virgule près : deux couplets
    # sont gravés à la même taille, une nuance à quelques pour cent près. Le
    # `p` de Caminito, à 9,38 contre 9,01, tombe sinon pile dans la fenêtre.
    second = [l for l in lignes[1:]
              if corps
              and marge[0] <= (l[0]["y"] - premier[0]["y"]) / interligne <= marge[1]
              and abs((l[0].get("corps") or 0) - corps) < 0.02 * corps]
    return [premier] + second[:1]


def apparier(syl, xs, colle, fentes=None, avale=()):
    """Une ligne de paroles LilyPond : une syllabe (ou `_`) par fente.

    Chaque syllabe est gravée sous sa note : l'abscisse suffit à les apparier,
    et une note sans syllabe reçoit le `_` que LilyPond attend — c'est le cas
    d'un mélisme, que faute de lire les liaisons on ne peut pas prolonger.

    L'appariement avance avec la lecture et ne revient jamais en arrière : une
    syllabe va à la note la plus proche parmi celles qui restent. Prendre la
    plus proche dans toute la portée donnait deux syllabes à une note et rien
    à sa voisine, et une note sur trois se retrouvait muette au milieu d'un
    mot.

    Deux syllabes sous une même note ne sont pas une césure mais une élision :
    « Si‿u », que LilyPond écrit `Si~u`.

    Une **fente** n'est pas une note : un mélisme en absorbe plusieurs pour une
    seule syllabe, et LilyPond saute alors les notes couvertes. Le nombre de
    fentes est donc une propriété de la *musique* — des liaisons qui y sont
    écrites — et non du texte : les deux couplets en voient la même suite. Le
    second se coule dans la grille du premier, qu'on lui passe ici. Sans quoi
    il dérive : au candombe le remplissage `_` du soprano posait 19 syllabes
    là où le premier couplet n'en consommait que 17, et le second couplet
    chantait « San Baltasar se hamaca » deux mesures trop tard.
    """
    par_note = defaultdict(list)
    j = 0
    for s in syl:
        k = j
        while k + 1 < len(xs) and abs(xs[k + 1] - s["x"]) < abs(xs[k] - s["x"]):
            k += 1
        # Une syllabe trop loin de la première note n'appartient pas à cette
        # portée. Le seuil se prend sur l'interligne et non en points : ce
        # qu'il mesure est l'écart entre le bord gauche d'une syllabe et
        # celui de sa tête, qui vaut une largeur de syllabe — huit points
        # fixes perdaient « tiem-bla », posé à neuf points de sa note.
        if abs(xs[k] - s["x"]) > colle and k == j and not par_note:
            continue
        # Seule une élision partage une note. Deux syllabes liées par un
        # tiret sont deux notes : les empiler ferait lire « pa -- ga » comme
        # deux syllabes sur une seule note, et LilyPond décalerait tout le
        # reste de la ligne d'un cran.
        if par_note.get(xs[k]) and par_note[xs[k]][-1]["lie"]:
            k = min(k + 1, len(xs) - 1)
        par_note[xs[k]].append(s)
        j = k              # la suivante peut retomber ici : c'est une élision
    tenues = []
    if fentes is None:
        # Une syllabe prolongée d'un trait tient sur toutes les notes que le
        # trait couvre : c'est un mélisme, et `__` le grave. Les notes
        # couvertes ne prennent alors plus de syllabe — c'est la liaison
        # posée dans la musique qui les rattache, et LilyPond les saute.
        fentes, k = [], 0
        while k < len(xs):
            groupe = par_note.get(xs[k])
            fin = k
            if groupe:
                bout = portee_du_trait(groupe[-1].get("tenue"), xs, k)
                if bout is not None and not any(par_note.get(x)
                                                for x in xs[k + 1:bout + 1]):
                    fin = bout
                    tenues.append((xs[k], xs[bout]))
            fentes.append((k, fin))
            k = fin + 1

    mots, reste = [], []
    for debut, fin in fentes:
        groupe = reste + [s for x in xs[debut:fin + 1] for s in par_note.get(x, ())]
        # Une fente ne porte qu'une syllabe, l'élision mise à part : deux
        # syllabes liées par un tiret sont deux fentes. Sur un mélisme, le
        # second couplet en amène parfois deux — « Bal -- ta -- sar » là où le
        # premier tient « nor __ » ; les empiler dans la fente décalerait
        # toute la fin de la ligne, LilyPond lisant « ta -- sar » comme deux.
        garde = 1
        while garde < len(groupe) and not groupe[garde - 1]["lie"]:
            garde += 1
        groupe, reste = groupe[:garde], groupe[garde:]
        if not groupe:
            # Une fente vide qui suit un `__` ne s'écrit pas `_` : LilyPond y
            # voit une syllabe muette **sur laquelle le trait continue**, et le
            # filet court jusqu'au mot suivant. `""` occupe la fente sans rien
            # prolonger. Sur le ténor de Balderrama, « ...de vi -- no __ _ del
            # al- » traînait le trait par-dessus le silence.
            mots.append('""' if mots and mots[-1].endswith("__") else "_")
            continue
        mot = groupe[0]["texte"]
        for precedent, suivant in zip(groupe, groupe[1:]):
            mot += ("~" if not precedent["lie"] else " -- ") + suivant["texte"]
        if groupe[-1]["lie"]:
            mot += " --"
        # Le `__` ne fait que **dessiner** le trait ; ce qui tient la syllabe
        # sur plusieurs notes est la fente, ou la liaison de tenue écrite dans
        # la musique. Trois conditions, donc, et les trois sont nécessaires :
        #
        # — ce couplet-ci porte le trait. Sinon le second couplet du candombe
        #   en traînait un depuis « bai -- la » jusqu'à sa reprise quatre
        #   mesures plus loin, là où le graveur s'arrête net ;
        # — la syllabe couvre bien plus d'une note, soit que la fente en
        #   absorbe plusieurs, soit qu'une tenue avale la suivante — c'est le
        #   cas de « rap __ » au candombe, dont la fente ne fait plus qu'une
        #   note une fois la liaison lue ;
        # — sans quoi le trait n'a rien à parcourir et LilyPond le tire
        #   jusqu'au mot d'après : à Balderrama, « que -- man -- do, __ de --
        #   le » sur une seule note.
        if groupe[-1].get("tenue") and (fin > debut or xs[debut] in avale):
            mot += " __"
        mots.append(mot)
    if reste:
        print("   ! %d syllabe(s) en trop en fin de ligne : %s"
              % (len(reste), " ".join(s["texte"] for s in reste)), file=sys.stderr)
    return " ".join(mots), tenues, fentes


def portee_du_trait(tenue, xs, k, marge=4.0):
    """Indice de la dernière note qu'un trait de prolongation couvre.

    Le trait s'arrête un peu avant sa dernière note, jamais après : la marge
    ne sert qu'à rattraper ce retrait, elle ne doit pas atteindre la note
    suivante.
    """
    if tenue is None:
        return None
    couvertes = [i for i in range(k + 1, len(xs)) if xs[i] <= tenue + marge]
    return couvertes[-1] if couvertes else None


def arcs_valides(mesures, arcs):
    """Les arcs qu'on sait attribuer : ceux qui ne touchent pas de portée divisée.

    Sur une mesure partagée entre deux voix, rien dans l'arc ne dit à
    laquelle il appartient ; l'écrire au hasard ouvrirait une liaison dans
    une voix et la fermerait dans l'autre.
    """
    # Même réserve pour une mesure dont les durées ne tombent pas juste : son
    # découpage en événements ne vaut rien, donc l'arc qui s'y appuie ouvrirait
    # une liaison que rien ne vient fermer.
    douteuses = [(min(e["x"] for e in m["mesure"]),
                  max(e["x"] for e in m["mesure"]))
                 for m in mesures
                 if m["etat"] == "deux voix"
                 or m["etat"] not in ("lue", "levée", "clôture")]
    # Le **chevauchement** et non les seuls bouts : une liaison dont les deux
    # extrémités sont dans des mesures sûres mais qui enjambe une mesure
    # divisée s'ouvre dans une voix et se ferme dans une autre.
    return [(d, f) for d, f in arcs
            if not any(d <= b and a <= f for a, b in douteuses)]


def couvert_par_arc(xs, depart, fin):
    """Les indices des événements qu'un arc couvre, bouts compris.

    Un arc est dessiné **de tête à tête sans les toucher** : son bout gauche
    tombe jusqu'à deux interlignes à droite de l'abscisse de la première tête,
    son bout droit jusqu'à deux et demi à droite de la seconde. Une fenêtre
    calée là-dessus atteindrait la note d'après, qui peut n'être qu'à 1,9
    interligne ; calée plus serré — 0,6 interligne — elle ne prenait qu'une
    tête sur deux, et aucune des liaisons de tenue de la page 1 du candombe
    n'était vue : les quatre voix chantaient articulé là où la gravure tient.

    Chaque bout se rattache donc à la tête la plus proche, sans fenêtre :
    `liaisons_de` a déjà garanti qu'il y en a une sous chacun d'eux.
    """
    if not xs:
        return []
    a = min(range(len(xs)), key=lambda i: abs(xs[i] - depart))
    b = min(range(len(xs)), key=lambda i: abs(xs[i] - fin))
    return list(range(min(a, b), max(a, b) + 1))


def arcs_de_tenue(mesures, arcs, xs, hauteurs):
    """Parmi les arcs, ceux qui sont des **liaisons de tenue**.

    Un arc sur exactement deux notes de même hauteur est une tenue : la note
    ne se réattaque pas et ne prend qu'une syllabe. Tout arc plus long est un
    **phrasé** — sur « Ca-mi-ni-to, del in-dio » de Caminito il court sur dix
    notes dont chacune a sa syllabe, et les si répétés qu'il enjambe sont
    articulés, pas tenus. Croire l'inverse liait tout un couplet en une seule
    note tenue.
    """
    tenues = []
    for depart, fin in arcs_valides(mesures, arcs):
        dedans = couvert_par_arc(xs, depart, fin)
        if len(dedans) == 2 and hauteurs[dedans[0]] == hauteurs[dedans[1]]:
            tenues.append(dedans)
    return tenues


def couverts_par(groupes):
    """Indices des événements avalés — tous sauf le premier de chaque groupe.

    Un groupe lié ne prend qu'une syllabe : les notes qu'il avale ne doivent
    pas en réclamer, pas même un `_`. Une liaison de **phrasé** n'en fait
    rien, elle : `\\( \\)` ne crée pas de mélisme et chaque note garde sa
    syllabe.
    """
    return {i for g in groupes for i in g[1:]}


def evenements_chantes(mesures):
    """Les abscisses que les paroles peuvent atteindre, dans l'ordre.

    Sur une portée divisée, `\\addlyrics` ne suit que la voix du haut : les
    notes de celle du bas ne réclament pas de syllabe. Compter les deux
    donnait au ténor du jangadero une syllabe de plus que de notes, et
    LilyPond escamotait son dernier mot.
    """
    evs = [e for m in mesures
           for e in (m["voix"][0] if m["etat"] == "deux voix" else m["mesure"])
           if e["notes"]]
    evs.sort(key=lambda e: e["x"])
    return [e["x"] for e in evs], [tuple(e["notes"]) for e in evs]


def analyse(portees, longueur):
    """Les mesures analysées, rangées par voix et par portée.

    Une seule fois pour tout le morceau : les paroles et la musique en ont
    besoin toutes les deux, et la mesure de clôture ne se reconnaît qu'en
    parcourant une voix entière.
    """
    par = defaultdict(list)
    for v, p, m in D.par_voix(portees, longueur):
        par[(v, p["page"], p["portee"])].append(m)
    return par


def franchir(lignes):
    """Le `_` qui suit un `__` devient `""`, la coupure de portée franchie.

    Les lignes d'un bloc `\\lyricmode` sont cosmétiques : LilyPond y lit un
    flux continu, donc un trait terminant une ligne court sur la fente vide
    qui ouvre la suivante. `apparier` ne voit qu'une portée à la fois et
    laissait passer ces deux-là, au ténor de Balderrama.
    """
    sortie = []
    for ligne in lignes:
        jetons = ligne.split()
        if (sortie and jetons and jetons[0] == "_"
                and sortie[-1].split()[-1:] == ["__"]):
            jetons[0] = '""'
        sortie.append(" ".join(jetons))
    # Les fentes vides de la fin ne portent rien et rien ne les suit : elles
    # ne servaient qu'à tenir le compte. Les garder laissait au soprano de
    # Balderrama un `_` derrière le dernier `__` de son second couplet.
    while sortie:
        jetons = sortie[-1].split()
        while jetons and jetons[-1] in ("_", '""'):
            jetons.pop()
        sortie[-1] = " ".join(jetons)
        if sortie[-1]:
            break
        sortie.pop()
    return sortie


def paroles_lily(portees, periode, voix, mesures_de, colle=2.5):
    """Les couplets d'une voix, chacun une liste de lignes (une par portée).

    Le second couplet ne couvre qu'une partie du morceau : il commence à la
    barre de reprise et s'arrête là où les deux couplets se rejoignent, le
    graveur ne gravant plus qu'une ligne pour les deux. LilyPond apparie les
    syllabes aux notes depuis le début de la voix, donc la ligne du second
    couplet se remplit de `_` jusqu'à son entrée — un `_` consomme une note
    sans rien écrire — puis s'arrête net à sa sortie.
    """
    voix_portees = [p for p in sorted(portees, key=lambda q: (q["page"], q["portee"]))
                    if p["portee"] % periode == voix and p["notes"]]
    # Les syllabes se posent sur les **événements** et non sur les têtes : un
    # accord ne prend qu'une syllabe, et c'est aussi ce qui permet de rendre
    # les mélismes en abscisses d'événement, où la musique les retrouvera.
    abscisses, avales = [], []
    for p in voix_portees:
        mesures = mesures_de[(voix, p["page"], p["portee"])]
        xs, hauteurs = evenements_chantes(mesures)
        tenues = arcs_de_tenue(mesures, p.get("liaisons") or (), xs, hauteurs)
        couverts = couverts_par(tenues)
        abscisses.append([x for i, x in enumerate(xs) if i not in couverts])
        # Les notes qui en avalent une autre : leur syllabe couvre deux notes
        # même si sa fente n'en montre plus qu'une, et elle peut donc porter
        # un trait de prolongation.
        avales.append({xs[g[0]] for g in tenues})
    colles = [colle * p["interligne"] for p in voix_portees]
    tous = [couplets(p, xs, c) for p, xs, c in zip(voix_portees, abscisses, colles)]
    seconds = [i for i, c in enumerate(tous) if len(c) > 1]

    liaisons = defaultdict(list)
    def rendre(i, ligne, xs, k, fentes=None):
        texte, tenues, fentes = apparier(ligne, xs, k, fentes, avales[i])
        p = voix_portees[i]
        liaisons[(p["page"], p["portee"])].extend(tenues)
        return texte, fentes

    premier, second = [], []
    for i, (c, xs, k) in enumerate(zip(tous, abscisses, colles)):
        # Les deux couplets avancent du même pas. Une portée dont aucune ligne
        # n'a été lue ne donnait rien au premier mais une ligne de `_` au
        # second, qui prenait dès lors une portée d'avance : au soprano de
        # Caminito le second couplet entrait un système trop tôt.
        if not c:
            continue
        texte, fentes = rendre(i, c[0], xs, k)
        premier.append(texte)
        if not seconds or i > seconds[-1]:
            continue
        # Le second couplet se coule dans la grille du premier : c'est la
        # musique qui dit combien de syllabes elle prend, et les deux couplets
        # lisent la même. Une portée sans second couplet se remplit de `_`,
        # un par fente et non un par note.
        second.append(rendre(i, c[1], xs, k, fentes)[0] if len(c) > 1
                      else " ".join("_" for _ in fentes))
    premier, second = franchir(premier), franchir(second)
    return ([premier] if not seconds else [premier, second]), liaisons


def marques_de_liaison(mesures, tenues, arcs=()):
    """Les `~` et les `( )` d'un mélisme, par abscisse d'événement.

    Deux notes voisines de même hauteur sous une seule syllabe sont une
    **liaison de tenue** : la note ne se réattaque pas, et le MIDI doit
    l'entendre ainsi. Le reste du mélisme est une liaison de phrasé, qui ne
    change que la gravure. Les deux coexistent — « pa-rar » tenu sur sol♯,
    fa♯, fa♯ est un phrasé des trois avec une tenue entre les deux fa♯.

    C'est une déduction et non une lecture : l'arc est bien dans le vectoriel,
    plat pour une tenue et bombé pour un phrasé, mais Ghostscript le
    redistille en fragments — le candombe rend 434 courbes plates et aucun
    arc. La déduction, elle, ne dépend que des hauteurs.
    """
    # Les mêmes événements que les paroles : sur une portée divisée, le
    # mélisme ne parle que de la voix du haut, et lier la voix du bas au
    # passage y ajouterait des tenues que la gravure n'a pas.
    evenements, divisees = {}, []
    for m in mesures:
        if m["etat"] == "deux voix":
            divisees.append((min(e["x"] for e in m["mesure"]),
                             max(e["x"] for e in m["mesure"])))
        for e in (m["voix"][0] if m["etat"] == "deux voix" else m["mesure"]):
            if e["notes"]:
                evenements[e["x"]] = e

    xs = sorted(evenements)

    def groupe(depart, fin):
        # Les mélismes arrivent déjà en abscisses d'événement — `apparier` les
        # a posées — et les arcs en coordonnées de dessin : le rattachement à
        # la tête la plus proche est exact pour les uns et juste pour les
        # autres.
        return [xs[i] for i in couvert_par_arc(xs, depart, fin)]

    marques = defaultdict(str)
    liees = set()
    lus = arcs_valides(mesures, arcs)

    # 1. Les liaisons de **tenue** : un arc sur deux notes de même hauteur.
    for depart, fin in lus:
        g = groupe(depart, fin)
        if len(g) == 2 and evenements[g[0]]["notes"] == evenements[g[1]]["notes"]:
            marques[g[0]] += "~"
            liees.add((g[0], g[1]))

    # 2. Les **mélismes**, déduits du trait de prolongation des paroles : une
    #    syllabe tenue sur plusieurs notes. `( )` crée le mélisme dont
    #    LilyPond a besoin pour ne pas redemander de syllabe.
    occupes = []
    for depart, fin in sorted(tenues):
        g = groupe(depart, fin)
        if len(g) < 2 or any(a <= g[-1] and g[0] <= b for a, b in occupes):
            continue
        occupes.append((g[0], g[-1]))
        hauteurs = [evenements[x]["notes"] for x in g]
        # Un trait de prolongation sur des notes de même hauteur ne dit pas
        # qu'elles sont tenues, seulement qu'une syllabe les couvre. Ce qui
        # tranche est l'arc, et quand la portée en donne on s'y tient. Le
        # candombe écrit « domdom » d'un seul tenant sous deux ré, si serré
        # que la couche texte n'en fait qu'un jeton, et son trait appartient
        # au second : le déduire tenu faisait sonner une blanche là où le
        # graveur n'arque rien et où il y a deux noires. Sans arc lisible la
        # déduction reste le seul recours, et elle a servi jusqu'ici.
        if len(set(map(tuple, hauteurs))) == 1 and not lus:
            for a, b in zip(g, g[1:]):
                if (a, b) not in liees:
                    marques[a] += "~"
        else:
            marques[g[0]] += "("
            marques[g[-1]] += ")"

    # 3. Les liaisons de **phrasé** : tout arc plus long que deux notes et qui
    #    ne redit pas un mélisme déjà posé. Un arc dont la portée tombe dans
    #    celle d'un mélisme n'est pas un phrasé de plus : c'est *ce* mélisme,
    #    lu une seconde fois — une fois dans le dessin, une fois dans le trait
    #    de prolongation des paroles. Le ténor de Balderrama écrivait ainsi
    #    `cis4(\( b4 ais4)\)`, deux marques pour une seule chose, et c'était
    #    le dernier phrasé que la partition n'a pas. Le vrai phrasé est un arc
    #    sur des notes qui gardent chacune leur syllabe : les dix notes de
    #    « Ca-mi-ni-to, del in-dio » chez Caminito, qu'aucun mélisme ne couvre.
    phrases = []
    for depart, fin in sorted(arcs_valides(mesures, arcs)):
        g = groupe(depart, fin)
        if len(g) < 3 or any(a <= g[-1] and g[0] <= b for a, b in phrases):
            continue
        if any(a <= g[0] and g[-1] <= b for a, b in occupes):
            continue
        phrases.append((g[0], g[-1]))
        marques[g[0]] += "\\("
        marques[g[-1]] += "\\)"
    return dict(marques)


def marques_de_nuance(portee, mesures, marge=3.0):
    """Les `\\p`, `\\mf`… par abscisse d'événement.

    Une nuance est gravée à l'aplomb de la note qu'elle ouvre, à un chouïa
    près ; on la rattache à l'événement le plus proche, silences compris —
    LilyPond accepte `r4\\p` et le graveur l'écrit ainsi quand la voix entre
    après un silence.
    """
    xs = sorted({e["x"] for m in mesures
                 for e in (m["voix"][0] + m["voix"][1]
                           if m["etat"] == "deux voix" else m["mesure"])})
    marques = {}
    for n in portee.get("nuances") or []:
        if not xs:
            break
        x = min(xs, key=lambda v: abs(v - n["x"]))
        if abs(x - n["x"]) <= marge * portee["interligne"]:
            marques[x] = marques.get(x, "") + "\\" + n["texte"]
    return marques


def marques_de_staccato(mesures):
    """Les `-.` par abscisse, lus sur les notes que l'extracteur a marquées.

    Pas de fenêtre ici : l'appariement point ↔ tête est déjà fait, à la
    géométrie, dans `pdfglyphs.attribuer_staccatos`. Une portée divisée à
    l'unisson porte son point des deux côtés d'une seule tête ; elle n'a
    qu'une articulation à écrire, et le `set` des têtes marquées s'en charge.
    """
    marques = {}
    for m in mesures:
        evenements = (m["voix"][0] + m["voix"][1]
                      if m["etat"] == "deux voix" else m["mesure"])
        for e in evenements:
            if e.get("staccato"):
                marques[e["x"]] = "-."
    return marques


def voix_lily(portees, periode, voix, longueur, mesures_de,
              liaisons=None, structure=None):
    """Le bloc `<nom>_music` d'une voix, et le compte de ses mesures douteuses.

    `structure` porte ce que le dessin ne donne pas encore — reprise, crochets
    de première et deuxième fois, doubles barres — en numéros de mesure. Ces
    mots-clés sont posés dans **toutes** les voix : une reprise gravée dans la
    seule voix du haut affiche bien ses barres, décidées au niveau du système,
    mais `\\unfoldRepeats` ne déplierait qu'elle et le MIDI perdrait sa
    synchronisation.
    """
    structure = structure or {}
    portees_voix = [p for p in sorted(portees, key=lambda p: (p["page"], p["portee"]))
                    if p["portee"] % periode == voix]
    cle = portees_voix[0]["cle"]
    ancre, reference = ANCRE[cle]
    plume = Plume(reference)
    lignes, douteuses, systeme, numero = [], 0, None, 0
    premiere = True
    for p in portees_voix:
        mesures = mesures_de[(voix, p["page"], p["portee"])]
        marques = marques_de_liaison(
            mesures, (liaisons or {}).get((p["page"], p["portee"]), ()),
            p.get("liaisons") or ())
        # L'ordre des signes après la note : liaison, articulation, nuance.
        for x, point in marques_de_staccato(mesures).items():
            marques[x] = marques.get(x, "") + point
        # La nuance se pose après la liaison : `c4~\p` et non `c4\p~`.
        for x, nuance in marques_de_nuance(p, mesures).items():
            marques[x] = marques.get(x, "") + nuance
        if systeme is not None and (p["page"], p["systeme"]) != systeme:
            lignes.append("")
        systeme = (p["page"], p["systeme"])
        morceaux = []
        for m in mesures:
            numero += 1
            morceaux += ouvertures(structure, numero)
            texte, etat = mesure_lily(m, longueur, plume, marques, numero)
            if etat == "levée" and premiere:
                somme = sum(D.duree_lue(e, longueur) for e in m["mesure"])
                morceaux.append("\\partial " + (duree_lily(somme) or "4"))
            if etat not in ("lue", "levée", "clôture", "deux voix"):
                douteuses += 1
            morceaux.append(texte)
            # Pas de contrôle de mesure après la clôture : elle est écourtée
            # de la levée, délibérément, et LilyPond a raison de s'en plaindre
            # partout ailleurs.
            morceaux.append("|" if etat != "clôture"
                            else "% clôture, écourtée de la levée\n ")
            morceaux += fermetures(structure, numero)
            premiere = False
        lignes.append("  " + " ".join(morceaux))
    return "\n".join(lignes), douteuses, cle, ancre


def ouvertures(structure, numero):
    """Les mots-clés à poser *avant* la mesure `numero`."""
    sortie = []
    reprise = structure.get("reprise")
    if reprise and numero == reprise[0]:
        sortie.append("\n  \\repeat volta 2 {")
    for i, (debut, _) in enumerate(structure.get("volta", ())):
        if numero == debut:
            sortie.append("\n  \\alternative {\n    {" if i == 0 else "\n    {")
    return sortie


def fermetures(structure, numero):
    """Les accolades à poser *après* la mesure `numero`."""
    sortie = []
    voltas = structure.get("volta", ())
    for i, (_, fin) in enumerate(voltas):
        if numero == fin:
            sortie.append("}")
            if i == len(voltas) - 1:
                sortie.append("\n  }\n  }")
    reprise = structure.get("reprise")
    if reprise and numero == reprise[1] and not voltas:
        sortie.append("\n  }")
    if numero in structure.get("double_barre", ()):
        sortie.append('\\bar "||"')
    return sortie


def intervalle(texte):
    """« 44-45 » → (44, 45), pour les options de structure."""
    debut, _, fin = texte.partition("-")
    return int(debut), int(fin or debut)


def ecrire(portees, args):
    periode = portees[0]["portees_par_systeme"]
    structure = {"reprise": intervalle(args.reprise) if args.reprise else None,
                 "volta": [intervalle(v) for v in args.volta or ()],
                 "double_barre": set(args.double_barre or ())}
    chiffrage = next(p["chiffrage"] for p in portees if p.get("chiffrage"))
    longueur = F(chiffrage[0] * 4, chiffrage[1])
    dieses = portees[0]["armure_dieses"]
    bemols = portees[0]["armure_bemols"]
    force = "minor" if args.mineur else "major" if args.majeur else None
    mesures_de = analyse(portees, longueur)
    note, mode, finale = tonalite(portees, dieses, bemols, force)
    print(f"   armure {dieses}# {bemols}b, basse finale {finale} → "
          f"{note} {mode}", file=sys.stderr)

    noms, variables = [], []
    for i, entree in enumerate(args.voix or [f"voix{i}" for i in range(periode)]):
        # « Soprano=Sopr. » : à gauche le nom des variables, à droite ce que le
        # graveur écrit devant la portée. Sans `=`, les deux coïncident.
        source, _, affiche = entree.partition("=")
        noms.append(affiche or source)
        variables.append(re.sub(r"\W+", "", source.lower()) or f"voix{i}")

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
        # Les paroles d'abord : ce sont leurs traits de prolongation qui
        # donnent les liaisons de la partie chantée.
        # Un piano ne chante pas. Caminito grave pourtant les paroles de la
        # basse une seconde fois sous la portée de main gauche, et sans cette
        # réserve elles revenaient une seconde fois dans le `.ly`.
        if v >= periode - args.piano:
            couplets_voix, liaisons = [], {}
        else:
            couplets_voix, liaisons = paroles_lily(portees, periode, v, mesures_de)
        corps, douteuses, cle, ancre = voix_lily(
            portees, periode, v, longueur, mesures_de, liaisons, structure)
        bilan[nom_affiche] = douteuses
        out.append(f"{var}_music = {{")
        out.append(corps)
        out.append("}")
        out.append("")
        # Un couplet par bloc `_lyrics`, numéroté à partir du second : autant
        # de `\addlyrics` empilés que le graveur a gravé de lignes.
        variables_paroles = []
        for i, couplet in enumerate(couplets_voix):
            if not couplet:            # une portée instrumentale ne chante pas
                continue
            suffixe = "_lyrics" + ("" if i == 0 else "_" + "i" * (i + 1))
            variables_paroles.append(var + suffixe)
            out.append(f"{var}{suffixe} = \\lyricmode {{")
            for ligne in couplet:
                out.append("  " + ligne)
            out.append("}")
            out.append("")
        court = nom_affiche[0].upper() + "."
        if v >= periode - args.piano:
            # Une portée de piano ne porte pas son nom : c'est le PianoStaff
            # qui l'accolade et qui le porte, pour les deux à la fois.
            out.append(f"{var} = \\new Staff <<")
        else:
            out.append(f'{var} = \\new Staff \\with {{instrumentName="{nom_affiche}"')
            out.append(f'  shortInstrumentName ="{court}"}} <<')
        out.append(f"  \\{STYLE[cle]}")
        out.append("  \\armure")
        out.append(f"  \\relative {ancre} {{\\{var}_music}}")
        for nom_paroles in variables_paroles:
            out.append(f"  \\addlyrics {{\\{nom_paroles}}}")
        out.append(">>")
        out.append("")

    chantees = variables[:periode - args.piano]
    if args.piano:
        out += [f'piano = \\new PianoStaff \\with {{instrumentName="Piano"',
                '  shortInstrumentName ="Pno."}',
                "  <<"]
        out += [f"    \\{v}" for v in variables[periode - args.piano:]]
        out += ["  >>", ""]
    appel = "\n".join(
        ["      \\new ChoirStaff <<"]
        + [f"        \\{v}" for v in chantees]
        + ["      >>"]
        + (["      \\piano"] if args.piano else []))
    out += ["#(set-global-staff-size conductor_size)",
            "\\book {",
            "  \\score {",
            "    \\layout {",
            "      \\context {",
            "        \\Staff",
            "        \\RemoveEmptyStaves",
            "      }",
            "    }",
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
    ap.add_argument("--version", default="2.26.0")
    ap.add_argument("--voix", nargs="*",
                    help="noms des pupitres, de haut en bas ; « Soprano=Sopr. » "
                         "nomme les variables à gauche, la portée à droite")
    ap.add_argument("--piano", type=int, default=0,
                    help="nombre de portées finales réunies en PianoStaff")
    ap.add_argument("--reprise", help="mesures du corps répété, ex. 10-43")
    ap.add_argument("--volta", nargs="*",
                    help="mesures de chaque fois, ex. 44-45 46-47")
    ap.add_argument("--double-barre", nargs="*", type=int,
                    help="mesures après lesquelles poser une double barre")
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

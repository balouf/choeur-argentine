# tools — transcription PDF → LilyPond

Outillage pour reprendre une partition gravée sans la resaisir. Scripts autonomes
(métadonnées PEP 723), hors du build du site : aucune de leurs dépendances
n'entre dans `pyproject.toml`.

```
uv run tools/pdfglyphs.py partition.pdf -o notes.json     # extraction
uv run tools/pdfglyphs.py partition.pdf --pages 1 --overlay v.png   # vérification
uv run tools/pdfglyphs.py partition.pdf --codes           # relever un encodage
python tools/durees.py notes.json [--detail --page 1]     # durées
python tools/pitchdiff.py notes.json partition.mxl        # confrontation à l'OMR
```

## Le principe

Un PDF sorti d'un éditeur de partition ne contient pas une image : les têtes de
notes sont des glyphes d'une police musicale à coordonnées exactes, les portées
et les ligatures des objets vectoriels. **La hauteur est une division, pas une
reconnaissance de forme**, et la durée se lit sur le dessin — type de tête,
crochets de la hampe, points d'augmentation. L'OMR, lui, rastérise puis
redevine : il rate 15 à 45 % des notes sur ce corpus, en les dispersant parfois
dans des parties fantômes. D'où le choix de l'extraction géométrique comme
source principale.

Seul le manuscrit (`Cuando tenga la tierra`) échappe à cette voie : il se saisit
à la main.

## Deux contrôles indépendants

La somme de la mesure vérifie les durées **à l'intérieur** d'une mesure : si le
chiffrage ne tombe pas juste, un signe a été mal lu. Elle ne dit rien d'une
mesure entièrement perdue, puisqu'il ne reste alors rien à sommer.

C'est le second contrôle qui l'attrape : un système est barré d'un seul tenant,
donc toutes ses voix y ont le même nombre de mesures. Une voix qui en compte une
de moins a perdu tout le contenu d'une mesure. `durees.py` rend les deux.

Les deux ensemble valent mieux que chacun : les rondes du candombe, dont le
glyphe manquait à la table, ne faisaient sonner aucune alarme de somme — elles
laissaient deux mesures de ténor vides, que seule la concordance a signalées.

Réserve : la somme ne vaut que sur une portée **monodique**. Une portée divisée
totalise autant de fois la mesure qu'elle porte de voix, et son verdict
« somme fausse » ne veut rien dire tant que les voix ne sont pas séparées.

## État au 12 septembre 2026

| Partition | Notes | Mesures | Lues | Résolues |
|---|---|---|---|---|
| Leguizamón, *Balderrama* | 689 | 188 | 100 % | **100 %** |
| Dávalos, *Canción del jangadero* | 575 | 256 | 99,2 % | 99,2 % |
| *Candombe del seis de enero* | 1052 | 148 | 94,6 % | **100 %** |
| Atahualpa, *Caminito del indio* | 1200 | 330 | 64,8 % | 87,5 % |

Concordance des voix : les quatre partitions donnent le même découpage en
mesures dans toutes leurs voix, système par système — et pour le candombe comme
pour le jangadero, exactement celui relevé à l'œil sur le papier.

Les deux mesures restantes du jangadero et les 41 de Caminito ne sont pas des
erreurs de lecture mais des **portées divisées** : trois voix à la fin du
jangadero, et tout le piano de Caminito (les quatre voix chorales y sont à
217/220). Elles se résoudront avec la séparation par le sens des hampes.

Hauteurs vérifiées : overlay (un cercle par tête, rien d'autre) et recoupement
avec des repères donnés par l'oreille humaine sur le candombe — sept sur sept.

## Ce qui a coûté cher à trouver

Les commentaires du code portent le détail ; voici la liste de rappel.

**Table de glyphes**

- **Ne jamais créditer une entrée sans contrôle visuel.** Trois devinettes
  plausibles, trois erreurs : `0x2030` pris pour une blanche (c'est un
  demi-soupir), `0x62` pour un bémol (c'est une acciaccatura), la clé de sol
  octaviée supposée être une clé plus un « 8 » (c'est un glyphe à part chez
  Maestro, mais bien un « 8 » séparé chez Opus — et d'une autre police).
- **L'encodage appartient au glyphe, pas à la police.** Un des trois Maestro de
  Balderrama grave ses pauses en `0x2211` et ses demi-pauses en `0xF0EE` :
  trancher la disposition une fois pour toute la police en perdait la moitié.
- **Pause et demi-pause ont deux codes, et la position n'en dit rien** : les
  silences ont tous leur baseline sur la ligne médiane. Lequel vaut quoi a été
  établi par calibration — dans les mesures où toutes les autres durées se
  lisent, le résidu vaut la mesure entière pour l'un et deux noires pour
  l'autre, sur les quatre partitions.
- **Une partition peut utiliser plusieurs polices musicales.** Balderrama en a
  trois : têtes, pauses et quelques blanches isolées.
- **Une police de paroles décode ses `b`, `n` et `.` en bémol, bécarre et
  point.** Pour admettre une police : encodage symbolique (0xF000+), ou bien une
  signature qu'aucun texte ne produit (tête, clé, silence) *et* une majorité de
  glyphes connus.
- **Le garde-fou des codes manquants a deux angles morts.** Un glyphe trop rare
  ne l'atteint pas (deux rondes dans tout le candombe) : c'est la concordance
  des voix qui l'attrape. Un glyphe dominant, lui, disqualifie sa police tout
  entière quand on le retire — et la partition rend alors zéro note, ce qui ne
  passe pas inaperçu.

**Ligatures, hampes, points**

- **Une ligne de portée passe tous les tests d'une ligature** : large, plate, à
  la bonne ordonnée. Seule sa largeur l'en distingue, et le seuil est celui qui
  la définit comme ligne de portée. Sans lui, sur le candombe, les filets de
  deux lignes voisines se rejoignaient à travers les vraies ligatures et la
  barre fictive ajoutait un crochet à presque toute la page.
- **Ce qui sépare deux ligatures superposées, c'est leur étendue horizontale,
  pas leur écart vertical** : 0,84 pt entre la principale et la secondaire du
  candombe, sous toute tolérance de fusion utilisable. Les filets d'une même
  ligature, eux, partagent ses deux abscisses à la virgule près.
- **Le préfiltre en hauteur ne voit que la pente, le contrôle d'après fusion y
  ajoute l'épaisseur** : le premier doit donc être plus bas que le second d'une
  épaisseur de ligature. Calé trop bas, il rejetait un sixième des mesures de
  Balderrama.
- **Fusionner de proche en proche**, jamais par rapport au premier élément du
  paquet : une ligature redistillée en trente-cinq filets se scinderait, et
  chaque morceau compterait un crochet de plus.
- **La hampe d'une note est la plus proche, pas la plus longue.** Une barre de
  mesure passe le filtre de proximité de la note qui la précède, et elle est
  toujours plus longue qu'une hampe.
- **Une ligature fractionnaire — le crochet court qui ne vaut que pour une note
  du groupe — s'arrête entre deux hampes.** La marge d'attachement doit rester
  bien plus étroite que l'espacement des notes, sinon elle déborde sur la
  voisine et la raccourcit de moitié.
- **Un point d'augmentation n'appartient qu'à une note.** Dans un accord, les
  têtes sont à un interligne et les points décalés d'un demi : chaque point
  tombe dans la fenêtre de deux têtes, et les accords finaux du jangadero
  devenaient des blanches doublement pointées.
- **Une barre de mesure ne passe jamais par une tête de note ; une hampe y est
  toujours accolée.** C'est le seul critère qui sépare les deux, la contrainte
  de hauteur laissant passer la hampe d'une note posée sur la ligne du bas.

**Conventions d'écriture**

- **Un morceau qui commence par une levée et se termine sur une reprise finit
  sur une mesure écourtée d'autant** : le candombe, 0,75 noire au début et 3,25
  à la fin. Lecture juste, somme apparemment fausse.
- **Il n'y a qu'une levée, au tout début.** La tolérer à la première mesure de
  chaque système faisait passer pour des levées sept vraies erreurs.
- **L'espacement horizontal ne départage pas une croche d'une double.** Une
  version antérieure du solveur s'en contentait : sur deux mesures identiques
  elle rendait deux réponses différentes, fausses toutes les deux.
- Audiveris n'est pas constant sur l'octave des pupitres en clé de sol
  octaviée ; `pitchdiff` aligne donc sur les noms de notes et classe l'octave à
  part.

## Reste à faire

1. Séparation des voix par le sens des hampes, pour les portées divisées
   (piano de Caminito, fin du jangadero). C'est le seul verrou restant sur les
   durées, et c'est de toute façon un préalable à la génération du `.ly` :
   on n'écrit pas un `\duo` sans savoir quelle note va à quelle voix.
2. Génération du `.ly` dans l'idiome du dépôt : variables `<voix>_music` /
   `<voix>_lyrics`, `\relative`, `\addlyrics`, styles de `utils/macros.ly`,
   macro `\duo` pour les portées à deux voix. Paroles reprises de la couche
   texte via `pdftotext`, plus fiables que l'OCR.
3. Liaisons (de tenue et de phrasé) : elles sont dans le vectoriel, elles ne
   sont pas encore lues.
4. Saisie manuelle du manuscrit `Cuando tenga la tierra`.

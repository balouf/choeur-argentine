# tools — transcription PDF → LilyPond

Outillage pour reprendre une partition gravée sans la resaisir. Scripts autonomes
(métadonnées PEP 723), hors du build du site : aucune de leurs dépendances
n'entre dans `pyproject.toml`.

```
uv run tools/pdfglyphs.py partition.pdf -o notes.json     # extraction
uv run tools/pdfglyphs.py partition.pdf --pages 1 --overlay v.png   # vérification
uv run tools/pdfglyphs.py partition.pdf --codes           # relever un encodage
python tools/durees.py notes.json [--detail --page 1]     # durées
python tools/verslily.py notes.json -o lilypond/x.ly ...  # génération
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

## Quatre contrôles indépendants

**La somme de la mesure** vérifie les durées *à l'intérieur* d'une mesure : si le
chiffrage ne tombe pas juste, un signe a été mal lu.

**La concordance des voix** attrape ce que la somme ne peut pas voir — une mesure
entièrement perdue, dont il ne reste rien à sommer. Un système est barré d'un
seul tenant, donc toutes ses voix y ont le même nombre de mesures. C'est ce
contrôle qui a trouvé les rondes du candombe, dont le glyphe manquait à la
table : deux mesures de ténor vides, et aucune alarme ailleurs.

**Le partage en deux voix** rend son sens à la somme sur une portée divisée, qui
totalise autant de fois la mesure qu'elle porte de voix. Le sens des hampes le
propose — les têtes d'une même voix partagent leur orientation — mais ne prouve
rien : une portée monodique retourne aussi ses hampes autour de la ligne
médiane. Le partage n'est donc tenté que si la mesure déborde, et retenu que
s'il tombe juste **des deux côtés**. Il est alors vérifié, pas présumé, et c'est
lui qui donne les `\duo` à la génération.

**L'aller-retour par le MIDI** vérifie la génération et non plus la lecture :
le `.mid` que LilyPond produit doit redonner, piste par piste et note par note,
la suite de hauteurs extraite du PDF. Sur Balderrama, 689 notes identiques. Ce
contrôle-là est exhaustif et gratuit, là où relire la gravure ne l'est ni l'un
ni l'autre.

## État au 12 septembre 2026

Le tableau ne compte que les mesures **lues et vérifiées** : les durées viennent
du dessin, et l'un des contrôles les confirme. Les verdicts du solveur par
somme — « unique par somme », « par espacement » — n'y figurent pas : ce sont
des mesures où la lecture s'est contredite et où le solveur a reconstruit autre
chose, donc des mesures à relire.

| Partition | Notes | Mesures | Vérifiées |
|---|---|---|---|
| Leguizamón, *Balderrama* | 689 | 188 | **188 (100 %)** |
| *Candombe del seis de enero* | 1052 | 148 | **148 (100 %)** |
| Dávalos, *Canción del jangadero* | 575 | 256 | 254 (99,2 %) |
| Atahualpa, *Caminito del indio* | 1200 | 330 | 313 (94,8 %) |

Caminito se lit à deux vitesses : ses quatre voix chorales sont à **220/220**, son
piano à 93/110. Les deux mesures du jangadero qui résistent sont à **trois** voix,
que le partage ne sait pas encore faire.

Concordance des voix : les quatre partitions donnent le même découpage en
mesures dans toutes leurs voix, système par système — et pour le candombe comme
pour le jangadero, exactement celui relevé à l'œil sur le papier.

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
- **Une ligature s'appuie sur des hampes, une liaison de phrasé sur rien.**
  C'est le seul critère qui les sépare : pdfplumber aplatit l'arc d'une liaison
  sur ses deux extrémités et en rend une boîte large, plate et inclinée — une
  ligature au pixel près. Sur Caminito, elles ajoutaient un crochet à des
  noires isolées.
- **Le sens d'une hampe se décide par hampe, pas par tête.** Dans un accord
  étalé, la tête la plus éloignée de la tête d'attache est plus près du bout
  libre que de l'autre bout, et le sens se retournait pour elle seule.
- **Une hampe ne porte jamais deux têtes de même hauteur** : deux têtes
  superposées à l'identique sont deux voix à l'unisson, et chacune a la sienne.
- **Une hampe se raccourcit quand sa note s'éloigne de la portée** : la plus
  courte du corpus ne fait qu'un interligne trois quarts, bien loin des trois
  et demi canoniques. Un plancher à deux interlignes la perdait, et sa blanche
  devenait une ronde faute de hampe.
- **Une police d'ornements se reconnaît à son corps.** Elle n'a ni tête, ni
  clé, ni silence à exhiber, et trop peu de glyphes connus pour un critère de
  couverture ; mais elle est gravée à la taille de la musique, quand les
  paroles le sont à la moitié. L'écart est une constante de gravure : aucune
  police de texte des quatre partitions n'approche la taille de la musique à
  10 % près.

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

## Ce que la génération ne lit pas

`verslily.py` écrit les hauteurs, les durées, l'armure, le chiffrage, les clés,
les `\duo` des portées divisées et les paroles syllabe à syllabe. Il ne lit ni
les liaisons (de tenue comme de phrasé), ni les barres de reprise et les doubles
barres, ni les nuances, ni les repères. Ce sont des ajouts, pas des corrections :
ils ne remettent pas en cause ce qui est écrit.

Une conséquence à ne pas oublier : sans liaison de tenue, le MIDI réattaque une
note liée par-dessus la barre. Et sans mélisme, une syllabe tenue sur plusieurs
notes laisse des `_` là où la gravure tire un trait.

Deux choses se décident à l'oreille et non sur le dessin : le **tempo**, que la
partition ne porte pas toujours, et la **césure des paroles** là où le graveur
n'a pas mis de trait d'union. Tout le reste se déduit — la tonalité comprise,
que la finale de la basse tranche entre la majeure et sa relative mineure.

## Reste à faire

1. Liaisons de tenue : elles changent le MIDI, et ce sont les seules qui
   manquent vraiment. Elles sont dans le vectoriel, la détection des ligatures
   les côtoie déjà pour les écarter.
2. Trois voix sur une portée : la fin du jangadero, et quelques mesures du
   piano de Caminito. Le partage actuel n'en sépare que deux.
3. Générer les trois autres partitions, puis les relire.
4. Saisie manuelle du manuscrit `Cuando tenga la tierra`.

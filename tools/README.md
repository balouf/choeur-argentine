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
uv run tools/allerretour.py lilypond/x.ly notes.json      # MIDI vs PDF
python tools/pitchdiff.py notes.json partition.mxl        # confrontation à l'OMR
```

**Noms de pupitre.** Les cinq partitions de 2026-2027 portent les mêmes, et le
mélangeur du site les reprend tels quels : `Sopr.`, `Alto`, `Tenor`, `Basse`,
abrégés en `S.`, `A.`, `T.`, `B.` sur les systèmes suivants. Leurs **variables**
sont alignées elles aussi — `soprano_`, `alto_`, `tenor_`, `basse_` — pour que
la transplantation d'un fichier régénéré vers un fichier corrigé à la main
n'ait pas à les traduire. Mais `Sopr.` donnerait la variable `sopr` : les deux
noms ne coïncident pas, et le choix d'abréger le seul soprano tient à la largeur
de la colonne, pas à une règle. Un pupitre s'écrit donc `variable=affiché`, et
sans `=` les deux ne font qu'un. La génération conforme est :

```
--voix Soprano=Sopr. Alto Tenor Basse
```

Le nom court des systèmes suivants reste déduit — initiale de l'affiché, plus un
point.

Renommer une variable à la main ne se fait pas par un simple remplacement de
mot : `bajo`, `alto` et `bass` sont aussi des mots des paroles. Une variable ne
se reconnaît qu'à sa définition — en début de ligne, suivie d'un `=` — et à ses
appels, précédés d'une contre-oblique.

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

**L'aller-retour par le MIDI** (`allerretour.py`) vérifie la génération et non
plus la lecture : le `.mid` que LilyPond produit doit redonner, piste par piste
et note par note, la suite de hauteurs extraite du PDF. Sur Balderrama, 689
notes identiques. Ce contrôle-là est exhaustif et gratuit, là où relire la
gravure ne l'est ni l'un ni l'autre.

Il recompile une copie du `.ly` **sans `\unfoldRepeats`** : la comparaison
porte sur ce qui est écrit, une fois, comme le PDF source ; déplier ferait
diverger les deux suites à la première reprise sans que rien soit faux. Une
liaison de tenue est la **seule** raison légitime pour que le MIDI soit plus
court : elle n'ôte qu'une note égale à celle qui la précède. La confrontation
est donc exacte et non approchée — à chaque pas, ou les deux suites
concordent, ou une liaison a absorbé la note, ou c'est un désaccord. Un
appariement par ressemblance ne suffisait pas : sur le candombe, où les notes
répétées abondent, `difflib` rendait des blocs déplacés de cinquante notes là
où tout était juste.

Sur une portée polyphonique il se replie sur une confrontation **mesure par
mesure**, insensible à l'ordre. Deux notes simultanées sont écrites l'une
après l'autre au PDF, et rien ne dit laquelle le MIDI émettra d'abord : le
seul ordre qui ait un sens y est celui des mesures. Le repli est plus faible —
il ne vérifie plus l'ordre à l'intérieur d'une mesure — mais il garde tout le
reste, et c'est lui qui montre qu'une mesure dont les durées ne tombent pas
juste décale tout ce qui la suit.

## État au 14 septembre 2026

Les quatre partitions vectorielles sont générées, compilées et au programme de
2026-2027. Le tableau ne compte que les mesures **lues et vérifiées** : les
durées viennent du dessin, et l'un des contrôles les confirme. Les verdicts du
solveur par somme — « unique par somme », « par espacement » — n'y figurent
pas : ce sont des mesures où la lecture s'est contredite et où le solveur a
reconstruit autre chose, donc des mesures à relire.

Il compte des **mesures**, donc des durées : c'est ce que le contrôle de mesure
de LilyPond sait vérifier. Les **hauteurs** ne s'y voient pas, et c'est
précisément par là que la relecture du jangadero est entrée — quatre défauts
d'altération, dont trois touchaient les quatre partitions, pour 48 notes du
jangadero, 2 de Balderrama et 0 des deux autres. Le contrôle qui les attrape
tous est ajouté depuis : **toutes les portées d'un morceau lisent la même
armure**, et elles la lisent maintenant.

| Partition | Notes | Mesures | Vérifiées | Aller-retour MIDI |
|---|---|---|---|---|
| Leguizamón, *Balderrama* | 689 | 188 | **188 (100 %)** | **689 / 689** |
| *Candombe del seis de enero* | 1052 | 148 | **148 (100 %)** | **1052 / 1052** |
| Dávalos, *Canción del jangadero* | 575 | 256 | 254 (99,2 %) | **575 / 575** |
| Atahualpa, *Caminito del indio* | 1200 | 330 | 321 (97,3 %) | chœur **598 / 598** |

Les deux mesures du jangadero qui résistent sont à **trois** voix, que le
partage ne sait pas encore faire ; leurs hauteurs sont justes, seules leurs
durées restent à trancher, et les contrôles de mesure de LilyPond les
désignent.

La géométrie dit lesquelles : à la cadence finale, deux pupitres montent leur
accord une note à la fois, chacune entrant sur un temps et tenue jusqu'au bout.
La basse à la mesure 59 — G2, B2, D3 aux abscisses 246, 269 et 288 — puis le
ténor à la 60, une mesure plus tard — E4, G4, B4 aux abscisses 313, 332 et 350.
Un arc relie le D3 de la basse au D3 de la mesure suivante : la voix du dessus
poursuit, la liaison est réelle.

Récrire ces mesures-là en trois voix demande trois précautions que l'essai a
mises au jour : `\relative` **enchaîne** les branches d'un `<<>>`, si bien qu'une
octave corrigée dans l'une décale toutes les suivantes ; une liaison ne franchit
la barre que si sa voix reste dans le contexte principal, c'est-à-dire la
première branche ; et les paroles, qui suivaient la ligne aplatie, doivent
désigner la branche qu'elles accompagnent, faute de quoi le graveur escamote
leurs traits d'union.

Caminito se lit à deux vitesses. Ses quatre voix chorales sont exactes de bout
en bout — 220 mesures sur 220, 598 notes rendues à l'identique par le MIDI. Son
piano est le seul chantier qui reste : **9 mesures** à trois voix ou plus, que
le partage ne sait pas séparer.

Ces mesures-là portent leur numéro dans le `.ly` — `%{ À RELIRE mesure 27 :
somme fausse %}` — parce que c'est par lui qu'on les retrouve sur le papier,
quand l'avertissement de LilyPond ne donne qu'une ligne et une colonne. Piano
de Caminito : main droite 18 et 32, main gauche 10, 12, 13, 18, 27, 32 et 33.
Jangadero : 59 et 60. Une mesure dont les durées ne tombent pas juste décale
tout ce qui la suit, donc l'aller-retour désigne la première et se tait sur le
reste — c'est la même erreur, comptée une fois.

Concordance des voix : les quatre partitions donnent le même découpage en
mesures dans toutes leurs voix, système par système — et pour le candombe comme
pour le jangadero, exactement celui relevé à l'œil sur le papier.

Hauteurs vérifiées : overlay (un cercle par tête, rien d'autre) et recoupement
avec des repères donnés par l'oreille humaine sur le candombe — sept sur sept.

## Ce qui a coûté cher à trouver

Les commentaires du code portent le détail ; voici la liste de rappel.

**Table de glyphes**

- **`0xF062` de l'Opus symbolique est un bémol**, et il a été retourné deux
  fois avant de se fixer. La position ne pouvait pas trancher : une
  acciaccatura comme un bémol se collent à gauche d'une tête, dans la même
  bande d'ordonnées. Ce qui tranche est que les deux hauteurs **coïncident**
  — sur le jangadero, 26 fois sur 29 — ce qui ne veut rien dire d'un ornement
  et tout d'une altération. Le rendu de la zone l'a confirmé à l'œil. Tant
  qu'il passait pour un ornement, la partition perdait **tous** ses bémols, et
  pire : sur la ligne du fa, la tête héritait du dièse de l'armure, si bien
  qu'un fa bémol se lisait fa dièse.

- **Ne jamais créditer une entrée sans contrôle visuel.** Deux devinettes
  plausibles, deux erreurs : `0x2030` pris pour une blanche (c'est un
  demi-soupir), la clé de sol
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
- **Deux portées voisines alignent leurs hampes**, et les fusionner par la
  seule abscisse en donne une qui traverse l'entre-portées. Sur le piano de
  Caminito elle faisait onze interlignes, et la tête se retrouvait à son
  extrémité basse : hampe montante, donc voix du dessus, donc partage
  impossible. Une hampe est **continue** ; ce qui s'interrompt est une autre
  hampe. C'est l'exact miroir des ligatures superposées, que l'écart vertical
  ne sépare pas — ici il est le seul à le faire. Neuf mesures de Caminito y
  ont gagné leur partage, sur dix-sept.
- **Une police d'ornements se reconnaît à son corps.** Elle n'a ni tête, ni
  clé, ni silence à exhiber, et trop peu de glyphes connus pour un critère de
  couverture ; mais elle est gravée à la taille de la musique, quand les
  paroles le sont à la moitié. L'écart est une constante de gravure : aucune
  police de texte des quatre partitions n'approche la taille de la musique à
  10 % près.

**Paroles**

- **Une altération accidentelle vaut jusqu'à la fin de la mesure**, pour la
  seule position où elle est écrite. Lire note à note redonne un bécarre là où
  le dièse tient encore : sur Balderrama, six notes, dont un `sol` qui faisait
  sonner un accord de mi mineur au lieu de mi majeur. La mémoire s'arrête à la
  barre, donc l'altération ne se fige qu'une fois le système entier lu.
- **Le premier couplet est la ligne la plus haute, jamais la mieux garnie.**
  Quand la reprise change de texte, deux lignes de paroles se superposent, et
  la seconde a souvent plus de syllabes que la première. Garder la mieux notée
  faisait passer le soprano d'un couplet à l'autre au milieu d'une phrase, page
  2 de Balderrama — « ...del canal cuan- » puis « -chero lo acompaña ».
- **Le second couplet se reconnaît à son ordonnée** : il est gravé un
  interligne de texte sous le premier, à la ligne près, quand le numéro de
  mesure, la mention d'éditeur et les signes d'une police d'ornements tombent
  ailleurs ou dans un corps plus petit. Le score d'alignement sur les notes ne
  les sépare pas — un signe isolé tombe sous une note aussi bien qu'une
  syllabe. L'écart se mesure sur l'interligne de la **portée**, qui commande
  l'espacement vertical de la gravure entière : 2,17 au candombe, 2,50 au
  jangadero, 2,79 à Balderrama, 3,13 à Caminito. La fenêtre `(2,0 ; 3,4)` les
  tient tous les quatre ; calée sur `(2,2 ; …)` elle rejetait le candombe de
  trois centièmes, et son second couplet n'était pas gravé du tout.
- **Un terme de gravure se présente comme un couplet.** Le « Fine » du candombe
  est écrit *au-dessus* de la portée suivante ; la portée la plus proche étant
  celle du dessus, il arrive dans ses paroles — même corps, sous une note, à
  1,4 interligne du premier couplet. Deux dixièmes d'interligne le séparent de
  la fenêtre : une liste d'arrêt (`DIRECTIVES`) est plus sûre que la marge.
- **Les deux couplets se coulent dans la même grille de fentes.** Une fente
  n'est pas une note : un mélisme en absorbe plusieurs pour une seule syllabe,
  et LilyPond saute alors les notes couvertes. Le nombre de fentes est donc une
  propriété de la **musique** — des liaisons qui y sont écrites — et non du
  texte. Le second couplet doit être apparié sur la grille du premier, et son
  remplissage compter un `_` par fente, pas un par note. Compter les notes
  donnait au soprano du candombe 19 `_` là où le premier couplet consommait 17
  fentes, et le second chantait « San Baltasar se hamaca » deux mesures trop
  tard ; le même défaut décalait les seconds couplets du jangadero (13 lignes)
  et de Caminito (11). Le contrôle tient en une ligne : les deux couplets d'une
  voix doivent consommer le même nombre de syllabes, portée par portée.
- **Une portée sans paroles doit être sautée par les deux couplets.** Elle ne
  donnait rien au premier et une ligne de `_` au second, qui prenait dès lors
  une portée d'avance : au soprano de Caminito le second couplet entrait un
  système trop tôt.
- **`__` ne fait que dessiner le trait.** C'est la fente qui tient la syllabe
  sur plusieurs notes, et elle la tiendrait sans lui. On ne le grave donc que
  si *ce* couplet-là porte un trait de prolongation. Sinon le second couplet du
  candombe traînait un filet depuis « bai-la » jusqu'à sa reprise quatre
  mesures plus loin, là où le graveur s'arrête net.
- **Une liaison de tenue retire une syllabe.** LilyPond ne place qu'une syllabe
  sur un groupe lié, donc chaque liaison ajoutée à la main demande de retirer
  le `_` correspondant. Le symptôme est un `--` en fin de ligne signalé sans
  suite, et l'aller-retour MIDI le confirme.
- **Un arc se rattache à la tête la plus proche, jamais par une fenêtre.** Il
  est dessiné de tête à tête **sans les toucher** : son bout gauche tombe
  jusqu'à deux interlignes à droite de l'abscisse de la première tête, son
  bout droit jusqu'à deux et demi à droite de la seconde. Une fenêtre assez
  large pour les couvrir atteint la note d'après, qui peut n'être qu'à 1,9
  interligne ; la fenêtre serrée de 0,6 qui a tenu jusqu'ici ne prenait
  qu'**une tête sur deux** — 205 arcs sur 205 au candombe, 79 sur 139 à
  Balderrama, 78 sur 104 au jangadero — et l'arc partait à la poubelle, faute
  de couvrir les deux notes qu'une tenue demande. Aucune liaison de la page 1
  du candombe n'était vue. Le rattachement au plus proche les retrouve et
  **retaille** au passage ceux que la fenêtre débordait.
- **Une ligature de croches relie deux têtes, elle aussi.** Chez Finale elle
  sort en courbe fermée à quatre points comme un arc, avec les deux bouts sur
  une tête : rien ne l'en distingue par là. Sur la page 1 de Balderrama,
  **vingt des vingt-deux courbes sont des ligatures** et deux seulement des
  liaisons. Ce qui les sépare est l'épaisseur **aux extrémités** — une demi-
  interligne pour la ligature, qui est un parallélogramme, moins d'un
  trentième pour l'arc, qui s'amincit jusqu'à rien là où il touche la tête.
  Treize des quatorze liaisons de phrasé de Balderrama étaient des ligatures.
- **Un arc qui redit un mélisme n'est pas un phrasé de plus.** Quand la portée
  d'un arc tombe dans celle d'un mélisme déjà posé par le trait de
  prolongation, c'est *ce* mélisme, lu deux fois — une fois dans le dessin,
  une fois dans le texte. Le ténor de Balderrama écrivait `cis4(\( b4 ais4)\)`,
  deux marques pour une seule chose. Le vrai phrasé est un arc sur des notes
  qui gardent chacune leur syllabe : les dix notes de « Ca-mi-ni-to, del
  in-dio » chez Caminito, qu'aucun mélisme ne couvre. La règle ramène
  Balderrama à **zéro** phrasé, ce que dit sa partition, le jangadero de 3 à 0
  et Caminito de 30 à 16.
- **Le `__` ne se grave que s'il a quelque chose à parcourir.** Trois
  conditions : que *ce* couplet porte le trait, et que la syllabe couvre bien
  plus d'une note — soit que la fente en absorbe plusieurs, soit qu'une tenue
  avale la suivante. Sans quoi LilyPond tire le filet jusqu'au mot d'après.
- **Le `_` qui suit un `__` doit s'écrire `""`.** LilyPond y voit sinon une
  syllabe muette sur laquelle le trait continue. La coupure de ligne d'un bloc
  `\lyricmode` ne protège pas : elle est cosmétique, le flux est continu, et
  le cas se présente surtout d'une portée à l'autre.
- **Les fentes vides de la fin ne s'écrivent pas.** Rien ne les suit, elles ne
  tenaient que le compte, et elles laissaient un `_` orphelin derrière le
  dernier `__` d'un couplet.
- **Un trait de prolongation ne dit pas qu'une note est tenue**, seulement
  qu'une syllabe la couvre. Ce qui tranche est l'arc, et quand la portée en
  donne de lisibles on s'y tient : le candombe écrit « domdom » d'un seul
  tenant sous deux ré — si serré que la couche texte n'en fait qu'un jeton —
  et son trait appartient au second. Le déduire tenu faisait sonner une
  blanche là où le graveur n'arque rien et où il y a deux noires. Sans arc
  lisible sur la portée, la déduction reste le seul recours.
- **Sur une portée divisée, les paroles ne suivent que la voix du haut.**
  Compter les notes des deux donnait au ténor du jangadero une syllabe de plus
  que de notes, et LilyPond escamotait son dernier mot.
- **Une nuance se glisse à la place du second couplet.** Le `p` de Caminito est
  gravé un interligne de texte sous les paroles, exactement où l'on attend le
  second couplet. Ce qui l'écarte est son corps : deux couplets sont gravés à
  la même taille **à la virgule près**, une nuance à quelques pour cent près.
- **Un piano peut porter des paroles.** Caminito grave celles de la basse une
  seconde fois sous la portée de main gauche. Ce n'est pas une erreur de
  lecture — elles y sont — mais une portée instrumentale ne chante pas.

**Ce que LilyPond fait, et qu'il faut modéliser exactement**

- **`\relative` ignore le `<<>>`.** Dans une musique simultanée il parcourt les
  notes dans l'ordre écrit : la seconde voix repart de la fin de la première,
  et ce qui suit repart de la fin de la seconde. Croire que les deux branches
  partent du même point faisait descendre la basse du jangadero d'une octave
  par mesure, quatre octaves en quatre mesures. Vérifié sur LilyPond lui-même
  plutôt que déduit : `\relative c' { c4 \duo { c4 } { c,4 } c4 }` sonne
  do3 do3 do2 do2.
- **`%` commente jusqu'à la fin de la ligne.** Le générateur écrit un système
  par ligne, donc un `% À RELIRE` posé au milieu escamotait tout le reste du
  système — barres de contrôle comprises, donc sans que LilyPond s'en plaigne.
  Une mesure douteuse en faisait disparaître six. Les annotations en ligne se
  posent en `%{ … %}`.
- **Une liaison de tenue retire une syllabe** et **une mesure de clôture ne
  prend pas de contrôle de mesure** : elle est écourtée de la levée, exprès.

**Ce que change LilyPond 2.26 (le dépôt y est passé)**

- **Un échec de contrôle de mesure en masque les suivants.** Sur trois mesures
  délibérément faussées dans une même voix, 2.24 les signale toutes les trois,
  2.26 seulement la première. Le contrôle reste un détecteur, mais itératif :
  corriger, recompiler, recommencer. Le contrôle de **somme** de `verslily.py`,
  lui, les relève toutes d'un coup et garde donc sa valeur. Pour la même
  raison, le nombre d'avertissements chute sans que rien soit réparé —
  Caminito passe de 19 à 3.
- **Les paroles y prennent plus de large.** Le candombe, gravé sur trois
  mesures par système en 2.24, n'en tient plus que deux de la mesure 17 à la 24
  et déborde sur une cinquième page. La cause est le texte et non la musique :
  le second couplet empile des jetons que la couche texte rend d'un seul tenant
  (« cuandocambian », « quecambiande »). Un demi-cran de corps sur le seul
  `LyricText` ramène à quatre pages, sur 2.24 comme sur 2.26, sans toucher à la
  portée. Le correctif de fond est le découpage des jetons fusionnés.
- **`\version "2.26.0"` est refusé par 2.24**, fatalement et non par un simple
  avertissement. La bascule est donc sans retour tant que le `.ly` porte cette
  ligne.

**Conventions d'écriture**

- **`\volta` n'est pas `\alternative`.** `\volta 1 { ... }` filtre ce qui est
  joué au dépliage et ne grave rien ; les crochets de première et deuxième fois
  viennent d'`\alternative`, à l'intérieur du `\repeat volta`. Écrire l'un pour
  l'autre compile sans un mot et rend une partition sans reprise visible.
- **Une reprise doit être dans les quatre voix.** Portée par le seul soprano,
  elle grave pourtant ses barres — elles sont décidées au niveau du système —
  mais le `\unfoldRepeats` du MIDI ne déplie que lui, et les voix se
  désynchronisent d'une trentaine de mesures.
- **Un morceau qui commence par une levée et se termine sur une reprise finit
  sur une mesure écourtée d'autant** : le candombe, 0,75 noire au début et 3,25
  à la fin. Lecture juste, somme apparemment fausse.
- **Une reprise vers le début du morceau se dit `\repeat segno`.** Le candombe
  ne grave qu'une barre `:|` finale et un « Fine » à la mesure 8, sans `|:`
  ni « D.C. » : la reprise ramène au tout début, et les deux couplets du
  soprano disent qu'on y passe deux fois avant la sortie. Cela s'écrit
  `\repeat segno 3 { … \volta 3 \fine \volta 1,2 { … } }`, et LilyPond, voyant
  que le segno tombe à la première mesure, ne le grave pas et écrit
  « D.C. 2 V. al Fine ». Le nombre de passages est celui des couplets **plus
  un** — le dernier ne sert qu'à rejoindre le Fine.
- **Il n'y a qu'une levée, au tout début.** La tolérer à la première mesure de
  chaque système faisait passer pour des levées sept vraies erreurs.
- **L'espacement horizontal ne départage pas une croche d'une double.** Une
  version antérieure du solveur s'en contentait : sur deux mesures identiques
  elle rendait deux réponses différentes, fausses toutes les deux.
- Audiveris n'est pas constant sur l'octave des pupitres en clé de sol
  octaviée ; `pitchdiff` aligne donc sur les noms de notes et classe l'octave à
  part.

**Altérations**

- **Une altération de la première note tombe entre la clé et cette note**,
  exactement là où se lisent celles de l'armure — et elle y était comptée,
  donc appliquée à toute la portée. Le jangadero lisait ainsi six portées sur
  quarante en « un dièse et un bémol », ce qu'aucune armure n'est ; Balderrama
  en lisait quatre à trois dièses au lieu de deux, et son la dièse de la
  mesure 28 sonnait naturel. Le départage est l'**écart** : une altération
  d'armure laisse passer la note, celle d'une note lui est collée. Sur les
  quatre partitions, la plus serrée des armures garde 1,26 interligne quand
  les mauvaises lectures sont à 0,02. Garde-fou supplémentaire : une armure ne
  mêle jamais dièses et bémols.

  Le contrôle qui l'attrape est gratuit et vaut pour toute partition : **toutes
  les portées d'un morceau doivent lire la même armure.** Trois lectures
  différentes sur quarante portées désignent le défaut sans qu'on ait à
  regarder une seule note.

- **La liaison de tenue franchit la barre, l'altération la suit.** La mémoire
  des altérations s'arrête à la barre de mesure ; une note liée, elle, garde
  celle de la note d'origine sans que le graveur la réécrive. Sans ce report,
  le si bémol que le jangadero tient d'une mesure sur la suivante redevenait
  naturel — et l'arc, joignant désormais deux hauteurs différentes, n'était
  même plus lu comme une tenue mais comme un mélisme.

- **Les enharmonies mécaniques se ramènent au nom usuel.** Un fa bémol sous
  une armure de dièses n'est pas une orthographe, c'est le reste d'une
  transposition faite sur les degrés sans regarder la tonalité : il se lit mi,
  et un do bémol si. Le miroir vaut pour un mi ou un si dièse sous une armure
  de bémols. Hors de ces deux cas on ne touche à rien : les mi dièses de
  Balderrama et le si dièse de Caminito sont la bonne orthographe de leur
  sensible sous trois et quatre dièses.

## Ce que la génération ne lit pas

`verslily.py` écrit les hauteurs, les durées, l'armure, le chiffrage, les clés,
les `\duo` des portées divisées, le `PianoStaff` d'un accompagnement, et les
paroles syllabe à syllabe — **couplets superposés compris**, un `\addlyrics`
par ligne gravée, la seconde remplie de `_` jusqu'à son entrée à la barre de
reprise.

Il écrit aussi les **liaisons** et les **nuances**. Il ne lit ni les barres de
reprise (`--reprise` et `--volta` les posent à la main), ni les repères. Ce
sont des ajouts, pas des corrections : ils ne remettent pas en cause ce qui est
écrit.

Il écrit aussi les **points de staccato**. Ils se séparent du point
d'augmentation par la seule géométrie : celui-ci se pose **à droite** de la
tête et à sa hauteur (dx ≈ +1,5 interligne, dy ≈ 0, le demi-interligne de
décalage près quand la note est sur une ligne), celui-là **au-dessus ou
au-dessous**, centré sur elle (dx ≈ +0,5, dy de 4 à 6 selon le côté que le
graveur choisit). C'est la fenêtre **horizontale** qui décide : les points
d'une barre de reprise, d'un point d'orgue ou d'un chiffrage sont tous à plus
de deux interlignes du centre d'une tête, sur les quatre partitions.

Le compte : 32 au jangadero — les quatre mesures piquées de ses deux pupitres
d'hommes, exactement celles que la relecture avait saisies à la main — 12 à
Caminito, aucun à Balderrama ni au candombe. Deux des têtes de Caminito portent
leur point des deux côtés : portée divisée à l'unisson, une tête, une
articulation, et chaque voix la reçoit à l'écriture.

Les **accents** (`>`) ne sont pas lus : ce n'est pas un point, c'est un autre
glyphe, et Caminito en pose autant que de staccatos.

**Les termes d'expression sont gravés dans la police des paroles, sous la
portée, à la hauteur des paroles** : rien ne les en distingue qu'eux-mêmes.
« dim » et « tenuto » du jangadero se retrouvaient chantés, comme « Fine » du
candombe avant eux. D'où la liste `DIRECTIVES` de `verslily.py`, qu'il faut
étendre à chaque terme rencontré — elle n'est pas devinable, seulement
observable.

## Trois liaisons, trois choses différentes

Les confondre est l'erreur qui coûte le plus cher, parce qu'elle est
silencieuse : la partition compile, et c'est le MIDI ou les paroles qui sonnent
faux.

- **La liaison de tenue** (`~`) : la note ne se réattaque pas, et le groupe ne
  prend qu'une syllabe. Elle se lit sur un arc qui joint **exactement deux**
  têtes de même hauteur.
- **Le mélisme** (`( )`) : une syllabe tenue sur plusieurs notes, articulées.
  Il se lit non pas sur l'arc mais sur le **trait de prolongation des
  paroles**. `( )` crée le mélisme dont LilyPond a besoin pour ne pas
  redemander de syllabe.
- **Le phrasé** (`\( \)`) : tout arc plus long, qui ne change **ni** le MIDI
  **ni** les paroles — chaque note garde la sienne. C'est exactement pour cela
  que LilyPond distingue `\(` de `(`.

D'où la règle, et l'erreur qu'elle évite : sur Caminito, un arc court sur dix
notes au-dessus de « Ca-mi-ni-to, del in-dio », dont chacune a sa syllabe.
Traité comme un mélisme, il liait tout un couplet en une seule note tenue —
trente notes absorbées au seul soprano.

Un arc n'est retenu que si ses **deux bouts sont posés sur une tête** : c'est
le seul critère qui vaille pour les quatre graveurs. La hauteur de la boîte ne
sert à rien — Finale et Sibelius rendent un arc par liaison, plat pour une
tenue et bombé pour un phrasé, mais Ghostscript en rend **deux**, les deux
bords d'une forme pleine, tous deux plats. Et un arc qui touche une mesure
divisée, ou une mesure dont les durées ne tombent pas juste, est écarté : rien
n'y dit à quelle voix il appartient, et la liaison s'ouvrirait sans se fermer.

| | tenues | mélismes | phrasés | nuances |
|---|---|---|---|---|
| Balderrama | 32 | 7 | 14 | — |
| Candombe | 104 | 6 | — | — |
| Jangadero | 16 | 7 | 1 | 11 |
| Caminito (chœur) | 3 | 18 | 28 | 17 |

## La police de texte musical

Chaque graveur double sa police de notation d'une **police de texte musical** —
`EngraverFontSet` chez Finale, `OpusText` / `OpusTextStd` chez Sibelius, une
sous-police anonyme chez Ghostscript. Elle est gravée au corps du texte et non
à celui de la musique, donc l'admission par le corps l'écarte, à raison : ses
lettres ne sont pas des notes. Mais elle porte, en clair et avec leurs
coordonnées, plusieurs des choses réputées « non lues ».

- **La marque d'élision**, sous trois codes selon le graveur : `I` chez Finale
  (44 dans Balderrama), `0xF03C` chez Ghostscript (35 dans le candombe), `_`
  chez Sibelius (56 dans Caminito, 27 dans le jangadero). Rien d'autre ne les
  rapproche que leur emploi — c'est la petite liaison sous deux voyelles
  chantées sur une note, le `de‿i` de « dónde iremos », le `que‿an` de
  Caminito. Elle confirme ce que la génération déduisait déjà de ce que deux
  syllabes tombent sur une même note : sur Balderrama, **les 44 marques
  gravées et les 44 élisions inférées sont aux mêmes endroits**. Deux signaux
  indépendants, d'accord.
- **Le tempo**, sous la forme `q = 108` — le `q` est la noire. Le candombe
  porte ♩=108, Caminito « Moderato ♩=70 ». Le jangadero dit « adagio », sans
  métronome, dans sa police de titres. Seul Balderrama n'en porte aucun.
- **Les nuances** `p`, `m`, `f`, qui sont lues et écrites : 38 dans Caminito,
  13 dans le jangadero. Balderrama et le candombe n'en portent aucune.
- Chez Ghostscript, les étiquettes `1.` / `2.` des crochets de reprise et le
  `Fine`.

Cette police se reconnaît à son **répertoire**, pas à son nom : il tient dans
une poignée de signes — `fmpszr`, `q`, `_`, `I`, les chiffres — là où la
moindre police de paroles en aligne cinquante. Le `Fine` du candombe ajoute un
`e`, un `i` et un `n` : il en sort, et c'est bien une police de titres.

Le **trait de prolongation** des paroles, lui, n'est pas de cette police : il
est vectoriel, posé sur la ligne de base du texte à un point près. Ce qui
traîne ailleurs dans la même bande sont les lignes supplémentaires des notes
sous la portée, une quinzaine de points plus haut et de la largeur d'une tête.
C'est l'ordonnée qui les sépare, pas la largeur — une prolongation courte fait
la même dizaine de points qu'une ligne supplémentaire.

Chez Finale ces étiquettes de reprise sont dans la police de paroles, sous la
portée du bas, avec leur abscisse : c'est ce qui a servi à placer la reprise de
Balderrama, mesures 44 et 46.

Un `_` de paroles qui subsiste marque une note sans syllabe qu'aucun trait de
prolongation n'explique : à relire, c'est là que se cachent les liaisons qui
manquent encore. Il en reste sept sur Balderrama, sur 178 notes de soprano.

Rien ne se décide à l'oreille. Deux choses en étaient, toutes les deux à tort.

Le **tempo** : trois partitions sur quatre le portent, dans leur police de
texte musical. Seul Balderrama n'en a pas, et c'est la seule valeur inventée
du dépôt.

La **césure des paroles** là où le graveur n'a pas mis de trait d'union : ce
n'est pas un trou, c'est une lecture. L'intro de Balderrama est faite
d'onomatopées, et « Tra la la » n'est pas lié parce que ce sont trois mots,
comme les « Bom » de la basse et les « Pa ba da badam » du ténor ; les lier
distinguerait l'un des autres sans raison. Le trait d'union présent et le
trait d'union absent portent donc la même information, et la reprendre telle
quelle est la bonne réponse.

Tout se déduit, la tonalité comprise, que la finale de la basse tranche entre
la majeure et sa relative mineure.

## Reste à faire

1. **Le piano de Caminito**, seul morceau du corpus qui ne soit pas vérifié.
   Deux chantiers qui vont ensemble : le partage à **trois voix ou plus** (17
   mesures), et un aller-retour qui sache confronter deux polyphonies —
   l'actuel compare des suites, et l'ordre de deux voix simultanées n'est pas
   le même au dessin qu'au MIDI. Le second d'abord : sans lui on ne saura pas
   quand le premier est juste.
2. **Trois voix sur une portée** au jangadero : deux mesures, à la toute fin.
   Les hauteurs sont justes, les durées non, et LilyPond les désigne.
3. **Barres de reprise** : `--reprise` et `--volta` les posent, mais à la main.
   Les crochets `1.` / `2.` sont dans la couche texte avec leur abscisse, et
   les barres de mesure sont relevées — de quoi les trouver sans rien deviner.
4. **Saisie du manuscrit `Cuando tenga la tierra`**, hors pipeline. Le
   squelette est écrit — structure, repères, accords, paroles, récitatif —
   il ne reste que les hauteurs et les rythmes.

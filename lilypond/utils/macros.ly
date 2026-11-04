
% Deux voix indépendantes sur une même portée : pupitre divisé, polyrythmie.
%
%   \duo { <bes' d>4 4 <g c>2 } { f2. e4 }
%
% développe exactement l'écriture manuelle
%
%   <<{\voiceOne <bes' d>4 4 <g c>2 } \new Voice {\voiceTwo f2. e4 }>> \oneVoice
%
% — gravure identique au pixel près et MIDI identique à l'octet, y compris à
% l'intérieur d'un \relative, qui lit le tout dans l'ordre écrit : la voix du
% bas part de la dernière note de la voix du haut, et la suite de la dernière
% note de la voix du bas. La voix du bas accepte les silences invisibles
% (s1*2) pour sauter les mesures qu'elle ne chante pas.
duo =
#(define-music-function (haut bas) (ly:music? ly:music?)
   #{
     << { \voiceOne #haut } \new Voice { \voiceTwo #bas } >> \oneVoice
   #})

% Quelques notes qui changent d'une fois à l'autre, au milieu d'une reprise —
% là où une \alternative obligerait à couper la reprise en deux.
%
%   \selonReprise #UP { e2 } { c2 }
%   \selonReprise #DOWN { c4 b } { e4 f }
%
% La gravure superpose les deux variantes, comme \duo, étiquetées « 1. » et
% « 2. » ; le premier argument place la variante 1 en haut (UP) ou en bas
% (DOWN). Le MIDI déplié (\unfoldRepeats) chante la variante 1 aux passages
% impairs, la variante 2 aux pairs : la première fois puis la seconde dans une
% reprise simple, le couplet 1 puis le couplet 2 dans un \repeat volta 4 à deux
% couplets empilés. La reprise en jeu est la plus proche qui englobe :
% \repeat volta, ou le \repeat segno d'un D.C.
%
% Les paroles suivent la variante 1 : si la variante 2 a un autre rythme, le
% couplet qui la chante sera mal calé.
%
% En \relative, même lecture que \duo : la variante 2 part de la dernière note
% de la variante 1, la suite de la dernière note de la variante 2. Chaque
% variante sert deux fois (gravure et MIDI) ; make-relative calcule l'octave
% une seule fois pour les deux, sans quoi les copies du MIDI pourraient sortir
% à une autre octave que la gravure. Revers : dans un \fixed, les variantes se
% lisent en absolu.
selonReprise =
#(define-music-function (sens premiere seconde) (ly:dir? ly:music? ly:music?)
   (make-relative (premiere seconde)
     #{ #premiere #seconde #}
     #{
       \volta #'() {
         <<
           { $(if (> sens 0) voiceOne voiceTwo)
             <>-\markup \tiny "1." $premiere }
           \new Voice { $(if (> sens 0) voiceTwo voiceOne)
             <>-\markup \tiny "2." $seconde }
         >>
         \oneVoice
       }
       \unfolded { \volta #(iota 10 1 2) $premiere \volta #(iota 10 2 2) $seconde }
     #}))

emph = {
  \override Lyrics.LyricText.font-shape = #'italic
  % \override Lyrics.LyricText.font-series = #'bold
}

normal = {
  \revert Lyrics.LyricText.font-shape
  % \revert Lyrics.LyricText.font-series
}

% Une nuance suivie de son intention : l'intensité dans la fonte des nuances,
% l'intention en italique à sa droite.
%
%   c4^\markup \nuance p legato
%   c4_\markup \nuance ff pesante
%   c4-\markup \nuance f "molto sostenuto"
%
% Les deux arguments sont des markups, donc les mots nus passent sans
% guillemets — y compris `f`, qui est aussi un nom de note. C'est la raison
% pour laquelle c'est une **commande de markup** et non une fonction
% d'événement : `c4^\nuance f legato` ferait lire `f` comme une hauteur et
% échouerait, quand `^\markup \nuance f legato` lit ses arguments en mode
% markup, où `f` n'est qu'un mot. Le `\markup` coûte huit caractères et
% supprime un piège qui ne se déclenche que sur certaines nuances.
%
% Et comme ça rend un markup, ça se compose — ce qui couvre le cas où un
% terme précède la nuance :
%
%   c4^\markup { \italic subito \nuance p legato }
%
% Remplace douze variables (`pe`, `pl`, `ppl`, `spl`, `pll`, `mpe`, `mfa`,
% `mfll`, `fa`, `fam`, `fs`, `ffp`) dont chaque combinaison nouvelle
% demandait sa propre déclaration, et dont certaines portaient un nom qui
% ment : `ffp` se lit « fortissimo puis subito piano » pour un musicien.
#(define-markup-command (nuance layout props intensite intention)
   (markup? markup?)
   (interpret-markup layout props
     #{ \markup { \dynamic #intensite \italic #intention } #}))

% Un terme d'agogique — rit., accel., a tempo — dans le gras droit.
%
%   c4^\markup \agogique rit.
%   c4^\markup \agogique "a tempo"
%
% Le point ne casse pas le mot, donc `rit.` s'écrit sans guillemets ; il n'en
% faut que pour les termes en plusieurs mots.
%
% Ce qu'enregistre cette commande est un **choix de style**, et c'est sa seule
% raison d'être : le réflexe serait l'italique, comme pour l'intention d'une
% nuance, et ce serait faux. Les graveurs rangent ces termes-là avec les
% indications de parcours — Caminito grave `rit.`, `D.C.` et `Moderato` dans
% la même fonte, au même corps, et c'est le gras droit que LilyPond donne
% déjà à `\tempo`.
%
% Pourquoi une commande et non une variable par terme : `rit` serait une
% constante, et une constante se déclare. Mais il en faudrait une par mot, et
% c'est le travers dont `\nuance` sort. La règle du dépôt : une **fonction**
% quand quelque chose varie, une **variable** quand rien ne varie et que le
% même jeton revient partout.
#(define-markup-command (agogique layout props texte) (markup?)
   (interpret-markup layout props #{ \markup \bold #texte #}))

% Une altération de *musica ficta* : ajoutée par l'éditeur, absente de la
% source. Elle se grave au-dessus de la note et non devant, pour qu'on la
% distingue d'un coup d'œil d'une altération écrite.
%
%   \ficta cis4
%
% Elle sonne comme les autres : seul l'emplacement du signe change. Et comme
% tout signe d'altération, elle ne se grave que si la note en demande un — un
% `\ficta` posé sur une note déjà altérée par l'armure ne montre rien.
ficta = { \once \set suggestAccidentals = ##t }

% Une syllabe sur une note liée. Quand un couplet tient la note et qu'un autre
% la réarticule, la liaison de tenue reste gravée mais le second couplet doit
% pouvoir y poser sa syllabe :
%
%   b2~ \syllabeSurLiee b2
%
% LilyPond tient une note liée pour la suite d'un mélisme et ne lui donne
% jamais de syllabe — pas même avec `ignoreMelismata`, qui ne lève que les
% liaisons d'expression. On retire donc la tenue de la liste des mélismes, pour
% cette note seulement. Elle devient une place de syllabe pour **tous** les
% couplets : celui qui tient y écrit `_`.
syllabeSurLiee = \once \set melismaBusyProperties =
  #'(melismaBusy slurMelismaBusy beamMelismaBusy completionBusy)


soprano_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef treble
  \accidentalStyle modern-cautionary

}


alto_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef treble
  \accidentalStyle modern-cautionary

}

tenor_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef treble
  \accidentalStyle modern-cautionary

}


hommes_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef bass
  \accidentalStyle modern-cautionary

}

lpiano_syle = {
\set Staff.midiInstrument = "acoustic grand"
\set Staff.midiMinimumVolume = #0.5
\set Staff.midiMaximumVolume = #0.7
\clef bass
\accidentalStyle modern-cautionary
}

rpiano_syle = {
\set Staff.midiInstrument = "acoustic grand"
\set Staff.midiMinimumVolume = #0.5
\set Staff.midiMaximumVolume = #0.7
\clef treble
\accidentalStyle modern-cautionary
}
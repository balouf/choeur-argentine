\version "2.26.0"

%% Source : édition Ars Musica (1997), PDF et MusicXML de la même édition.
%% Notes reprises du MusicXML ; paroles relues sur le PDF, le MusicXML ayant
%% perdu ou ajouté quelques traits d'union.
%%
%% Les barres pointillées de la section à 3/2 sont celles du PDF.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Teresica hermana" }
  composer = "Mateo Flecha el Viejo (1481-1553)"
  subsubtitle = "Cancionero de Upsala"
  arranger = "Ed. : Ars Musica"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 4/4
  \tempo 2 = 72
  \key f \major
}

soprano_music = {
  % 1
  R1 | g'2. g4 | a2 a | bes g |
  % 5
  c2. bes4 | a bes a g | fis2 bes | a g |
  % 9
  g2 fis | g1 | R1*2 |
  % 13
  R1*3 | r2 g4 g |
  % 17
  a2 a | bes g | c2. c4 | f, f bes bes |
  % 21
  g2 c~ | c4 bes a bes | a2 g | fis bes |
  % 25
  a2 g | g fis | g1 | r2 g4 g |
  % 29
  a2 bes | a1 | g | R1 |
  % 33
  c2. c4 | bes2 a4( g) | a1 | g |
  % 37
  c2. c4 | bes2 a4( g) | a1 | g |
  % 41
  r2 g4 g | a2 a | bes g | c2. c4 |
  % 45
  f,4 f bes bes | g2 c~ | c4 bes a bes | a2 g |
  % 49
  fis2 bes | a g | g fis | g1 |
  % 53
  r2 g4 g | a2 a | bes g | c2. bes4 |
  % 57
  a4 bes a g | fis2 bes | a g | g fis |
  % 61
  g1 | R1*3 |
  % 65
  bes2 bes | c2. bes4 | a2 g | R1 |
  % 69
  R1 | bes4 a bes g | a2 g | R1 |
  % 73
  R1*2 | bes2 bes | c2. bes4 |
  % 77
  a2 g | r g4 g | a2 a | bes g |
  % 81
  c2. c4 | f, f bes bes | g2 c~ | c4 bes a bes |
  % 85
  a2 g | fis bes | a g | g fis |
  % 89
  g1 | r2 g4 g | a2 a | bes g |
  % 93
  c2. bes4 | a bes a g | fis2 bes | a g |
  % 97
  g2 fis | \time 3/2 g1 g2 | a1 g2 \bar "!" g fis1 |
  % 101
  g1. \bar "||" bes1 bes2 | bes bes bes | bes1 bes2 |
  % 105
  a2 bes1 | c1.( | bes) | a |
  % 109
  r2 r g | bes1 bes2 | c1 bes2 | g1.( |
  % 113
  a1.) | g | r2 r g | g1 g2 |
  % 117
  a1 g2 | g1.( | fis) | g~ |
  % 121
  g1. | bes1 bes2 | bes1 bes2 | bes1 bes2 |
  % 125
  a2 bes1 | c1.( \bar "!" a) | g~ |
  % 129
  g1. | g1 g2 | g1 g2 | g1 g2 |
  % 133
  a1 g2 | a g ees \bar "!" f g( fis) | g1. |
  % 137
  r2 g a | bes1 bes2 | bes1 bes2 | bes1 bes2 |
  % 141
  a2 bes1 | c1.( | bes) | a |
  % 145
  r2 r g | bes1 bes2 | c1 bes2 | g1.( |
  % 149
  a1.) | g | r2 r g | g1 g2 |
  % 153
  a1 g2 | g1.( | fis) | g\fermata \fine
}

soprano_lyrics = \lyricmode {
  Te -- re -- si -- ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá)
  her -- ma -- na Te -- re -- sa, Te -- re -- si -- ca~her -- ma -- na (De
  la fa -- ra -- ri -- ri -- rá) (De __ la fa -- ra -- ri -- ri -- rá)
  her -- ma -- na Te -- re -- sa, si a ti plu -- guies -- se u -- na no --
  che __ so -- la con -- ti -- go dur -- mie -- se con -- ti -- go dur --
  mie -- se (De la fa -- ra -- ri -- ri -- rá) (De __ la fa -- ra -- ri --
  ri -- rá) her -- ma -- na Te -- re -- sa, Te -- re -- si -- ca~her --
  ma -- na (De la fa -- ra -- ri -- ri -- rá) her -- ma -- na Te -- re --
  sa. U -- na no -- che so -- la yo bien dor -- mi -- rí -- a, mas ten --
  go gran mie -- do que m'em -- pre -- ña -- rí -- a, (De la fa -- ra --
  ri -- ri -- rá) (De __ la fa -- ra -- ri -- ri -- rá) her -- ma -- na
  Te -- re -- sa, Te -- re -- si -- ca~her -- ma -- na (De la fa -- ra --
  ri -- ri -- rá) her -- ma -- na Te -- re -- sa, her -- ma -- na Te --
  re -- sa. Lla -- man a Te -- re -- si -- ca, y no vie -- ne; tan ma -- la
  no -- che tie -- ne, tan ma -- la no -- che tie -- ne. __ Llá -- ma -- la
  su ma -- dre, y~e -- lla ca -- lla. __ Llá -- ma -- la su ma -- dre,
  y~e -- lla ca -- lla y~e -- lla ca -- lla. Ju -- ra -- men -- to tie -- ne
  he -- cho de ma -- tar -- la. ¡Qué ma -- la no -- che tie -- ne! ¡Qué
  ma -- la no -- che tie -- ne!
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
>>

alto_music = {
  % 1
  d2. d4 | e2 e | f d | g2. f4 |
  % 5
  e4 f e d | c d c bes | a2 d | c bes |
  % 9
  a2 a | g1 | R1*2 |
  % 13
  R1*2 | r2 d'4 d | e2 e |
  % 17
  f2 d | g2. g4 | e e f f | d2 g~ |
  % 21
  g4 f e d | c2. bes4 | c a2 g4 | a2 f' |
  % 25
  f2 d | e d | d d4 d | e1 |
  % 29
  f2 g~( | g fis) | g1 | R1 |
  % 33
  r2 c,4 d | e f g2~( | g fis) | g1 |
  % 37
  r2 c,4 d | e f g2~( | g fis) | g d4 d |
  % 41
  e2 e | f d | g2. g4 | e e f f |
  % 45
  d2 g~ | g4 f e d | c2. bes4 | c a2 g4 |
  % 49
  a2 f' | f d | e d | d d4 d |
  % 53
  e2 e | f1 | d | g2. f4 |
  % 57
  f4 f f d | d2 f | f d | e d |
  % 61
  d1 | R1*3 |
  % 65
  g2 g | a2. g4 | fis2 g | R1 |
  % 69
  R1 | g4 fis g e | fis2 g | R1 |
  % 73
  R1*2 | g2 g | a2. g4 |
  % 77
  fis2 g4 d8 d | e2 e | f d | g2. g4 |
  % 81
  e4 e f f | d2 g~ | g4 f e d | c2. bes4 |
  % 85
  c4 a2 g4 | a2 f' | f d | e d |
  % 89
  d2 d4 d | e2 e | f1 | d |
  % 93
  g2. g4 | f f f d | d2 f | f d |
  % 97
  e2 d | \time 3/2 d1 d2 | f1 d2 \bar "!" e d1 |
  % 101
  d1. \bar "||" g1 g2 | g g g | g1 g2 |
  % 105
  fis2 g1 | g1.~ | g | fis |
  % 109
  r2 r g | g1 g2 | a1 g2 | g1.( |
  % 113
  fis1.) | g | r2 r d | d1 d2 |
  % 117
  f1 d2 | ees( bes c) | d1.~ | d~ |
  % 121
  d1. | g1 g2 | g1 g2 | g1 g2 |
  % 125
  fis2 g1 | a2 g ees \bar "!" f g( fis) | g1.~ |
  % 129
  g1. | d1 d2 | d1 d2 | d1 d2 |
  % 133
  f2 d1 | ees1.( \bar "!" d) | d |
  % 137
  r2 g g | g1 g2 | g1 g2 | g1 g2 |
  % 141
  fis2 g1 | g1.~ | g | fis |
  % 145
  r2 r g | g1 g2 | a1 g2 | g1.( |
  % 149
  fis1.) | g | r2 r d | d1 d2 |
  % 153
  f1 d2 | ees1( c2 | d1.) | d\fermata \fine
}

alto_lyrics = \lyricmode {
  Te -- re -- si -- ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá --
  ra -- ri -- ri -- rá) her -- ma -- na Te -- re -- sa, Te -- re -- si --
  ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá) (De __ la fa --
  ra -- ri -- ri -- rá -- ri -- ri -- rá) her -- ma -- na Te -- re -- sa, si
  a ti plu -- guies -- se u -- na no -- che so -- la con -- ti -- go dur --
  mies -- se con -- ti -- go dur -- mies -- se (De la fa -- ra -- ri --
  ri -- rá) (De __ la fa -- ra -- ri -- ri -- rá -- ri -- ri -- rá) her --
  ma -- na Te -- re -- sa, Te -- re -- si -- ca~her -- ma -- na (De la fa --
  ra -- ri -- ri -- rá) her -- ma -- na Te -- re -- sa. U -- na no -- che
  so -- la yo bien dor -- mi -- rí -- a, mas ten -- go gran mie -- do que
  m'em -- pre -- ña -- rí -- a, (De la fa -- ra -- ri -- ri -- rá) (De __ la
  fa -- ra -- ri -- ri -- rá -- ri -- ri -- rá) her -- ma -- na Te -- re --
  sa, Te -- re -- si -- ca~her -- ma -- na (De la fa -- ra -- ri -- ri --
  rá) her -- ma -- na Te -- re -- sa, her -- ma -- na Te -- re -- sa. Lla --
  man a Te -- re -- si -- ca, y no vie -- ne; tan ma -- la no -- che tie --
  ne, tan ma -- la no -- che tie -- ne. __ Llá -- ma -- la su ma -- dre,
  y~e -- lla ca -- lla, y~e -- lla ca -- lla. __ Llá -- ma -- la su ma --
  dre, y~e -- lla ca -- lla. Ju -- ra -- men -- to tie -- ne he -- cho de
  ma -- tar -- la. ¡Qué ma -- la no -- che tie -- ne! ¡Qué ma -- la no --
  che tie -- ne!
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
>>

tenor_music = {
  % 1
  R1*4 |
  % 5
  R1*4 |
  % 9
  R1 | g'2. g4 | a2 a | bes g |
  % 13
  c2. bes4 | a bes a g | fis2 bes | a g |
  % 17
  g2 f | g1 | r2 c4 c | d2 d |
  % 21
  e2 c | f2. e4 | f e d cis | d2 d |
  % 25
  c2 bes | c a | g1 | R1 |
  % 29
  R1*2 | r2 g4 g | a2 bes |
  % 33
  a1 | g | d'2. c4 | bes2 a4( g) |
  % 37
  a1 | g | d'2. c4 | bes2 bes |
  % 41
  c2( g | d'1) | g, | r2 c4 c |
  % 45
  d2 d | e c | f2. e4 | f e d cis |
  % 49
  d2 d | c bes | c a | g bes4 bes |
  % 53
  c2 g | d'1~ | d2 bes | ees2. d4 |
  % 57
  c4 d c bes | a2 d | c b | c a |
  % 61
  g1 | bes2 bes | c2. bes4 | a2 g |
  % 65
  R1*3 | bes4 a bes g |
  % 69
  a2 g | R1*2 | bes2 bes |
  % 73
  c2. bes4 | a2 g | R1*2 |
  % 77
  r2 bes4 bes | c2 g | d'1 | d |
  % 81
  r2 c4 c | d2 d | e c | f2. e4 |
  % 85
  f4 e d cis | d2 d | c b | c a |
  % 89
  g2 bes4 bes | c2 g | d'1~ | d2 bes |
  % 93
  ees2. d4 | c d c bes | a2 d | c b |
  % 97
  c2 a | \time 3/2 g1 bes2 | c1 b2 \bar "!" c a1 |
  % 101
  g1. \bar "||" d'1 d2 | d d d | d1 d2 |
  % 105
  d1 d2 | ees1.( | d) | d |
  % 109
  r2 r d | d1 d2 | f1 d2 | ees1( c2 |
  % 113
  d1.) | b | r2 r bes | bes1 bes2 |
  % 117
  c1 bes2 | g1.( | a) | g~ |
  % 121
  g1. | d'1 d2 | d1 d2 | d1 d2 |
  % 125
  d1 d2 | ees1.( \bar "!" d) | d~ |
  % 129
  d1. | bes1 bes2 | bes1 bes2 | bes1 bes2 |
  % 133
  a2 bes1 | c1.( \bar "!" a) | g |
  % 137
  r2 d' d | d1 d2 | d1 d2 | d1 d2 |
  % 141
  d1 d2 | ees1.( | d) | d |
  % 145
  r2 r d | d1 d2 | f1 d2 | ees1( c2 |
  % 149
  d1.) | b | r2 r bes | bes1 bes2 |
  % 153
  c1 bes2 | g1.( | a) | g\fermata \fine
}

tenor_lyrics = \lyricmode {
  Te -- re -- si -- ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá)
  her -- ma -- na Te -- re -- sa Te -- re -- si -- ca~her -- ma -- na (De la
  fa -- ra -- ri -- ri -- rá) her -- ma -- na Te -- re -- sa, si a ti plu --
  guies -- se u -- na no -- che __ so -- la con -- ti -- go dur -- mie -- se
  con -- ti -- go dur -- mies -- se (De la fa -- ra -- ri -- ri -- rá)
  her -- ma -- na Te -- re -- sa, Te -- re -- si -- ca~her -- ma -- na (De
  la fa -- ra -- ri -- ri -- rá) her -- ma -- na Te -- re -- sa. U -- na
  no -- che so -- la yo bien dor -- mi -- rí -- a, mas ten -- go gran mie --
  do que m'em -- pre -- ña -- rí -- a, que m'em -- pre -- ña -- rí -- a. (De
  la fa -- ra -- ri -- ri -- rá) her -- ma -- na Te -- re -- sa, Te -- re --
  si -- ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá) her -- ma --
  na Te -- re -- sa, her -- ma -- na Te -- re -- sa. Lla -- man a Te --
  re -- si -- ca, y no vie -- ne; tan ma -- la no -- che tie -- ne, tan
  ma -- la no -- che tie -- ne. __ Llá -- ma -- la su ma -- dre, y~e -- lla
  ca -- lla. __ Llá -- ma -- la su ma -- dre, y~e -- lla ca -- lla. Ju --
  ra -- men -- to tie -- ne he -- cho de ma -- tar -- la. ¡Qué ma -- la
  no -- che tie -- ne! ¡Qué ma -- la no -- che tie -- ne!
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
>>

basse_music = {
  % 1
  R1*4 |
  % 5
  R1*4 |
  % 9
  d2. d4 | e2 e | f d | g2. f4 |
  % 13
  e4 f e d | c d c bes | a2 d | c e |
  % 17
  d2 d | g, g'4 g | a2 a | bes g |
  % 21
  c2. bes4 | a g f g | f2 e | d bes |
  % 25
  f'2 g | c, d | g,1 | R1 |
  % 29
  R1 | r2 d'4 d | e2 e | f( g~ |
  % 33
  g2 fis) | g1 | d2. d4 | e f g2~( |
  % 37
  g2 fis) | g1 | d2. d4 | e f g2( |
  % 41
  c,2 e) | d1 | r2 g4 g | a2 a |
  % 45
  bes2 g | c2. bes4 | a g f e | f2 e |
  % 49
  d2 bes | f' g | c, d | g, g'4 g |
  % 53
  c,2 e | d1 | g | c,2. d4 |
  % 57
  f4 bes, f' g | d2 bes | f' g | c, d |
  % 61
  g,1 | g'2 g | a2. g4 | fis2 g |
  % 65
  R1*3 | g4 fis g e |
  % 69
  fis2 g | R1*2 | g2 g |
  % 73
  a2. g4 | fis2 g | R1*2 |
  % 77
  r2 g4 g | c,2 e | d1 | g,2 g'4 g |
  % 81
  a2 a | bes g | c2. bes4 | a g f g |
  % 85
  f2 e | d bes | f' g | c, d |
  % 89
  g,2 g'4 g | c,2 e | d1 | g |
  % 93
  c,2. d4 | f bes, f' g | d2 bes | f' g |
  % 97
  c,2 d | \time 3/2 g,1 g'2 | f1 g2 \bar "!" c, d1 |
  % 101
  g,1. \bar "||" g'1 g2 | g g g | g1 g2 |
  % 105
  d2 g1 | c,1.( | g') | d |
  % 109
  r2 r g | g1 g2 | f1 g2 | ees1.( |
  % 113
  d1.) | g, | r2 r g' | g1 g2 |
  % 117
  f1 g2 | ees1.( | d) | g,~ |
  % 121
  g1. | g'1 g2 | g1 g2 | g1 g2 |
  % 125
  d2 g1 | c,1.( \bar "!" d) | g,~ |
  % 129
  g1. | g'1 g2 | g1 g2 | g1 g2 |
  % 133
  d2 g1 | c,1.( \bar "!" d) | g, |
  % 137
  r2 g' g | g1 g2 | g1 g2 | g1 g2 |
  % 141
  d2 g1 | c,1.( | g') | d |
  % 145
  r2 r g | g1 g2 | f1 g2 | ees1.( |
  % 149
  d1.) | g, | r2 r g' | g1 g2 |
  % 153
  f1 g2 | ees1.( | d) | g,\fermata \fine
}

basse_lyrics = \lyricmode {
  Te -- re -- si -- ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá --
  ra -- ri -- ri -- rá) her -- ma -- na Te -- re -- sa Te -- re -- si --
  ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá -- ri -- rá) her --
  ma -- na Te -- re -- sa, si a ti plu -- guies -- se u -- na no -- che
  so -- la con -- ti -- go dur -- mies -- se con -- ti -- go dur -- mies --
  se (De la fa -- ra -- ri -- ri -- ra -- ri -- rá) her -- ma -- na Te --
  re -- sa, Te -- re -- si -- ca~her -- ma -- na (De la fa -- ra -- ri --
  ri -- rá) her -- ma -- na Te -- re -- sa. U -- na no -- che so -- la yo
  bien dor -- mi -- rí -- a, mas ten -- go gran mie -- do que m'em -- pre --
  ña -- rí -- a, que m'em -- pre -- ña -- rí -- a, (De la fa -- ra -- ri --
  ri -- ra -- ri -- rá) her -- ma -- na Te -- re -- sa, Te -- re -- si --
  ca~her -- ma -- na (De la fa -- ra -- ri -- ri -- rá) her -- ma -- na
  Te -- re -- sa, her -- ma -- na Te -- re -- sa. Lla -- man a Te -- re --
  si -- ca, y no vie -- ne; tan ma -- la no -- che tie -- ne, tan ma -- la
  no -- che tie -- ne. __ Llá -- ma -- la su ma -- dre, y~e -- lla ca --
  lla. __ Llá -- ma -- la su ma -- dre, y~e -- lla ca -- lla. Ju -- ra --
  men -- to tie -- ne he -- cho de ma -- tar -- la. ¡Qué ma -- la no -- che
  tie -- ne! ¡Qué ma -- la no -- che tie -- ne!
}

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\basse_music}
  \addlyrics {\basse_lyrics}
>>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveAllEmptyStaves
      }
      %% Les passages syllabiques serrent les paroles au point que le graveur
      %% escamote les traits d'union : on leur garantit de la place.
      \context {
        \Lyrics
        \override LyricSpace.minimum-distance = #1.0
        \override LyricHyphen.minimum-distance = #1.5
      }
    }
    <<
      \new ChoirStaff <<
        \soprano
        \alto
        \tenor
        \basse
      >>
    >>
  }
  \score {
    \unfoldRepeats
    <<
      \new ChoirStaff <<
        \soprano
        \alto
        \tenor
        \basse
      >>
    >>
    \midi {
      %% Pas de paroles dans le MIDI. Une ligne de paroles qui commence au
      %% premier temps ouvre sa piste avant la portée suivante et lui prend un
      %% canal ; au-delà de seize, les canaux rebouclent et deux voix se
      %% retrouvent sur le même — or le lecteur du site range les notes par
      %% canal, et les fusionnerait.
      \context {
        \Lyrics
        \remove "Lyric_performer"
      }
    }
  }
}

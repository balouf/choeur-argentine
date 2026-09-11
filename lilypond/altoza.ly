% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Alto Zagales"}
  composer = "Juan Gutiérrez de Padilla"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

solo = \markup {\italic [Solo]}
tutti = \markup {\italic [Tutti]}


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 3/8
\tempo 4. = 72
\key c \major
}

sola_music = {
  \partial 4. c'8 g g \bar "||"
  r2. c8^\solo g g c c8. b16 a8 a a
  d d8. c16 b8 8. a16 g8 8 8 c8 8. b16 a4 8 r d d
  cis d d a b8. c16 d8 g,8. a16 b8 c c c b8. 16 c4.
  r8 8. d16 e8 d d c b a b4.\fermata \bar "||"
  R4.*33 r4 b8~8 a4 \bar "||"
  % Segno Here
  b8 8 c d4 8 e e e e d d
  e c c c4 8 4.~c~c
}

sola_lyrics = \lyricmode {
 Al -- to za...
 Al -- to, za -- ga -- les de to -- do~el e -- ji -- do
 al sol que~ha na -- ci -- do ga -- lán y pu -- li -- do
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril.
 
 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril, __
}


sola = \new Staff \with {instrumentName="Sop. Solo"
  shortInstrumentName ="S. 1"} <<
  \soprano_style
  \armure
  \relative c' {\sola_music}
  \addlyrics {\sola_lyrics}
>>

alta_music = {
  \partial 4. g'8 d d \bar "||"
  g^\solo d d g g8. f16 e8 8 8 a a8. g16 fis8 8. e16
  d8 8 8 g8 8. f16 e4. e r8 f f e f8. g16
  a8 g g fis g g d e8. f16 g8 e4 f8 d8. 16 e8 a a
  g a a g4 8~8 fis4 g4.\fermata \bar "||"
  R4.*33 r4 g8~8 fis4 \bar "||"
  % Segno
  g8 8 8 4 f8 e e e e g g 
  e e d c4 e8 c4.~c r8 f f
}

alta_lyrics = \lyricmode {
 Al -- to za...
 Al -- to, za -- ga -- les de to -- do~el e -- ji -- do
 al sol que~ha na -- ci -- do ga -- lán y pu -- li -- do
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril.

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril, __
con el
}


alta = \new Staff \with {instrumentName="Alt. Solo"
  shortInstrumentName ="A. 1"} <<
  \soprano_style
  \armure
  \relative c' {\alta_music}
  \addlyrics {\alta_lyrics}
>>


tena_music = {
  \partial 4. c'8 g g
  r4. c8^\solo g g c c8. b16 a8 8 8 d d8. c16
  b8 8. a16 g8 8 8 c c8. b16 a4 8 r d d cis d d
  a b8. c16 d8 g,8. a16 b8 c c g a4 f8 g8. 16 c8 f f 
  e f f c b4 a4. g\fermata \bar "||"
  R4.*33 r4 g8~8 d'4 \bar "||"
  % segno
  g,8 8 a b4 8 c c c g g g 
  g g g g4 c8 f,4 8 g g g c4.
    
}

tena_lyrics = \lyricmode {
 Al -- to za...
 Al -- to, za -- ga -- les de to -- do~el e -- ji -- do
 al sol que~ha na -- ci -- do ga -- lán y pu -- li -- do
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril.

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán
}


tena = \new Staff \with {instrumentName="Ten. Solo"
  shortInstrumentName ="T. 1"} <<
  \tenor_style
  \armure
  \relative c' {\tena_music}
  \addlyrics {\tena_lyrics}
>>


sop_music = {
  \partial 4. g'8 d d 
  R4.*21 \break
  R4.*2 g8^\tutti d d g g8. f16 e8 4 a4 8 g8 4
  a4 e8 f f f~f e e d d g g g fis
  g4 8 a g f e4 a8 g a8. 16 g8 a4
  r4 8 g a8. 16 g8 a8. 16 g8 e4 f8 8 d~
  8 e4 d8 b c d4 8 e e e d d d
  d g g f d4 e4 8 fis8 8 8 8 g g
  g fis4 g4. r \bar "||"
  \repeat segno 2 {
  r4. r r4 8~8 4 8 e f g4 8 a a a g g g g a a
  g e4 fis4. r r r r4 d8
  g g g f e e g4 a8 4. r8 d, b e d4 4.\fermata
  \volta 2 \fine \break
  \volta 1 {r r}
  }
}

sop_lyrics = \lyricmode {
Al -- to za...
Al -- to za -- ga -- les de mil en mil, de mil en 
mil, nin -- gún pe -- li -- gro re -- ce -- la y to -- do pas -- 
tor, a más y me -- jor, 
re -- pi -- que, re -- pi -- que,
re -- pi -- que, re -- pi -- que,
la fo -- li -- güe -- la, al
chaz -- chaz con la cas -- ta ñue -- la
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,

}

sop = \new Staff \with {instrumentName="Sop./Alt."
  shortInstrumentName ="S.A. II"} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
>>

ten_music = {
  \partial 4. d'8 a a
  R4.*21 \break
  d8^\tutti a a d d8. c16 b8 4 e4 8 c8 4 f4 8 e8 4
  cis4 8 d a d~8 c c b b b e d c
  b4 e8 a, b b c4. r4 f8 e f8. 16 
  c8 f4 r4 8 e a,8. 16 b8 cis4 d8 8 b~
  8 c4 b8 g a b4 8 c c c b b b b e e a, b4 c4 8 a8 8 8 8 d d
  c a4 b4. r \bar "||"
  % segno
  r4. r r4 c8~8 d4 c8 c d e4 8 f f f e e e e a, a
}

ten_lyrics = \lyricmode {
Al -- to za...
Al -- to za -- ga -- les de mil en mil, 
de mil en mil, de mil en 
mil, nin -- gún pe -- li -- gro re -- ce -- la y to -- do pas -- 
tor, a más y me -- jor, 
re -- pi -- que, re -- pi -- que,
re -- pi -- que
la fo -- li -- güe -- la, al
chaz -- chaz con la cas -- ta ñue -- la
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T. II"} <<
  \tenor_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
>>

bass_music = {\partial 4. g'8 d d
  R4.*21 \break
  R4. g8^\tutti d d g8 8. f16 e8 4 a4 8 f f f c' b4
  a4 a,8 d d d~d e f g g g c b a
  g4 e8 f e d c4 f8 e f8. 16 c8 f4
  r4 8 e f8. 16 c8 f8. 16 g8 a4 d,8 8 g~
  8 c,4 g'4.~g r4 c,8 g' g g g e e f g4 c, a8 d d d d b b
  c d4 g,4. r \bar "||"
  % segno
  r4. r r4 c8~8 g4 c4.~c r4 f8 c c c c f f 
}

bass_lyrics = \lyricmode {Al -- to za...
Al -- to za -- ga -- les de mil en mil, 
de mil en __ _  mil, en 
mil, nin -- gún pe -- li -- gro re -- ce -- la y to -- do pas -- 
tor, a más y me -- jor, 
re -- pi -- que, re -- pi -- que,
re -- pi -- que, re -- pi -- que,
la fo -- li -- güe -- la, al
chaz -- chaz __
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,

 al chaz -- chaz __ 
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B. II"} <<
  \hommes_style
  \armure
  \relative c {\bass_music}
  \addlyrics {\bass_lyrics}
>>



#(set-global-staff-size conductor_size)
\book {
  \score {
        \layout {
  \context {
    \Staff
    \RemoveAllEmptyStaves
  }
}
<<
    \new ChoirStaff
    <<
      \sola
      \alta
      \tena
    >>
    \new ChoirStaff
    <<
      \sop
      \ten
      \bass
    >>
>>
  }
   \score {
    \unfoldRepeats
    <<
      \sola
      \alta
      \tena
      \sop
      \ten
      \bass
    >>
    \midi {}
  }
}


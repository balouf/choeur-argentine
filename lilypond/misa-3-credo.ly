% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Misa Criolla"
  subtitle = "3 - Credo"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 16
individual_size = 20

\include "utils/macros.ly"


%%%%%%%%%%%%%%%%%
% Credo
%%%%%%%%%%%%%%%%%

credo = {
\compressEmptyMeasures
\time 6/8
\tempo 4 = 152
\key c \major
}

clead_music = {
  R2.*19
  R2.*9
  \repeat volta 2 {
  <c'e>4. <a c>4 <gis b>8 8( <a c>4.) r4
  <c e>4. <a c>4 <gis b>8 
  \alternative {{8( <a c>4.) r4}{8( <a c>4.) <a c>8 <b d>}}
  }
  \break
  \repeat volta 2 {
  <c e>8 4 4 <d fis>8
  \times 3/2 {<e g> <d fis>8 8 <c e>8 }
  \times 3/2 { 8 <b d>8 8 8}
  \alternative {{<c e> <a c>4. 8 <b d>}{<c e> <a c>4. r8 e'}}
  }
  e d d c b b~ b c4. b8 c 
  b8 c4 d e8~ 8 c4. r8 <c e e,>8
  8 <d b d,>8 8 <c a c,> <b gis b,>8 8~ 8 <c a c,>4. <b gis b,>8 <c a c,> 
  <b gis b,>8 <c a c,>4 <d b d,> <e c e,>8~ 8 <c a c,>4. r4
  \break
  R2.*11
  r4 r <c a>8 <d b> 
  \times 3/2 { <e c>8 8 8 <fis d> }  \times 3/2 { <g e> <fis d>8 8 <e c> }
  \times 3/2 { 8 <d b>8 8 8 } <e c> <c a>4 r8 <c a>8 <d b> 
  \times 3/2 { <e c>8 8 8 <fis d> }  \times 3/2 { <g e> <fis d>8 8 <e c> }
  4 <d b> r8 8 <e c> <c a>4. r8 <e c>8
  4. <c a>4 <b gis>8 8 <c a>4. r8 <e c>8
  4. <c a>4 <b gis>8 8 <c a>4. r4
  R2.*8
  \bar "||" \key a \major
  R2.*8
  <cis e>4. <b d>4 <a cis>8 
  <gis b>4. <a cis>8 r4 r2. r2.
  <g e' g>4. <g d' f>8 r <g c e>
  <g b d>4.( <g c e>4) r8 R2.*4
  a4. 4 <a e' g>8 4. <a d fis>
  a4. 4 <a e' g>8 4. <a d fis>
  r2. r4 r r8 <cis e>
  <b d> <a cis>4 <g b>8 <fis a>4
  \times 3/2 {<e g>8 <d fis> <cis e> <d fis> }
  <e g>2 r4 R2.*2
  R2.*16
  R2.*8
  r4 r <cis' e>8 <b d e>
  <a cis e> <gis b e>4 <cis e> <b d e>8
  <a cis e>4 <gis b e> r
  R2.*2
  <cis e>8-- <b d e> <a cis e> <gis b e> <cis e>-- <b d e>
  <a cis e>4 <gis b e> <cis e>8 <b d e>
  <a cis e>8 <gis b e>4 <cis e> <b d e>8 
  <a cis e>4 <gis b e> r
  R2.*21
  \fine
}

clead_lyrics = \lyricmode {
  Cre -- o en Dios 
  Cre -- o en Dios Dios
  Pa -- dre To -- do -- po -- de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra Pa -- dre tie -- rra 
y~en Je -- su -- cris -- to cre -- e -- o
y~en Je -- su -- cris -- to cre -- o
y~en Je -- su -- cris -- to cre -- e -- o
y~en Je -- su -- cris -- to cre -- o
Na -- ció de San -- ta Ma -- ri -- a de San -- ta Ma -- ri -- a Vir -- gen
pa -- de -- ció ba -- jo~el po -- der, po -- der de Pon -- cio Pi -- la -- to
Fue cru -- ci -- fi -- ca -- do, muer -- to~y se -- pul -- ta -- do.

Al ter -- cer di -- a
re -- su -- ci -- tó __
Su -- bió~a -- los cie -- los, Su -- bió~a -- los cie -- los
es -- tá sen -- ta -- do~a la dies -- tra de Dios

Creo~en el Es -- pi -- ri -- tu San -- to
La co -- mu -- niòn de los San -- tos y~el 
per dón de los pe -- ca -- dos
}

lead = \new Staff \with {instrumentName="Lead"
  shortInstrumentName ="L."} <<
  \soprano_style
  \credo
  \relative c' {\clead_music}
  \addlyrics {\clead_lyrics}
>>


csop_music = {
  R2.*19
  r4 r a'8 gis 
  a b4 a gis8 4 a gis8 a 
  b a4 gis a8 b4 a a8 gis 
  a b4 a gis8 4 a gis8 a 
  b a4 gis a8 b4 a a8 gis 
  \repeat volta 2 {
  a b4 a gis8 4 a gis8 a 
  b a4 gis a8
  \alternative {{b4 a a8 gis }{b4 a r}}
  }
  \repeat volta 2 {
  R2.*3
  \alternative {{R2.}{R2.}}
  }
  R2.*8
  e4. 8 r e e'4( b8) e r4 e8 c4 b8 r e8 4. r4. r2. r2.
  e8 g4 e8 r d d4. c8 \breathe  a4 gis8 a4 b a8 
  gis4.-- a8 \breathe 4 gis8 a4 b a8 gis4.-- a8 r4
  R2.*7 r4 r r8 e'8~ e2.~ 2.~ 2.~ 4.~ 8 c d
  \times 3/2 { e e e fis } \times 3/2 { g fis fis e}
  e d r r d d e4 c4 a8 gis8
  a8 b4 a4 gis8  gis4 a4 gis8 a8  
  b8 a4 gis4 a8 b4 a4 cis8 b
  \bar "||" \key a \major
  cis d4 cis b8 4 cis b8 cis
  d cis4 b cis8 d4 cis4
  <<
      {
        \voiceOne
  e,8 e
  e' e e e fis gis gis a e4
  e,8 8 e'8 4 fis e8 2 }
      \new Voice {
        \voiceTwo
  8 b
  cis d4 cis b8 4 cis b8 cis
  d cis4 b cis8 d4 cis4    }
    >>
  \oneVoice
   r
  R2.*2
  e4. <e d>4 <e cis>8 <e b>4. <e cis>8 r4 R2.*2
  g4. <g f>8 r8 <g e>8 <g d>4.( <g e>8) r8 <e cis>8 
  <b d>8 <a cis>4 <g b>8 <fis a>4
  <d g>8 <d fis>4 <cis e>8 <d fis>4 R2.*4
  e'4. d4 cis8 b4. cis4 r8 R2.*2
  r4 r a8 8 8 4 4 8 4-- 4 r

  R2.*16
  R2.*4
  r4 r d8 cis d e4 d cis8
  cis4( d) cis8 d e d4 cis d8 e4 d r r2.
  r4 r b b8 a4 gis fis8 a gis fis4 r
  R2.*7
  r4 r a gis4. cis b <cis e> <b d> <a cis>
  <gis b> r8 <a e'>4 <gis e'>4. <a e'> <b e> <cis e>
  <b e> <cis e> <d e> <cis e> <gis b> <e a>
  \repeat unfold 5 { gis <e a> }
  gis2.~ 2.~ 8 r r4 r \fine
}


csop_lyrics = \lyricmode {
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre Tie -- rra

Su~U -- ni -- co Hi -- jo Nue __ _ stro Se -- ñor
por __ _ o -- bra~y gra -- cia
del es -- pi -- ri -- tu San -- to 
del es -- pi -- ri -- tu San -- to
b.f. __
Des -- cen -- dió a los in -- fier -- nos,
Des -- cen -- dió a los in -- fier -- nos
Des -- cen -- dió a los in -- fier -- nos,
Des -- cen -- dió a los in -- fier -- nos
la -- ra
la -- ra la la la -- ra la -- ra la -- ra la la
la -- ra la -- ra la -- ra la la -- ra la la la -- ra la -- ra
la -- ra la la la

Al ter -- cer di -- a re -- su -- ci -- tó __
re -- su -- ci -- tó de~en -- tre los muer -- tos
Su -- bió~a -- los cie -- los
Pa -- dre To -- do -- po -- de -- ro -- so

Des -- de~a -- lli ha de ve -- nir __
a juz -- gar -- vi -- vos y muer -- tos
San -- ta~I -- gle -- sia Ca -- tó -- li -- ca
\repeat unfold 14 {A -- mén }
A -- mén __
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \credo
  \relative c' {\csop_music}
  \addlyrics {\csop_lyrics}
>>


calt_music = {
  R2.*19
  r4 r e8 8
  8 4 4 8 4 4 8 8 8 4 4 8 4 4 8 8
  8 4 4 8 4 4 8 8 8 4 4 8 4 4 8 8
  \repeat volta 2 {
  8 4 4 8 4 4 8 8 8 4 4 8
  \alternative {{4 4 8 8}{4 4 r}}
  }
  \repeat volta 2 {
  R2.*3
  \alternative {{R2.}{R2.}}
  }
  R2.*8
  c'4. gis8 r c b4. a8 r4 a4. gis8 r b8 a4. r4. r2. r2.
  c8 e4 c8 r b b4. a8 \breathe e4 8 4 4 8 
  4.-- 8 \breathe 4 8 4 4 8 4.-- 8 r4
  \repeat unfold 15 {e4.-- } r 
  R2.*3 r4 r a8 b
  \times 3/2 { c c c d } \times 3/2 { e d d c }
  c b r r b b c4 a4 e8 8
  8 4 4 8  4 4 8 8  8 4 4 8 4 4 a8 gis
  \bar "||" \key a \major
  a b4 a gis8 4 a gis8 a
  b a4 gis a8 b4 a4 8 gis
  a b4 a gis8 4 a gis8 a
  b a4 gis a8 b4 a4 r
  R2.*2
  cis4. b4 a8 gis4. a8 r4 R2.*2
  e'4. d8 r8 c8 b4. c8 r8 a8 8 e4 d8 cis4
  b8 4 a8 4 R2.*4
  cis'4. b4 a8 gis4. a4 r8 R2.*2
  r4 r e8 8 8 4 4 8 4-- 4 r
  R2.*16
  r4 r d8 cis d e4 d cis8 cis4( d) cis8 d
  e d4 cis d8 e4 d a'8 8 8 4 4 8
  4~ 4 8 8 8 4 4 8 4 4 r r2.
  r4 r gis gis8 fis4 e dis8 fis e dis4 r
  R2.*7
  r4 r e e4. a gis a e e e r8 e4 e4. e e
  a gis a b a e a e a e a e a e a e a
  e2.~ e~ e8 r r4 r \fine
}

calt_lyrics = \lyricmode {
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre Tie -- rra

Su~U -- ni -- co Hi -- jo Nue -- stro Se -- ñor
por __ _ o -- bra~y gra -- cia
del es -- pi -- ri -- tu San -- to 
del es -- pi -- ri -- tu San -- to 

b.f. \repeat unfold 14 { "" }
Des -- cen -- dió a los in -- fier -- nos,
Des -- cen -- dió a los in -- fier -- nos
Des -- cen -- dió a los in -- fier -- nos,
Des -- cen -- dió a los in -- fier -- nos
la -- ra
la -- ra la la la -- ra la -- ra la -- ra la la
la -- ra la -- ra la -- ra la la la -- ra la -- ra
la -- ra la la la -- ra

Al ter -- cer di -- a re -- su -- ci -- tó __ _
re -- su -- ci -- tó de~en -- tre los muer -- tos
Su -- bió~a -- los cie -- los
Pa -- dre To -- do -- po -- de -- ro -- so

Des -- de~a -- lli ha de ve -- nir __
a juz -- gar -- vi -- vos y muer -- tos
Des -- de~a -- lli ha de ve -- nir __
a juz -- gar -- vi -- vos y muer -- tos
San -- ta~I -- gle -- sia Ca -- tó -- li -- ca
\repeat unfold 14 {A -- mén }
A -- mén __
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \credo
  \relative c' {\calt_music}
  \addlyrics {\calt_lyrics}
>>


cten_music = {
  R2.*19
  r4 r d'8 b8
  c8 d4 c4 b8 b4 c4 b8 c8 d8 c4 b4 c8 d4 c4 c8 b8
  c8 d4 c4 b8 b4 c4 b8 c8 d8 c4 b4 c8 d4 c4 c8 b8
  \repeat volta 2 {
    c8 d4 c4 b8 b4 c4 b8 c8 d8 c4 b4 c8 
  \alternative {{d4 c4 c8 b8}{d4 c4 r}}
  }
  \repeat volta 2 {
  R2.*3
  \alternative {{R2.}{R2.}}
  }
  R2.*8
  e4. 8 r e e4. 8 r4 e4. 8 r e8 4. r4.
  e4. 8 r <e d>8 4. <e c>8 r4
  e8 g4 e8 r <e d>8 4. <c e>8 \breathe c4 b8 c4 d4 c8 
  b4.-- c8 \breathe 4 b8 c4 d4 c8 b4.-- c8 r4
  R2.*7 r4 r r8 e8~ e2.~ 2.~ 2.~ 4.~ 8 c d
  \times 3/2 { e e e fis } \times 3/2 { g fis fis e}
  e d r r d d e4 c4 c8 b8
  c8 d4 c4 b8  b4 c4 b8 c8  
  d8 c4 b4 c8 d4 c4 e8 d
  \bar "||" \key a \major
  e fis4 e d8 4 e d8 e
  fis e4 d e8 fis4 e4 8 d
  e fis4 e d8 4 e d8 e
  fis e4 d e8 fis4 e4 r
  R2.*2
  e4. 4 8 4. 8 r4 R2.*2
  g4. 8 r8 8 4.~ 8 r8 e8 8 4 8 4
  8 a,4 8 d,4 R2.*4
  e'4. 4 8 4. 4 r8 R2.*2
  r4 r cis8 8 8 4 4 8 4-- 4 r
  R2.*16
  r4 r a8 8  8 4 4 8  4~ 4 8 8
  8 4 4 8  4 4 fis'8 e fis g4 fis e8
  e4( fis) e8 fis g fis4 e fis8 g4 fis r
  R2.*8
  b,8 a gis fis b a gis4 fis b8 a
  gis fis4 b a8 gis4 fis8 a4.
  b4. e e e fis cis d r8 cis4 b4. cis d fis
  e e e e d cis b cis b cis b cis
  b cis b cis b2.~ b~ b8 r r4 r \fine
}

cten_lyrics = \lyricmode {
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre To do po de -- ro -- so
Cre a -- dor de cie lo~y tie -- rra
Pa -- dre Tie -- rra

Su~U -- ni -- co Hi -- jo Nue -- stro Se -- ñor
fué con -- ce -- bi -- do
por __ _ o -- bra~y gra -- cia
del es -- pi -- ri -- tu San -- to 
del es -- pi -- ri -- tu San -- to
b.f. __
Des -- cen -- dió a los in -- fier -- nos,
Des -- cen -- dió a los in -- fier -- nos
Des -- cen -- dió a los in -- fier -- nos,
Des -- cen -- dió a los in -- fier -- nos
la -- ra
la -- ra la la la -- ra la -- ra la -- ra la la
la -- ra la -- ra la -- ra la la la -- ra la -- ra
la -- ra la la la -- ra

Al ter -- cer di -- a re -- su -- ci -- tó __
re -- su -- ci -- tó de~en -- tre los muer -- tos
Su -- bió~a -- los cie -- los
Pa -- dre To -- do -- po -- de -- ro -- so

Des -- de~a -- lli ha de ve -- nir __
a juz -- gar -- vi -- vos y muer -- tos
Des -- de~a -- lli ha de ve -- nir __
a juz -- gar -- vi -- vos y muer -- tos

re -- su -- rrec -- ción de la car -- ne 
y la vi -- da per -- du -- ra -- ble
\repeat unfold 14 {A -- mén }
A -- mén __
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \credo
  \relative c' {\cten_music}
  \addlyrics {\cten_lyrics}
>>


cbass_music = {
  R2.*19
  r2. r4. e,4 8 4 4 r4 r4. e4 8 4 4 r4
  r4. e4 8 4 4 r4 r4. e4 8 4 4 r4  
  \repeat volta 2 {
  r4. e4 8 4 4 r4 r4. e4 8
  \alternative {{4 4 r4}{4 4 r4}}
  }
  \repeat volta 2 {
  R2.*3
  \alternative {{R2.}{R2.}}
  }
  R2.*8
  c'4. b8 r c d4. c8 r4 c4. b8 r d8 c4. r4. c4. 8 r b8 4. a8 r4
  c8 e4 c8 r b b4. a8 \breathe e4 8 4 4 8 
  4.-- 8 \breathe 4 8 4 4 8 4.-- 8 r4
  \repeat unfold 7 {e2.-- } 2 r4 r2. r r r4 r a8 b
  \times 3/2 { c c c d } \times 3/2 { e d d c }
  c b r r b b c4 a4 r4 r4. e4 8 4 4 r r4. 4 8 4 4 cis'8 b
  \bar "||" \key a \major
  cis d4 cis b8 4 cis b8 cis
  d cis4 b cis8 d4 cis4 8 b
  cis d4 cis b8 4 cis b8 cis
  d cis4 b cis8 d4 cis4 r
  R2.*2
  e,4. 4 8 e'4. 8 r4 R2.*2
  e4. d8 r c b4. c8 r4 R2.*6
  a4. b4 cis8 d4. cis4 r8 R2.*2
  r4 r g8 8 8 4 4 8 4-- 4 r
  R2.*16
  r4 r fis8 e fis g4 fis e8 4( fis)
  e8 fis g fis4 e fis8 g4 fis r
  R2.*12
  gis8 fis e dis gis fis e4 dis gis8 fis
  e dis4 gis fis8 e4 dis8 cis4.
  b4. a e' fis gis a b r8 e,4 e4. e e
  e' d cis b a \repeat unfold 12 {e }
  e2.~ e~ e8 r r4 r \fine
}

cbass_lyrics = \lyricmode {
  po de -- ro -- so cie lo~y tie -- rra
po de -- ro -- so cie lo~y tie -- rra
po de -- ro -- so cie lo~y tie -- ra tie -- rra

Su~U -- ni -- co Hi -- jo Nue -- stro Se -- ñor
fué con -- ce -- bi -- do
por __ _ o -- bra~y gra -- cia
del es -- pi -- ri -- tu San -- to 
del es -- pi -- ri -- tu San -- to 

b.f. \repeat unfold 7 { "" }
Des -- cen -- dió a los in -- fier -- nos,
Des -- cen -- dió a los in -- fier -- nos,
los in -- fier -- nos,
los in -- fier -- nos, la -- ra
la -- ra la la la -- ra la -- ra la -- ra la la
la -- ra la -- ra la -- ra la la la -- ra la -- ra
la -- ra la la la -- ra
Al ter -- cer di -- a re -- su -- ci -- tó __ _
Su -- bió~a -- los cie -- los
Pa -- dre To -- do -- po -- de -- ro -- so

Des -- de~a -- lli ha de ve -- nir __
a juz -- gar -- vi -- vos y muer -- tos

re -- su -- rrec -- ción de la car -- ne 
y la vi -- da per -- du -- ra -- ble
\repeat unfold 14 {A -- mén }
A -- mén __
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \credo
  \relative c' {\cbass_music}
  \addlyrics {\cbass_lyrics}
>>

\include "utils/booksmisa.ly"

% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Misa Criolla"
  subtitle = "4 - Sanctus"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 16
individual_size = 20

\include "utils/macros.ly"


%%%%%%%%%%%%%%%%%
% Sanctus
%%%%%%%%%%%%%%%%%

sanctus = {
\compressEmptyMeasures
\time 6/8
\tempo 4. = 108
\key a \major
}

slead_music = {R2.*4 R2.*7 R2.*8
               e'4.cis8 r4 cis4. a8 r4 a2.~ a e'2 r4
               r2. r4 r e, a2.
               \break
               a8 b4 cis a8 b2 e4 e,2.~  e
               d'4. b8 r4 b4. gis8 r4 gis2.~ 2. 
               \break
               <e' gis>2 r4 r2.
               r4 r e, gis2. gis8 a4 b gis8 a2 cis4 e,2.~ e
               fis'4 e d d2 cis4 cis2.~ 2. e2.~ 2.~ 2 e,8 8 
               a4 e2~ 4 d' cis b2. e,~ e r
               d'4 cis b b2 a4 gis2.~ 2. e'2.~ 2.~ 2 e,8 8
               fis'4. e e d cis e e,4 r r R2.*9
               e'8^"Baguala taripeña" 4 4 d8 fis4 e e~ e r r R2.*3
               e8 4 4 d8 fis4 e e~ e2. R2.*3 \fine
     }

slead_lyrics = \lyricmode {
  San -- to San -- to San __ to
  Se -- ñor Dios del U -- ni -- ver  - so __
  San -- to San -- to San __ to
  Se -- ñor Dios del U -- ni -- ver  - so __
  
  lle -- nos es -- tán los cie __ los __
  y la tie -- rra __ de tu glo -- ria __
  lle -- nos es -- tán los cie __ los __
  y la tie -- rra __ de tu glo - ria
  
  O -- sa -- na~en las al -- tu -- ras __
  O -- sa -- na~en las al -- tu -- ras __
 }

lead = \new Staff \with {instrumentName="Lead"
  shortInstrumentName ="L."} <<
  \soprano_style
  \sanctus
  \relative c' {\slead_music}
  \addlyrics {\slead_lyrics}
>>


ssop_music = {
R2.*4 R2.*7 R2.*8 R2.*4
<e' a>4. <cis e>8 r4 <cis e>4. <a cis>8 r4 <a cis>2. <cis e>
R2.*8
<b d>4. <gis b>8 r4 <gis b>4. <d gis>8 r4 <d gis>2. <gis b> r2.
<cis e> <a cis>~ 2.
R2.*24 R2.*9
R2.*2 \break \times 3/2 {a8\pp a} g4 b8 a4 4 e8 8
\times 3/2 {a8 a} g4 b8 a2. R2.*3 
e'8 4 4 d8 fis4 e e~ 2. \fine
}


ssop_lyrics = \lyricmode {
  San -- to San -- to San -- to 
  San -- to San -- to San -- to 
  San -- to __
  Ben -- di -- to~el que vie -- ne en el nom -- bre del Se -- ñor
  O -- sa -- na~en las al -- tu -- ras __
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \sanctus
  \relative c' {\ssop_music}
  \addlyrics {\ssop_lyrics}
>>


salt_music = {
R2.*4 R2.*7 R2.*8 R2.*4
cis'4. a8 r4 a4. e8 r4 e2. a
R2.*8
gis4. d8 r4 d4. b8 r4 b2. d r
a' e~ e
R2.*24 R2.*9
R2.*2 \times 3/2 {e8\pp 8} d4 g8 e4 4 cis8 8
\times 3/2 {e8 8} d4 g8 e2. R2.*3 
cis'8 4 4 b8 d4 cis4 4~ 2. \fine
}

salt_lyrics = \lyricmode {
  San -- to San -- to San -- to 
  San -- to San -- to San -- to 
  San -- to __
  Ben -- di -- to~el que vie -- ne en el nom -- bre del Se -- ñor
  O -- sa -- na~en las al -- tu -- ras __}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \sanctus
  \relative c' {\salt_music}
  \addlyrics {\salt_lyrics}
>>


sten_music = {
R2.*4 R2.*7 R2.*8 R2.*4
R2.*4
R2.*8
R2.*8
R2.*24 R2.*9
R2.*2 \times 3/2 {cis'8\pp 8} b4 d8 cis4 4 a8 8
\times 3/2 {cis8 8} b4 d8 cis2. R2.*3 
a'8 4 4 8 4 4 4~ 2. \fine
}

sten_lyrics = \lyricmode {
  Ben -- di -- to~el que vie -- ne en el nom -- bre del Se -- ñor
  O -- sa -- na~en las al -- tu -- ras __
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \sanctus
  \relative c' {\sten_music}
  \addlyrics {\sten_lyrics}
>>


sbass_music = {
R2.*4 R2.*7 R2.*8 R2.*4
R2.*4
R2.*8
R2.*8
R2.*24 R2.*9
R2.*2 \times 3/2 {a8\pp 8} 4 8 4 4 8 8
\times 3/2 {8 8} 4 8 2. R2.*3
a2. a a \fine}

sbass_lyrics = \lyricmode {
    Ben -- di -- to~el que vie -- ne en el nom -- bre del Se -- ñor
  O -- sa -- na
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \sanctus
  \relative c' {\sbass_music}
  \addlyrics {\sbass_lyrics}
>>

\include "utils/booksmisa.ly"

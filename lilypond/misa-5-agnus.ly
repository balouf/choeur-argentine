% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Misa Criolla"
  subtitle = "5 - Agnus Dei"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 19
individual_size = 20

\include "utils/macros.ly"


%%%%%%%%%%%%%%%%%
% Agnus Dei
%%%%%%%%%%%%%%%%%


agnus = {
\compressEmptyMeasures
\time 3/4
\tempo 4 = 44
\key a \minor
}

alead_music = {
R2.*6
r4 r r8 c'
\time 6/8
\repeat volta 2 {c4.~ 8 e c b4 8 a4. gis~ 4 r8 
                 r d' d e4.~ 8 a, gis b4.~ 2. a\break 
                 e8 fis gis a gis a <c e>4.~ 8 <b d> <a c> 
                 <b d>4.~ 8 <a c> <gis b> <a c>4.~ 4 r8 R2.*4 r4 r r8 c}
\break
c4.~ 8 e c b4 8 a4. gis4.~ 4 r8 
r d' d e4.~ 8 a, gis b4.~ 2. a
\time 3/4
R2.*6 a4 d f~ 2. a\fermata \fine
}

alead_lyrics = \lyricmode {
Cor -- de -- ro de Dios que qui -- tas __
los pe -- ca -- dos del mun -- do.
Ten com -- pa -- sión de no -- so __ _ _ _ _ _ tros. __
Cor -- de -- ro de Dios que qui -- tas __
los pe -- ca -- dos del mun -- do.
da -- nos la __ paz.}

lead = \new Staff \with {instrumentName="Lead"
  shortInstrumentName ="L."} <<
  \soprano_style
  \agnus
  \relative c' {\alead_music}
  \addlyrics {\alead_lyrics}
>>


asop_music = {
R2.*7
\time 6/8
\repeat volta 2 {R2.*16}
R2.*7
\time 3/4
<a' d>4 4 <a cis> <a d>2. R2.*2
a4 a gis a2. R2. f4 f d e2.\fermata \fine
}


asop_lyrics = \lyricmode {
da -- nos la paz
da -- nos la paz
da -- nos la paz.}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \agnus
  \relative c' {\asop_music}
  \addlyrics {\asop_lyrics}
>>


aalt_music = {
R2.*7
\time 6/8
\repeat volta 2 {R2.*16}
R2.*7
\time 3/4
f4 f e f2. R2.*2 f4 4 4 2. R2. d4 4 4 e2.\fermata \fine}

aalt_lyrics = \lyricmode {
  da -- nos la paz
da -- nos la paz
da -- nos la paz.
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \agnus
  \relative c' {\aalt_music}
  \addlyrics {\aalt_lyrics}
>>


aten_music = {
R2.*7
\time 6/8
\repeat volta 2 {
  <e c'>2.\pp <d b'>4. <dis a'> <e gis>~ 4 r8
  <a f'>4.( <a e'>~ 4.)
  r r <gis d'> <e c'>2.
  R2.*4
  
  % <d' f>2. <c e> <gis d'>2.~ 2. <a c>4.~ 8 r r
  R2.*5
}
<e c'>2. <d b'>4. <dis a'> <e gis>~ 4 r8
  <a f'>4.( <a e'>~ 4.)
  r r <gis d'> <e c'>2.

\time 3/4
R2.*2 <c' e>4 4 <b d>4 <c e>2. c4 4 b c2. r f,4 a b c2.\fermata \fine
}

aten_lyrics = \lyricmode {
(b.f.)
"" "" "" "" "" "" "" "" "" 
"" "" "" "" 
da -- nos la paz da -- nos la paz da -- nos la paz.}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \agnus
  \relative c' {\aten_music}
  \addlyrics {\aten_lyrics}
>>


abass_music = {
R2.*7
\time 6/8
\repeat volta 2 {
  a,2.\pp g4. f e~ 4 r8
  d'4. c~ c r r b a2.
  R2.*4
  % <d a'>2. <c b'>4.(  <c a'>) <b e>2.~ 2. <a e'>4.~ 8 r r
  R2.*5
}
  a2. g4. f e~ 4 r8
  d'4. c~ c r r b a2.
\time 3/4
R2.*2 a'4 4 4 2. d,\pp d r a\p a\fermata \fine
}

abass_lyrics = \lyricmode {(b.f.)
"" "" "" "" "" "" "" "" "" 
"" "" "" "" "" "" 
da -- nos la paz la paz la paz.
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \agnus
  \relative c' {\abass_music}
  \addlyrics {\abass_lyrics}
>>

\include "utils/booksmisa.ly"

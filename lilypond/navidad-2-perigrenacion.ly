% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

%\paper { indent = 0\cm}

\header {
  title = "Navidad Nuestra"
  subtitle = "2 - La peregrinacion"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 6/8
\tempo 4. = 92
\key bes \major
}


sop_music = {
% r8 bes' a bes a g f4 es es aes8 4 fis4. g2.
\repeat volta 4 {R2.*16
r8 d'^"Times 1 & 2 only" c bes c d d4 es bes bes8 a4 4. d~ d
r8 bes a g a bes bes4 c g g8 fis4 4. bes~ bes
r8 d c b c d d4 es es f8 4 c4. d~ d
r8 bes a g a bes bes4 c c d8 4 fis,4. g~ g
r8 d'^"All times" c b c d d4 es es f8 4 c4. d~ d
r8 bes a g a bes bes4 c c d8 4 fis,4. g~ g^\markup { \bold "4×" }
}
r8 <bes d>8^"Calme" 8 8 8 8 8 8 8 <g d'>8 4 r8 <f d'>4 <a d>4 8 4. 4.\fermata \fine
}
	


sop_lyrics = \lyricmode {
  %A la hue -- lla la hue -- lla hue -- lli -- tay hue -- lla
  
  A la hue -- lla la hue -- lla Jo -- sey Ma -- ri -- a __
  Por las pam -- pas he -- la -- das car -- dos yor -- ti -- gas __
  A la hue -- lla la hue -- lla cor -- tan -- do cam -- po __
  no~hay co -- bi -- jo ni fon -- da si -- gan an -- dan -- do. __
  
  A la hue -- lla la hue -- lla Jo -- sey Ma -- ri -- a __
  con un Dios es -- con -- di -- do na -- die sa -- bi -- a. __
  
  A la hue -- lla la hue -- lla hue -- lli -- ta Jo -- sey Ma -- ri -- a.
}

sop_lyrics_b = \lyricmode {
% "" "" "" "" "" "" "" "" "" "" "" ""
Flo -- re -- ci -- ta del cam --po, cla -- vel del ai -- re __
Si nin -- gu -- no tea -- le -- ja a don -- de na -- ces __
Don -- de na -- ces flor -- ci -- ta que~es -- tas cre -- cien -- do __
Pa -- lo -- mi -- ta~a -- sus -- ta -- da, gri -- llo sin tiem po. __
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
  \addlyrics {\sop_lyrics_b}
>>


alt_music = {
%r4. r8 d es d c bes bes4 8 es4 8 d4. d d
\repeat volta 4 {R2.*16
r8 bes'^"Times 1 & 2 only" a g a bes bes4 g g g8 f4 4. f es4 d8
g4 f8 es f g g4 es es d8 4 4. 4. es4 g8
f4. 4 8 es4 g g a8 4 4. bes es,4 d8
g4 f8 es f g g4 es es d8 fis4 d4. d^"All times" es4 g8
f4. 4 8 es4 g g a8 4 4. bes es,4 d8
g4 f8 es f g g4 es es d8 fis4 d4. d~ d^\markup { \bold "4×" }
}
r8 g^"Calme" g g fis f e e e es es4 r8 d4 f4 8 e4. d\fermata \fine
}

alt_lyrics = \lyricmode {
 %   A la hue -- lla la hue -- lla hue -- lli -- tay hue -- lla
  
  A la hue -- lla la hue -- lla Jo -- sey Ma -- ri -- a 
  Por las pam -- pas pam -- pas he -- la -- das car -- dos yor -- ti -- gas
  A la hue -- lla la hue -- lla cor -- tan -- do cam -- po
  no~hay co -- bi -- jo ni __ _ _  fon -- da si -- gan an -- dan -- do. __
  
  A la hue -- lla la hue -- lla Jo -- sey Ma -- ri -- a __
  con un Dios un Dios es -- con -- di -- do na -- die sa -- bi -- a. __
  
  A la hue -- lla la hue -- lla hue -- lli -- ta Jo -- sey Ma -- ri -- a.
}

alt_lyrics_b = \lyricmode {
% "" "" "" "" "" "" "" "" "" "" "" ""
Flo -- re -- ci -- ta del cam --po, cla -- vel del ai -- re __
Si nin -- gu -- no gu -- no tea -- le -- ja a don -- de na -- ces __
Don -- de na -- ces flor -- ci -- ta que~es -- tas cre -- cien -- do __
Pa -- lo -- mi -- ta -- mi -- ta~a -- sus -- ta -- da, gri -- llo sin tiem po. __
}


alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
  \addlyrics {\alt_lyrics_b}
>>


bass_music = {
%R2. r8 g g g g g c c c c4 8 bes4. 4.
\repeat volta 4 {R2.*16
g4^"Times 1 & 2 only" 8 8 8 8 c4 4 4 f,8 4 c'4. bes g4 f8
es4. 4 8 c4 4 4 d8 4 a'4. g~ g
g4 8 8 8 8 c4 4 4 f,8 4 c'4. bes g4 f8
es4 f8 g f es c4 g' g fis8 d'4 c4. bes~ bes
g4^"All times" 8 8 8 8 c4 4 4 f,8 4 c'4. bes g4 f8
es4 f8 g f es c4 g' g fis8 d'4 c4. bes~ bes^\markup { \bold "4×" }
}
r8 g^"Calme" g g bes c d4 c~ c r8 bes4 4 8 c4. g\fermata \fine
}

bass_lyrics = \lyricmode {
 %   A la hue -- lla la hue -- lla hue -- lli -- tay hue -- lla
  
  A la hue -- lla la hue -- lla Jo -- sey Ma -- ri -- a 
  Por las pam -- pas he -- la -- das car -- dos yor -- ti -- gas __
  A la hue -- lla la hue -- lla cor -- tan -- do cam -- po
  no~hay co -- bi -- jo ni __ _ _  fon -- da si -- gan an -- dan -- do. __
  
  A la hue -- lla la hue -- lla Jo -- sey Ma -- ri -- a __
  con un Dios un Dios es -- con -- di -- do na -- die sa -- bi -- a. __
  
  A la hue -- lla la hue -- lla __  Jo -- sey Ma -- ri -- a.
}

bass_lyrics_b = \lyricmode {
% "" "" "" "" "" "" "" "" "" "" "" ""
Flo -- re -- ci -- ta del cam --po, cla -- vel del ai -- re __
Si nin -- gu -- no tea -- le -- ja a don -- de na -- ces __
Don -- de na -- ces flor -- ci -- ta que~es -- tas cre -- cien -- do __
Pa -- lo -- mi -- ta -- mi -- ta~a -- sus -- ta -- da, gri -- llo sin tiem po. __
}


bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
  \addlyrics {\bass_lyrics_b}  
>>


\include "utils/books.ly"

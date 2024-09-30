% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Navidad Nuestra"
  subtitle = "6 - La Huida"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 16
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 3/4
\tempo 4 = 72
\key g \major
}


sop_music = {
  r2 <b' e>4 
  \repeat volta 2 {
  <b d>2 <b e>4
  <b d>2 <b e>4 <a d> <b d> <a cis> 
  b2 <b e>4 b2 <b e>4 b2 <b e>4 <a d> <b d> <a cis> b2 r4 \break
  <e g>4. 8 <d fis>4 <c e>4. <b d>8 <a cis>4
  <g b>4 4 <fis a> <e g>2 r4
  <e' g>4. 8 <d fis>4 <c e>4. <b d>8 <a cis>4
  <g b>4 4 <fis a> <e g>2 r4 \break
  <c' e>4. <b dis>8 <c e>4 <d fis>4. <c e>8 <b dis>4 <c e>2.~ 4 r r \break
  <e g>4. <dis fis>8 <e g>4 <fis a>4. <e g>8 <dis fis>4 <e g>2 r4
  <e g>4. 8 <d fis>4 <c e>4. <b d>8 <a cis>4 <g b>4 4  <fis a> \break
  <e g>2 <b' e>4}
  \repeat volta 2 {
  <b d>2 <b e>4 <b d>2 <b e>4  <a d> <b e> <a cis> b2 <b e>4
  <b d>2 <b e>4 <b d>2 <b e>4  <a d> <b d> <a cis> 
  \alternative {
  \volta 1 {b2 <b e>4}
  \volta 2 {b2.\fermata\fine}
  }
  }
}
	


sop_lyrics = \lyricmode {
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  
  Si no te~a -- pu -- ras los van a pi -- llar...
  lar -- go~el ca -- mi -- no, lar -- go~el sa -- li -- tral.
  
  Y~a to -- can a de -- go jjar! __

  Y~a~es -- ta san -- gran -- do~el pu -- nal!
  Si no te~a -- pu -- ras los van a pi -- llar.

  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!

  Va
  rà!
}

sop_lyrics_b = \lyricmode {
\repeat unfold 18 ""
Ni -- ño bo -- ni -- to no llo -- ris mi~a -- mor.
ya -- lle -- ga -- re -- mos a tie -- rra -- me -- jor.

Duer -- me -- te ya no llo -- ris, __
cu -- na~en mis bra -- zos te~ha -- ré.
Bom -- bos -- le güe -- ros en mi co -- ra -- zon.
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
  r2 <e g>4
  \repeat volta 2 {
  <d fis>2 <e g>4 <d fis>2 <e g>4 <d fis> <fis a> <cis e>
  <d g>2 <e g>4 <d fis>2 <e g>4 <d fis>2 <e g>4 <d fis> <fis a> <cis e> <d g>2 r4
  R2.*8 <e g>4. <dis fis>8 <e g>4 <fis a>4. <e a>8 <dis fis>4 < e g>2.~ 4 r r
  R2.*6 r4 r <e g> }
  \repeat volta 2 {
  <d fis>2 <e g>4 <d fis>2 <e g>4 <d fis> <fis a> <cis e> <d g>2 <e g>4
  <d fis>2 <e g>4 <d fis>2 <e g>4 <d fis> <fis a> <cis e> 
  \alternative {
  \volta 1 {<d g>2 4}
  \volta 2 {2.\fermata\fine}}}
}

alt_lyrics = \lyricmode {
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  
  Y~a to -- can a de -- go jjar! __
  
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!

  Va
  rà!
}


alt_lyrics_b = \lyricmode {
\repeat unfold 18 ""

Duer -- me -- te ya no llo -- ris, __
}


alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
  \addlyrics {\alt_lyrics_b}
>>


ten_music = {
r2 a'4 
\repeat volta 2 {
b2 a4 b2 a4 b b a b2 
a4 b2 a4 b2 a4 b b a b2 r4
R2.*8 c4. b8 c4 d4. c8 b4 c2.~ 4 r r
R2.*6 r4 r a }
\repeat volta 2 {
b2 a4 b2 a4 b b a b2 a4 b2 a4 b2 a4 b b a
\alternative { \volta 1 {b2 a4 }
\volta 2 {b2.\fermata\fine}}}
}

ten_lyrics = \lyricmode {
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  
  Y~a to -- can a de -- go jjar! __
  
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!

  Va
  rà!
}

ten_lyrics_b = \lyricmode {
\repeat unfold 18 ""

Duer -- me -- te ya no llo -- ris, __
}


ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
    \addlyrics {\ten_lyrics_b}
>>


bass_music = {
r2 e,4
\repeat volta 2 {
a2 e4 a2 e4 a a e e2
e4 a2 e4 a2 e4 a a e e2 r4
R2.*8 g4. fis8 g4 a4. 8 fis4 g2.~ 4 r r
R2.*6 r4 r e
}
\repeat volta 2 {
a2 e4 a2 e4 a a e e2 4 a2 e4 a2 e4 a a e
\alternative { \volta 1 {a2 e4}
\volta 2 {a2.\fermata\fine}}}
}

bass_lyrics = \lyricmode {
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  
  Y~a to -- can a de -- go jjar! __
  
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!
  Va -- mos! Va -- mos! Bu -- rri -- to~a -- pu -- rà!

  Va
  rà!
}

bass_lyrics_b = \lyricmode {
\repeat unfold 18 ""

Duer -- me -- te ya no llo -- ris, __
}



bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
  \addlyrics {\bass_lyrics_b}
>>


\include "utils/booksq.ly"

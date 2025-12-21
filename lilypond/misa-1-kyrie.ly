% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

%\paper { indent = 0\cm}

\header {
  title = "Misa Criolla"
  subtitle = "1 - Kyrie"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 18
individual_size = 20

\include "utils/macros.ly"


%%%%%%%%%%%%%%%%%
% Kyrie
%%%%%%%%%%%%%%%%%

kyrie = {
\compressEmptyMeasures
\time 3/4
\tempo 4 = 69
\key a \minor
}


lead_music = {R2.*2
\repeat segno 2{R2.*2 R2.*6 r4 r <c' e>
<c e>4. <b d>8 <a c>4 <g b>4. <f a>8 <b, g'>4 <c e>4 4 r
r r a'4 4. 8 4 <e' g>4. <f a>8 <e g>4 <d f>4 4 r
r r f f4. a,8 4 4. 8 gis4 a4 4 r r2.*7
\volta 2 \fine
\volta 1 {\key a \major r2. e'16 a,8.~ 2
r4 a8 8 8 e'~ 8. e,16 8 a~ a4~ 4. r8 r4
r2. r2. r2. a16 e'8.~ 2 
r4 e8 e, e e'~ e8. e,16 8 a8~ 4~ 4. r8 r4
r2. <gis e>8 <fis d>8 8 8 <cis' e>4~ 4. r8 <b d> <a cis>
<gis b>2. a
}

}
}

lead_lyrics = \lyricmode {
  Se -- ñor, ten -- pie -- dad de no -- so -- tros
  Se -- ñor, ten -- pie -- dad de no -- so -- tros
  Se -- ñor, ten -- pie -- dad de no -- so -- tros
  
  Cris -- to __ ten pie -- dad de __ no -- so -- tros __
  Cris -- to __ ten pie -- dad de __ no -- so -- tros __
  Cris -- to, ten pie -- dad__ de no -- so -- tros.
}

lead = \new Staff \with {instrumentName="Lead"
  shortInstrumentName ="L."} <<
  \soprano_style
  \kyrie
  \relative c' {\lead_music}
  \addlyrics {\lead_lyrics}
>>


sop_music = {R2.*2
\repeat segno 2{R2.*2
a'2 gis4 a2 g4 f2. f e2 a4 e2.~ 2 r4
a4. gis8 a4 g2 4 2 r4 r2. a a a2 r4 r2.
f2 4 a2 gis4 a2 gis4 a2 g4 f2. 2 4 e4. 8 a4 e2.~ e e\fermata \break
\volta 2 \fine
\volta 1 {\key a \major e~_"(b.f.)" e~ e~ e a4. 8 4
4. r8 r4 r4 r8 gis4. a2. a~_"(b.f.)" a~ a a4. 8 4 2. 2.~ 2. fis e}
}
}	


sop_lyrics = \lyricmode {(b.f.) "" "" "" "" 
"" "" "" ""  "" "" "" ""  "" "" "" "" "" "" "" "" "" 
Ten pie -- dad Se -- ñor, ten pie -- dad de no -- so __ tros
"" Ten, ten pie -- dad pie -- dad "" Ten, ten pie -- dad
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \kyrie
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
>>


alt_music = {R2.*2
\repeat segno 2{R2.*2
  e2 4 c2 e4 d2. c c2 e4 d2.~ 2 r4
  e2 4 d2 4 c2 r4 r2. e g f2 r4 r2.
  c2 4 e2 4 2 4 c2 e4 d2. c2 4 4. 8 e4 d2.~ 2.
  cis\fermata
\volta 2 \fine
\volta 1 {\key a \major cis~_"(b.f.)" cis~ cis~ cis cis4. 8 4
4. r8 r4 r4 r8 d4. cis2. cis~_"(b.f.)" cis~ cis cis4. 8 d4 cis2. 
fis2.~ 2. d cis}
}}

alt_lyrics = \lyricmode {(b.f.) "" "" "" "" 
"" "" "" ""  "" "" "" ""  "" "" "" "" "" "" "" "" 
Ten pie -- dad Se -- ñor, ten pie -- dad de no -- so __ tros
"" Ten, ten pie -- dad pie -- dad "" Ten, ten pie -- dad}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="S."} <<
  \alto_style
  \kyrie
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
>>


ten_music = {R2.*2
\repeat segno 2{R2.*2
c'2 e,4 e'2 a,4 2. 2 c4( a2) c4( a2.) gis2 r4
c4. b8 a4 b2 f4 e2 r4 r2. g e' d2 r4 r2.
a2 4 c2 b4 c2 e,4 e'2 a,4 2. 2 c4 a4. 8 c4 a2.( gis) 
e\fermata
\volta 2 \fine
\volta 1 {\key a \major e~_"(b.f.)" e~ e~ e e4. 8 fis4
e4. r8 r4 r4 r8 fis4. e2. e~_"(b.f.)" e~ e e4. 8 fis4 e2. a2. b2. gis e}

}}

ten_lyrics = \lyricmode {(b.f.)  "" "" "" "" 
"" "" "" ""  "" "" "" ""  "" "" "" "" "" "" "" "" "" 
Ten pie -- dad Se -- ñor, ten pie -- dad de no -- so __ tros
"" Ten, ten pie -- dad pie -- dad "" Ten, ten pie -- dad}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \kyrie
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
>>


bass_music = {R2.*2
\repeat segno 2{R2.*2
a,2 b4 c2 cis4 d2. dis e e~ e2 r4
a,4. b8 c4 d2 g,4 c2 r4 r2. cis cis' d2 r4 r2.
dis,2 4 e2 4 a,2 b4 c2 cis4 d2. dis2 4 e4. 8 4 e2.~ e
a,\fermata
\volta 2 \fine
\volta 1 {\key a \major a~_"(b.f.)" a~ a~ a a4. 8 4
4. r8 r4 r4 r8 e'4. a,2. a~_"(b.f.)" a~ a a4. 8 4 2. d2. e2. e a,}

}}

bass_lyrics = \lyricmode {(b.f.) "" "" "" "" 
"" "" ""  "" "" "" ""  "" "" "" "" "" "" "" "" "" 
Ten pie -- dad Se -- ñor, ten pie -- dad de no -- so __ tros
"" Ten, ten pie -- dad pie -- dad "" Ten, ten pie -- dad}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \kyrie
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
>>


\include "utils/booksmisa.ly"

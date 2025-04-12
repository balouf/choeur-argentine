% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Tonada de la Quiaca"
  subtitle = ""
  composer = "Nestor Zadoff"
  tagline = ""

}

conductor_size = 18
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 2/4 
\tempo "Andante" 4 = 84
\key f \major
}


sop_music = {
\set Score.dalSegnoTextFormatter = #format-dal-segno-text-brief
 \repeat segno 2 {
a'4(\p f a2) \breathe a4( f4 2) \breathe
a4( f a2) \breathe a4( f4 2) \breathe
a4^\mp g f g a c a2 \breathe
a4 g f c' f, f 

\alternative {
\volta 1 {f2 \break
f16^\mf 8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f f4
f16 8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f f4~2~2~2\>~2 r\!
r8 g\p a4~ a r r8 a g4~4 r
r8 gis a4~ a r r8 c f,4~4 r
f16\mf 8 d16 c8 a' f f f4\>~2
a4(\p f a2) a4( f4 2) \breathe
a4\mp g f c' f, f f2

f16^\mf^"Ritmico" f8 d16 c8 a' f c c'4
a\p r8 g r b c4 r4 c b a r c f,8 8-.8-. r
r2*3 
f16^\mf f8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f f4
f16 f8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f f4
f16 8 d16 c8 a' f\> f f4~2\fermata\! \break
}
\volta 2 \volta #'() {\section
        \sectionLabel "Coda"}}
 }
f2~\>2~2~ \repeat volta 2 {2~2\pp}
}


sop_lyrics = \lyricmode {
  U __ U __   U __ U __
  Lai ra ra ra lai ra ra,
  Lai ra ra ra lai ra ra
  
  Del cam -- po ven -- go lle -- ga -- do
  brin -- can -- do so -- bre las flo -- res,
  co -- mo soy de Pam -- pi -- chue -- la
  ven -- go cur -- ti -- da de so -- les __
  cam -- po __ vo -- lar __ li -- bre __ bai -- lar __
  y a -- le -- gre pa -- ra bai -- lar __
  U __ U __ lai ra ra ra lai ra ra
  
  En es -- ta ca -- lle se -- ño -- ras
  can -- te muy bien lai ra ra hay un cla -- vel
  A -- le -- gre mo -- ci -- to~i si -- o 
  a -- le -- gre vie -- jo hei mo -- rir,
  cuan -- do~oi -- go so -- nar la ca -- ja
  me a -- ma -- nez -- co sin dor -- mir,
  me a -- ma -- nez -- co sin dor -- mir __
}


sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {
    \dynamicUp
    \sop_music}
  \addlyrics {\sop_lyrics}
>>

alt_music = {
 \set Score.dalSegnoTextFormatter = #format-dal-segno-text-brief
 \repeat segno 2 {

f2(\p e) \breathe d( des) \breathe f( f) \breathe e( c) \breathe
f4^\mp e d f e d f2 \breathe
f4 e d f bes, e 

\alternative {
\volta 1 {
c2

f^\p( e d des) f( e d c)
c16\mp 8 f16 e8 d e d c4~2\>~ 2 
4\p f r8 8 4 e d r8 c b4 4 c r8 e8 4
4 f r8 e c4 f16 8 d16 c8 a' f e d c b4 c~2
f2(\p e) d( des) \breathe f4 e d f bes, e c2
\break
c4\p r8 b r c f4
f16\mp 8 d16 c8 a' f f f4
c\p d g2 c,4 e f8 8-. 8-. r r2*2
f4\p e8 g d4 e f e8 g bes,2 b4 c d e f g c,2
f16 8 d16 c8 a' f f f4
f16 8 d16 c8 a' f f f4\fermata
}
\volta 2 \volta #'() {\section
        \sectionLabel "Coda"}
 }
}
c2~\>2~2~ \repeat volta 2 {2~2\pp}
}

alt_lyrics = \lyricmode {
  U __ U __ U __ U __
  Lai ra ra ra lai ra ra,
  Lai ra ra ra lai ra ra
  U __ U __
  Ven -- go cur -- ti -- da de so -- les __
  a -- hí cam -- po pa -- ra vo -- lar ri -- o li -- bre
  pa -- ra bai -- lar y a -- le -- gre pa -- ra 
  bai -- lar, bai -- lar __ _
  U __ U __ lai ra ra ra lai ra ra
  ca -- lle ño -- ras to -- do el mun -- do can -- te bien,
  lai ra ra si hay un cla -- vel
  Lai ra ra lai ra lai ra ra ra lai ra ra ra ra ra ra
  me a -- ma -- nez -- co sin dor -- mir,
  me a -- ma -- nez -- co sin dor -- mir,
  
}


alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\dynamicUp
  \alt_music}
  \addlyrics {\alt_lyrics}
>>


bass_music = {
\set Score.dalSegnoTextFormatter = #format-dal-segno-text-brief
\repeat segno 2 {
f,2(\p f) \breathe f( f) \breathe d( des) \breathe c( f) \breathe
f^\mp g f des \breathe c g' c, 
\alternative {
  \volta 1 {
f
s2*12 \break
f16^\mf 8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f4.
f16 8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f f4~2~2~2\>~2 
f2\p( 2) 2( 2) \breathe
c g' c, f
a4\p r8 g r8 a d4 c r8 b r d c4
f,16^\mf f8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f-. f-. r
r2*2 
f16^\mf f8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f f4
f16 f8 d16 c8 a' f c c'4
f,16 8 d16 c8 a' f f f4~2~2~2~2\fermata}
\volta 2 \volta #'() {\section
        \sectionLabel "Coda"}
 }
}
f2~\>2~2~ \repeat volta 2 {2~2\pp}
}

bass_lyrics = \lyricmode {
  U __ U __ U __ U __
  Lai ra lai ra Lai ra lai ra
  
  Las pa -- lo -- mi -- tas del cam -- po
  na -- cie -- ron pa -- ra vo -- lar,
  mi co -- ra -- zón na -- ció li -- bre
  y a -- le -- gre pa -- ra bai -- lar __
  U __ U __ lai ra lai ra
  ca -- lle ño -- ras can -- te muy bien,
  Que~a la~en tra -- da~hay u -- na ro -- sa
  y~a la sa -- li -- da un cla -- vel
  
  A -- le -- gre mo -- ci -- to~i si -- o 
  a -- le -- gre vie -- jo hei mo -- rir,
  cuan -- do~oi -- go so -- nar la ca -- ja
  me a -- ma -- nez -- co sin dor -- mir,
  me a -- ma -- nez -- co sin dor -- mir __
}


bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\dynamicUp
  \bass_music}
  \addlyrics {\bass_lyrics}
>>

hands = \drummode {hh8 16 16 8 16 16 8 8 4}
feets = \drummode {toml4 4 8 8 4}
both = \drummode {<< \hands \\ \feets >>}

perc = \new DrumStaff \with {instrumentName="Perc." shortInstrumentName ="P."} <<
   {
\set Score.dalSegnoTextFormatter = #format-dal-segno-text-brief
 \repeat segno 2 {
    \repeat unfold 4 \feets
    \repeat unfold 3 \both
    \drummode {<< {hh8 16 16 8 16 16} \\ {toml4 4} >>}
    
\alternative{
  \volta 1 {
    \drummode {<< {hh8 8 4} \\ {toml8 8 4} >>}
    s2*10 \both
    s2*10 \hands
    \feets \feets \both \both
    s2*8 \both
    s2*12
  }
    \volta 2 \volta #'() {\section
        \sectionLabel "Coda"}
}
  }
   \drummode {<< {hh8 8 4} \\ {toml8 8 4} >>}
  \both \repeat volta 2 \both
}>>


%\include "utils/booksq.ly"

#(set-global-staff-size conductor_size)
\book {
  \score {
\layout {
  \context {
    \DrumStaff
    \remove "Keep_alive_together_engraver" % Allow DrumStaff to be removed if empty
    \override VerticalAxisGroup.remove-empty = ##t
  }
 \context {
    \Staff
    \RemoveEmptyStaves
  }
}
       <<
    \new ChoirStaff
    <<
      \sop
      \alt
      \bass
    >>
    \perc
    >>

  }
  \score {
    \unfoldRepeats
    <<
%      \lead
      \sop
      \alt
      \bass
      \perc
    >>
    \midi {}
  }
}

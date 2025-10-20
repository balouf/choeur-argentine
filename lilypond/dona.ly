% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.24.4"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Doña Ubensa"
  subtitle = ""
  composer = "Huayno"
  tagline = ""

}

conductor_size = 16
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 2/4
\tempo  4 = 72
\key es \major
}


sop_music = {
  \repeat volta 2 {
  es4 r r2 es4 r r2
  r2*8
  g16 bes8 16 8. g16 8 es8 4
  16 8 16 g8. bes,16 8 8 4
  g'16 8 es16 g8. es16 g8 bes8 4
  g16 8 es16 g8. bes,16 8 8 4
  bes'16 es8 16 8 c16 16 8 bes8 4
  g16 bes8 16 8 g16 g~g es g8 4
  bes16 8 g16 bes8 g16 bes~16 16 es8 4
  c8 bes16 16 8 g16 16 8 es8 4
  es'16 8 16 16 8 16 8 8 f4
  es8 16 16 8. 16 f8. es16 4
  bes16 8 g16 bes8 g16 bes~16 16 es8 4
  \alternative {
  {\time 3/4 c16 bes8 16 8 g16 g~g es es8}
  {\time 2/4 c'16 bes8 16 8 g16 g~}
  }
  }
  g es16 8 4
  \repeat volta 2 {
  bes'16 es8 16 8. c16 8 bes8 4
  g16 bes8 16 8. g16~g es g8 4
  bes16 8 g16 bes8 g16 bes~16 16 es8 4
  c8 bes16 16 8 g16 16 8 es8 4
  }
 c'8 bes16 16 8 g16 16 8 es8 4
 \time 1/4 c'8 bes16 16 
 \time 3/4 2^\f 4 c4. 8 es4 \time 2/4 2~2~8 r r4 \fine
 }


sop_lyrics = \lyricmode {
dum dum 
  Le doy ven -- ta -- ja~a los vien -- tos
  por -- que no pue -- do vo -- lar, ""
  has -- ta que~a -- ga -- rro mi ca -- ja,
  y me pon -- go~a ba -- gua -- le -- ar.
  
  Mi ra -- za re -- za qué pe -- di -- rá?
  A -- llá~en el mon -- te de ca -- ri dad.
  No tie -- ne tiem -- po ya no da más,
  re -- za que re -- za por -- qué se -- rá?
  
  A -- yes so -- no -- ros de pe -- dre -- gal
  pie -- dra por pie -- dra~el vien -- to va
  bo -- rra -- do pe -- nas a mi do -- lor,
  si -- len -- cio pu -- ro~es mi co -- ra
  si -- len -- cio pu -- ro~es mi co -- ra -- zón.
  
  la rai la lai la lai ra la
  la rai la lai la la rai la
  la rai la lai la lai la rai la
  lai ra la lai ra la lai rai la

  lai ra la lai ra la lai rai la
  la ra la lai la lai la la la

}

sptwo = \lyricmode {
\markup \italic (-zón.) "" 
No sé si~ha -- brá o -- tro mun -- do
don -- de las al -- mas sus -- pi -- ran
yo vi -- vo so -- bre la tie -- rra
tra -- ba -- jan -- do to -- do~el di -- a.
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {
    \dynamicUp
    \sop_music}
  \addlyrics {\sop_lyrics}
  \addlyrics {\sptwo}
>>

alt_music = {  
  \repeat volta 2 {
\repeat unfold 10 {es4 4 8 8 4}
es16 g8 16 8 es16 16 8 8 4
16 8 16 8 16 16~16 bes es8 4
g16 8 es16 g8 es16 g~g g g8 aes4
g f es es
es16 8 16 f16 8 16 g8 bes aes4
aes8 16 16 8. 16 f8 fis g4
g16 8 es16 g8 es16 g~g g g8 aes4
 \alternative {
  {\time 3/4 g f es}
  {\time 2/4 g f}
  }
 }
 es es
\repeat volta 2 {
es16 g8 16 8. es16 8 8 4
16 8 16 8. 16~16 bes es8 4
g16 8 es16 g8 es16 g~g g g8 aes4
g8 16 16 f8 16 16 es8 8 4
}
g8 16 16 f8 16 16 es8 8 4
\time 1/4 g8 16 16 \time 3/4 f2\f g4 aes4. g8 aes4
\time 2/4 g2~g~8 r r4 \fine
}

alt_lyrics = \lyricmode {
dum dum dum dum dum \markup \italic (simile)
\repeat unfold 44 ""
  Mi ra -- za re -- za qué pe -- di -- rá?
  A -- llá~en el mon -- te de ca -- ri dad.
  No tie -- ne tiem -- po ya no da más,
  du ru ru ru
  
  A -- yes so -- no -- ros de pe -- dre -- gal
  pie -- dra por pie -- dra~el vien -- to va
  bo -- rra -- do pe -- nas a mi do -- lor,
  du ru ru 
  ru ru ru ru
  
  la rai la lai la lai ra la
  la rai la lai la la rai la
  la rai la lai la lai la rai la
  lai ra la lai ra la lai rai la

  lai ra la lai ra la lai rai la
  la ra la lai la lai la la la

}


alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\dynamicUp
  \alt_music}
  \addlyrics {\alt_lyrics}
>>

ten_music = {
  \repeat volta 2 {
  r2*4 
  \repeat unfold 2 {
  bes'16 es8 16 8. c16 8 bes8 4
  g16 8 16 bes8. es,16 8 8 4
  bes'16 8 g16 bes8. g16 bes8 es8 4
  c16 8 bes16 c8. es,16 8 8 4
  }
  g16 bes8 16 c4 fis, g16 8 bes16
  g4 aes16 8 16 8 8 bes16 8 c16
  es4 d es8 d c4 es4 d c bes
  es16 8 16 des16 8 16 8 8 c4
  c8 16 16 8. 16 4 bes16 8 c16 
  es4 d es8 d c4
 \alternative {
  {\time 3/4 es d c}
  {\time 2/4 es d}
  }
}
c bes
\repeat volta 2 {
g16 bes8 16 c4 fis, g16 8 bes16 
g4 aes16 8 16 8 8 bes16 8 c16 
es4 d es8 d c4
es8 16 16 d8 16 16 c8 8 bes4
}
es8 16 16 d8 16 16 c8 8 bes4
\time 1/4 es8 16 16 \time 3/4 d2\f es4 4. 8 f4
\time 2/4 es2~2~8 r r4 \fine
}

ten_lyrics = \lyricmode {
  An -- do llo -- ran -- do pa'a -- den -- tro
  aun -- que me ri -- a pa'a -- jue -- ra.
  A -- sí ten -- go yo que vi -- vir,
  es -- pe -- ran do~a que me mue -- ra.
  
  Le doy ven -- ta -- ja~a los vien -- tos
  por -- que no pue -- do vo -- lar, ""
  has -- ta que~a -- ga -- rro mi ca -- ja,
  y me pon -- go~a ba -- gua -- le -- ar.

  Mi ra -- za re -- za qué pe -- di -- rá?
  A -- llá~en el mon -- te de ca -- ri dad,
  ay, no da más,
  du ru ru ru
  
  A -- yes so -- no -- ros de pe -- dre -- gal
  pie -- dra por pie -- dra~el vien -- to~el vien -- to 
  va ay mi do -- lor,
  du ru ru 
  ru ru ru ru
  
  la rai la lai la la rai la 
  la la rai la lai la la rai la 
  la la la lai la
  lai ra la lai ra la lai rai la

  lai ra la lai ra la lai rai la
  la ra la lai la lai la la la

}

tentwo = \lyricmode {
  Me per -- sig -- no por si~a -- ca -- so
  no va -- ya que Dios e -- xis -- ta
  y me lle -- ve pa'l In -- fier -- no
  con -- to -- das mis o -- ve -- ji -- tas.

No sé si~ha -- brá o -- tro mun -- do
don -- de las al -- mas sus -- pi -- ran
yo vi -- vo so -- bre la tie -- rra
tra -- ba -- jan -- do to -- do~el di -- a.
}


ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \alto_style
  \armure
  \relative c' {\dynamicUp
  \ten_music}
  \addlyrics {\ten_lyrics}
    \addlyrics {\tentwo}
>>


bass_music = {
\repeat volta 2 {
\repeat unfold 10 {<es, bes'>4 4 8 8 4}
es16 8 16 aes,4 a bes16 8 16 c4 f16 8 16 bes,8 8 16 es8 16
4 g c,8 bes aes4 aes' g f es r2
es16 f8 g16 aes8 8 16 8 16 4 a16 8 16 bes4 
es, g c,8 bes aes4
 \alternative {
  {\time 3/4 aes'g f }
  {\time 2/4 aes g}
  }
}
f es
\repeat volta 2 {
es16 8 16 aes,4 a bes16 8 16
c4 f16 8 16 bes,8 8 16 es8 16 4 g c,8 bes aes4
aes'8 16 16 g8 16 16 f8 8 es4
}
aes8 16 16 g8 16 16 f8 8 es4
\time 1/4 aes8 16 16 \time 3/4 g2\f c,4 f4. c'8 bes4
\time 2/4 <bes es,>2~2~8 r r4 \fine
}

bass_lyrics = \lyricmode {
dum dum dum dum dum \markup \italic (simile)
\repeat unfold 44 ""
  Mi ra -- za re -- za qué pe -- di -- rá?
  A -- llá~en el mon -- te de ca -- ri dad,
  ay, no da más,
  du ru ru ru
  
  A -- yes so -- no -- ros de pe -- dre -- gal
  el vien -- to va va ay mi do -- lor,
  du ru ru 
  ru ru ru ru
  
  la rai la lai la la rai la 
  la la rai la lai la la rai la 
  la la la lai la
  lai ra la lai ra la lai rai la

  lai ra la lai ra la lai rai la
  la ra la lai la lai la la la


}


bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\dynamicUp
  \bass_music}
  \addlyrics {\bass_lyrics}
>>


\include "utils/booksq.ly"

% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Navidad Nuestra"
  subtitle = "5 - Los Reyes Magos"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 2/4
\tempo 4 = 72
\key c \major
}


sop_music = {
r4 r16 e e' d c8. d16 e d c b
a4 r16 d, d' c b8. c16 d c b a
g4 r16 e c' b c4 r16 a a' g
f4 r16 a, f' d e8 c16 e d8 c16 b c4 r \break
\repeat volta 2 {
r16 e, e' d c8. d16 e d c b a4
r16 d, d' c b8. c16 d c b a g4
r16 e c' b c4 r16 a a' g f8 16 f
e8 c16 e d8 c16 b c4 r
\alternative {
\volta 2 \fine
\volta 1 {b8 16 c d8 16 c d c b c d4~
16 c b c d g, g' f e4 r
b16 a gis a b a gis a b4 r16 a gis a b8. a16 gis e e' d c4 r}
}
}
}
	


sop_lyrics = \lyricmode {
  Lle -- ga -- ron ya, los Re -- yes y~e -- ran tres
  Mel -- chor, Gas -- par y~el ne -- gro Bal -- ta -- zar
  a -- rro -- pe~y miel le lle -- va -- ran
  y~un pon -- cho blan -- co de~al -- pa -- ca re -- al.
  
  La ra la ra la ra la ra la ra
  La ra la ra la ra la ra la ra
  a -- rro -- pe~y miel le lle -- va -- ran
  pon -- cho blan -- co de~al -- pa -- ca re -- al.

  La la ra la la ra la la ra la ra __
  la la ra la la ra la ra
  to -- dos los re -- ga -- los de -- ja -- ran
  pa -- ra ju -- gar ma -- ña -- na~al des -- per -- tar.
}

sop_lyrics_b = \lyricmode {
  \repeat unfold 58 ""
  y fue des -- pues
  que son -- ri -- o me -- dia no -- che el sol re -- lum -- bro.
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
r4 r16 e c' b a8. b16 c b a g
f4 r16 d b'a g8. a16 b a g f e4
r16 e a gis a4 r16 a f'e d4
r16 a d c c8 a16 c b8 a16 gis a4 r
\repeat volta 2 {r16 e c' b a8. b16 c b a g f4
r16 d b' a g8. a16 b a g f e4 r16 e a gis a4
r16 a f' e d8 gis,16 16 a8 16 16 8 16 gis a4 r
\alternative {
\volta 2 \fine
\volta 1 {
<d, g>8 16 <e a> <f b>8 16 <e a> <f b> <e a> <d g> <e a> <f b>4~
16 <e a> <d g> <e a> <f b> <d g> <g e'> <f d'> <e c'>4 r
e8 16 16 8 16 16 8 16 16 8 16 16 8 16 16 8 16 16 4 r
}
}
}
}

alt_lyrics = \lyricmode {
  Lle -- ga -- ron ya, los Re -- yes y~e -- ran tres
  Mel -- chor, Gas -- par y~el ne -- gro Bal -- ta -- zar
  a -- rro -- pe~y miel le lle -- va -- ran
  y~un pon -- cho blan -- co de~al -- pa -- ca re -- al.

  La ra la ra la ra la ra la ra
  La ra la ra la ra la ra la ra
  a -- rro -- pe~y miel le lle -- va -- ran
  pon -- cho blan -- co de~al -- pa -- ca re -- al.

  La la ra la la ra la la ra la ra __
  la la ra la la ra la ra
  la la ra la la ra la la ra la la ra la la ra la la ra la

}


alt_lyrics_b = \lyricmode {
  \repeat unfold 58 ""
  y fue des -- pues
  que son -- ri -- o me -- dia no -- che el sol re -- lum -- bro.
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
r2 r16 e e' d c8. d16 e d c b a4
r16 d, d' c b8. c16 d c b a g8 r
r16 e c' b c8 r r16 a a' g f8 16 d
e8 c16 e d8 c16 b c4 r16 e, e' d
\repeat volta 2 { c8. d16 e d c b a4 r16 d, d' c
b8. c16 d c b a g4 r16 e c' b c4 r16 a a' g f4 r8 f16 f
e8 16 16 8 16 16 4 r
\alternative {
\volta 2 \fine 
\volta 1 {d16 c b c d c b c d4 r16 c b c d8. c16 b g g' f e4 r
d16 c b c d c b c d4 r16 c b c d8. c16 b gis c b a4 r16 e e'd}
}
}
}
ten_lyrics = \lyricmode {
  Lle -- ga -- ron ya, los Re -- yes y~e -- ran tres
  Mel -- chor, Gas -- par y~el ne -- gro Bal -- ta -- zar
  a -- rro -- pe~y miel le lle -- va -- ran
  pon -- cho blan -- co de~al -- pa -- ca re -- al.
  
  Lle -- ga -- ron 
  ya, los Re -- yes y~e -- ran tres
  Mel -- chor, Gas -- par y~el Ne -- gro Bal -- ta -- zar
  a -- rro -- pe~y miel le lle -- va -- ran
  pon -- cho blan -- co de~al -- pa -- ca re -- al.
  
  Chan -- gos y chi -- ni -- tas duer -- man -- se
  que y~a Mel -- chor, Gas -- par y Bal -- ta -- zar
  to -- dos los re -- ga -- los de -- ja -- ran
  pa -- ra ju -- gar ma -- ña -- na~al des -- per -- tar.
  El ni -- no
}

ten_lyrics_b = \lyricmode {
\repeat unfold 40 {""}
Dios muy bien lo~a -- gra -- de -- cio
co -- mio la miel y~el pon -- cho lo~a -- bri -- go
y fue des -- pues que son -- ri -- o
me -- dia no -- che el sol re -- lum -- bro.
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
r2 r16 e, c' b a8. b16 c b a g f4
r16 d b' a g8. a16 b a g f e8 r
r16 e a gis a8 r r16 a f' e d8 16 b
c8 a16 c b8 a16 gis a4 r
\repeat volta 2 {R2*4
r16 e a gis a4 r16 a f' e d8 16 16 c8 a16 c b8 16 16 a4 r
\alternative {
\volta 2 \fine
\volta 1 {g8 16 16 8 g16 g g g g g g 4~ 16 g g g g b e d c4 r
e,8 16 16 8 16 16 8 16 16 8 16 16 8 16 16 8 16 16 a4 r}
}
}
}

bass_lyrics = \lyricmode {
  Lle -- ga -- ron ya, los Re -- yes y~e -- ran tres
  Mel -- chor, Gas -- par y~el ne -- gro Bal -- ta -- zar
  a -- rro -- pe~y miel le lle -- va -- ran
  pon -- cho blan -- co de~al -- pa -- ca re -- al.
  
  a -- rro -- pe~y miel le lle -- va -- ran
  pon -- cho blan -- co de~al -- pa -- ca re -- al.
  La la ra la la ra la la ra la ra __
  la la ra la la ra la ra
  la la ra la la ra  la la ra  la la ra  la la ra  la la ra  la

}

bass_lyrics_b = \lyricmode {
  \repeat unfold 37 ""
  y fue des -- pues
  que son -- ri -- o me -- dia no -- che el sol re -- lum -- bro.
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

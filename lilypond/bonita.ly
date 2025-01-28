% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Bonita rama de sauce"
  composer = "Carlos Guastavino"
  tagline = ""

}

conductor_size = 16
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 6/8
\tempo 4. = 60
\key d \major
}


sop_music = {
 \repeat segno 2 {
  \partial 8 a'8^\p
  fis4 8 8. g16 a8
  b4 8 d8 8 8 d4 cis b a4.~4 r8
  fis8. 16 8 8 g a
  a4 b a8 g fis4 8 e4 d8 a'4.~8 r
  
  a8^\f fis4 8 8. g16 a8 bes4 8 r4. r
  d8 8 8 8. cis16 b8 a r a8
  4 8 8. g16 a8 4 b8 8 a g fis4^\dim d e d4.~8\! r4
  r2. r4. r4 g8 4^"rit." fis8 b g fis
  b,4.~4 r8 
  b^"a tempo" e fis g a b d4 b8 8 a g fis4 e b'
  a2.~a~8 r fis^\mf a4.~2.~8 r fis b( a4~2.)
  a8 8 8 8 g fis a4 g4 8 8 fis4 8 e4 8 d r
  fis^\p a4.~2.~8 r fis b( a4~2.)^"rit."
  
  a8 8 8 8 d b a4 g4 8 8 fis4 8 e4 8 d4.~8\fermata r
 }  
}
	


sop_lyrics = \lyricmode {
Bo -- ni -- ta ra -- ma de sau -- ce,
bo -- ni -- ta ra -- ma d~a -- mor, __
nun -- ca flo -- re -- ció, que siem -- pre
se que -- dó di -- cien -- do~a -- diós. __

El ri -- o pa -- sa~y la pei -- na,
el ri -- o la ju -- ra~a -- mar,
la ra -- ma le da sus tren -- zas,
el ri -- o mien -- te~y __ se va. __

El ta -- llo le~ha -- ce cim -- brar, __
to -- da la ra -- mi -- ta can -- ta,
el vien -- to mien -- te~y __ se va. __

Se va, __ se va, __
y la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar.

Se va, __ se va, __
va, la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar. __
}

sop_lyrics_b = \lyricmode {
  \repeat unfold 15 ""
flo -- re -- ci -- da de~a le -- grí -- a
con el al -- ba~a -- ma -- ne -- ció, __

De -- ba -- jo de su ca -- ri -- cia
dor -- mi -- do~es -- ta ba~el can -- tor,
por la gui -- ta -- rra~y la bo -- ca
le la -- ti -- a~u -- na __ can -- ción. __

La no -- che~en -- te -- ra can -- tó, __
co -- ro -- na -- do por la ra -- ma,
a -- bra -- za -- di -- to __ que -- dó. __

Can -- tar, __ can -- tar, __
las ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van,
can -- tar, __ can -- tar, __
las ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van. __
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
  \repeat segno 2 {
  \partial 8 a'8^\p
  fis4 8 8. e16 fis8
  g4 8 b b b b4 a g fis4.~4 r8
  fis8. 16 8 8 e e es4 d r r8
  d d d4 b8 cis4 d8 e r
  
  a8^\f fis4 8 8. d16 8 d4 8 r4. r
  d8 8 8 8. 16 8 8 r fis8 4 8 8. g16 fis8
  4 g8 8 fis e d4^\dim 4 cis d4.~8\! r4 r2. r4. r4
  d8 es4^"rit." 8 dis8 8 8 b4.~4 r8
  b^"a tempo" e fis g a b d4 b8 8 a g
  fis4 e e e( fis8 g4.)~ 2.~ 8 r4 r 
  d8^\p e r g fis r e d4.~8 r
  d e r g fis r e fis g fis fis d d
  es4 d4 8 8 4 8 cis4 8 d8 r4 r
  fis8^\pp g r g fis r e d4.~8 r
  fis g r^"rit." g fis r e d d e fis a fis
  d4 4 8 8 4 8 e4 8 d4.~8\fermata r
  }
}


alt_lyrics = \lyricmode {
Bo -- ni -- ta ra -- ma de sau -- ce,
bo -- ni -- ta ra -- ma d~a -- mor, __
nun -- ca flo -- re -- ció, que siem -- pre
se que -- dó di -- cien -- do~a -- diós. __

El ri -- o pa -- sa~y la pei -- na,
el ri -- o la ju -- ra~a -- mar,
la ra -- ma le da sus tren -- zas,
el ri -- o mien -- te~y __ se va. __

El ta -- llo le~ha -- ce cim -- brar, __
to -- da la ra -- mi -- ta can -- ta,
el vien -- to mien -- te~y __ se va. __

Se va, se va,  se va, __
se va, se va,  se va,
la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar.

Se va, se va,  se va, __
se va, se va,  se va,
la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar. __
}


alt_lyrics_b = \lyricmode {
  \repeat unfold 15 ""
flo -- re -- ci -- da de~a le -- grí -- a
con el al -- ba~a -- ma -- ne -- ció, __

De -- ba -- jo de su ca -- ri -- cia,
dor -- mi -- do~es -- ta ba~el can -- tor,
por la gui -- ta -- rra~y la bo -- ca
le la -- ti -- a~u -- na __ can -- ción. __

La no -- che~en -- te -- ra can -- tó, __
co -- ro -- na -- do por la ra -- ma,
a -- bra -- za -- di -- to __ que -- dó. __

Can -- tar, can -- tar, can -- tar, __
can -- tar, can -- tar, can -- tar,
ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van,
can -- tar, can -- tar, can -- tar, __
can -- tar, can -- tar, can -- tar,
ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van. __
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
  \repeat segno 2 {
  \partial 8 a'8^\p
  d4 8 8. 16 8 4 8 r4. r4.
  8 8 8 8. cis16 b8 a4 r8
  d8. 16 8 e d c c4 b4 r
  r8 b b b4 8 a4 b8 cis r
  
  a8^\f d4 8 8. 16 c8
  bes4 8 d d d d4 c bes a4.~ 8 r d8
  4 8 8. 16 8 es4 d8 r4.
  a4^\dim b a a4.~8 r
  a^\p 4 8 8 d b a4 g r8 d'
  c4^"rit" 8 b b b b4( a8 g4) r8
  b e, fis g a b d4 b8 r4.
  d4 4 4 cis( d8 e4.~) 2.~8 r4 r
  a,8^\p b r d cis r b a4.~8 r
  a b r d cis r cis d e d d d c
  c4 b4 8 8 a4 8 4 8 8 r4 r
  d8^\pp d r d cis r cis a4.~8 r
  d d r^"rit." d cis r cis c c c c fis d
  c4 b4 8 8 a4 8 cis4 8 d4.~8\fermata r
  }
}
ten_lyrics = \lyricmode {
Bo -- ni -- ta ra -- ma de sau -- ce,
bo -- ni -- ta ra -- ma d~a -- mor, __
nun -- ca flo -- re -- ció, que siem -- pre
se que -- dó di -- cien -- do~a -- diós. __

El ri -- o pa -- sa~y la pei -- na,
el ri -- o la ju -- ra~a -- mar,
la ra -- ma le da sus tren -- zas,
mien -- te~y __ se va. __

El vien -- to pa -- sa~y  la be -- sa, __
El ta -- llo le~ha -- ce cim -- brar, __
to -- da la ra -- mi -- ta can -- ta,
mien -- te~y __ se va. __

Se va, se va,  se va, __
se va, se va,  se va,
la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar.

Se va, se va,  se va, __
se va, se va,  se va,
la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar. __
}

ten_lyrics_b = \lyricmode {
  \repeat unfold 15 ""
flo -- re -- ci -- da de~a le -- grí -- a
con el al -- ba~a -- ma -- ne -- ció, __

De -- ba -- jo de su ca -- ri -- cia
dor -- mi -- do~es -- ta ba~el can -- tor,
por la gui -- ta -- rra~y la bo -- ca
u -- na __ can -- ción. __

Más dul -- ce que vien -- to~y ri -- o __
La no -- che~en -- te -- ra can -- tó, __
co -- ro -- na -- do por la ra -- ma,
y __ se __ que -- dó. __

Can -- tar, can -- tar, can -- tar, __
can -- tar, can -- tar, can -- tar,
ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van,
can -- tar, can -- tar, can -- tar, __
can -- tar, can -- tar, can -- tar,
ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van. __
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
  \repeat segno 2 {
  \partial 8 a8^\p
  d4 e8 c8. b16 a8 g4 8 r4. r
  d'8 8 8 8. cis16 b8 a4 r8 
  d8. 16 8 c b fis g4 4 r
  r8 b a gis4 8 g4 8 8 r
  
  a8^\f d4 8 c8. bes16 fis8
  g4 8 bes8 8 8 4 a g fis4.~8 r
  a c4 8 8. b16 a8 g4 8 r4.
  a4^\dim gis g fis4.~8 r
  a^\p 4 8 8 d b a4 g r8 
  b a4^"rit." 8 8 8 8 g4( fis8 e4) r8
  b'^"a tempo" e, fis g a b d4 b8 r4.
  d8( b) a( gis) 4 a2.~2.~8 r4 r
  fis8^\p g r b a r g fis4.~8 r
  fis g r b a r a d e d c b a
  g4 4 b8 8 a4 8 g4 8 fis8 r4 r
  a8^\pp b r b a r g fis4.~8 r a
  b r^"rit." b a r a a fis g a c c
  g4 4 8 8 a4 8 4 8 d4.~8\fermata r
  }
}

bass_lyrics = \lyricmode {
Bo -- ni -- ta ra -- ma de sau -- ce,
bo -- ni -- ta ra -- ma d~a -- mor, __
nun -- ca flo -- re -- ció, que siem -- pre
se que -- dó di -- cien -- do~a -- diós. __

El ri -- o pa -- sa~y la pei -- na,
el ri -- o la ju -- ra~a -- mar,
la ra -- ma le da sus tren -- zas,
mien -- te~y __ se va. __

El vien -- to pa -- sa~y  la be -- sa, __
El ta -- llo le~ha -- ce cim -- brar, __
to -- da la ra -- mi -- ta can -- ta,
mien -- te~y __ se va. __

Se va, se va,  se va, __
se va, se va,  se va,
la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar.

Se va, se va,  se va, __
se va, se va,  se va,
la ra -- mi -- ta se~in -- cli -- na, __
no la ve -- an sus -- pi -- rar. __
}

bass_lyrics_b = \lyricmode {
  \repeat unfold 15 ""
flo -- re -- ci -- da de~a le -- grí -- a
con el al -- ba~a -- ma -- ne -- ció, __

De -- ba -- jo de su ca -- ri -- cia
dor -- mi -- do~es -- ta ba~el can -- tor,
por la gui -- ta -- rra~y la bo -- ca
u -- na __ can -- ción. __

Más dul -- ce que vien -- to~y ri -- o __
La no -- che~en -- te -- ra can -- tó, __
co -- ro -- na -- do por la ra -- ma,
y __ se __ que -- dó. __

Can -- tar, can -- tar, can -- tar, __
can -- tar, can -- tar, can -- tar,
ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van,
can -- tar, can -- tar, can -- tar, __
can -- tar, can -- tar, can -- tar,
ver -- des co -- plas del sau -- ce, __
al -- tas por el cie -- lo van. __
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

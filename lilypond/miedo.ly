% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Miedo"
  subtitle = ""
  composer = "Fernando Moruja"
  tagline = ""

}

conductor_size = 19
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 2/4
\tempo 4 = 60
\key e \minor
}

trio = 
#(define-music-function
  (notes)
  (ly:music?)
  #{
  \tuplet 3/2 {
    #notes
  }
  #})


sop_music = {
  r8 e16 e b' b a a
  \time 3/4
  b8 e,4 16 g fis d fis a
  \time 2/4
  g8 4.
  \time 4/4
  \tuplet 3/2 {e8 8 8} \tuplet 3/2 {8 8 8} g a4 16 b
  \time 2/4
  c8 4 d16 c b8 e,4. \tuplet 3/2 {b'8 d d} \tuplet 3/2 {cis b a}
  b8 4 g16 a b8 c4 b16 a
  \time 3/4
  d8 b4 \breathe 16 16 e, e a fis
  e8 fis4 e16 g b b a d
  \time 2/4
  b8 4. r8 e,16 e b' b a a
  b8 e,4 8 \tuplet 3/2 {g fis e} fis d'
  b b4. \tuplet 3/2 {b8 e d} cis a
  b16 d b8~8 r r c16 c e8 d b a b16 d b8~
  \time 3/4
  b2.
  \time 2/4
  \tuplet 3/2 {e,8 8 b'} \tuplet 3/2 {d b a}
  b16 a b8~8 g16 a a8 g4 fis16 d
  \time 3/4
  fis8 4 \breathe b16 b e, e a fis
  \time 4/4
  e8 fis4 e16 g \tuplet 3/2 {b8 8 8} a d
  \time 2/4
  b8 4\fermata 16 cis d8^"più mosso" 8 8 e16 d
  cis8 a4 16 b c8 8 d c
  b16 c b4 g16 a b8 4 a16 e' d8 4 g,8
  \tuplet 3/2 {b b c} \tuplet 3/2 {b a e'}
  d8 cis4 r8
  \trio {e, e b'} \trio {d b a}
  b16 a b8~8 g16 a a8 g4 fis16 d
  \time 3/4
  fis8 4 \breathe b16 b e, e a fis
  e8 fis4 e16 g b b a d
  \time 2/4 b8 4.\fine
 }


sop_lyrics = \lyricmode {
  Yo no quie -- ro que~a mi ni -- nã
  go -- lon -- dri -- na me la vuel -- van;
  se~hun -- de vo -- lan -- do~en el Cie -- lo
  y no ba -- ja~has -- ta mi~es -- te -- ra;
  
  en el a -- le -- ro~ha -- ce~el ni -- do
  y mis ma -- nos no la pei -- nan.
  Yo no quie -- ro que~a mi ni -- ña
  go -- lon -- dri -- na me la vuel -- van.
  
  Yo no quie -- ro que~a mi ni -- nã
  la va -- yan a~ha -- cer prin ce -- sa.
  Con za -- pa -- ti -- tos de~o -- _ ro __
  ¿có -- mo jue -- ga~en las pra -- de -- _ ras? __

  Y cuan -- do lle -- gue la no -- _ che __ 
  a mi la -- do no se~a -- cues -- ta...
  Yo no quie -- ro que~a mi ni -- nã
  la __ _ va -- yan a~ha -- cer prin ce -- sa.
  
  Y _ me -- nos quie -- ro que~un dí -- a
  me la va -- yan a~ha -- cer rei -- _ na.
  La pon -- drí -- an en un tro -- no
  a don -- de mis ma -- nos no lle -- gan.
  
  Cuan -- do vi -- nie -- se la no -- _ che __
  no po -- drí -- a yo me -- cer -- la...
  ¡Yo no quie -- ro que~a mi ni -- nã
  me la va -- yan a~ha -- cer rei -- na!
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
  r8 e16 e g g fis e
  \time 3/4
  e8 d4 16 d d b d fis
  \time 2/4
  d8 e4.
  \time 4/4
  \tuplet 3/2 {e8 d d} \tuplet 3/2 {cis cis e} 8 4.
  \time 2/4
  g8 4 a16 e d8 cis4. \tuplet 3/2 {d8 fis8 8} \tuplet 3/2 {e e e}
  g8 4 fis16 16 8 4 d16 e
  \time 3/4
  g8 fis4 \breathe d16 d d d d d d8 4 e16 e fis fis fis a
  \time 2/4
  a8 fis4. r4 e g8 e4 d8 e d e e e g8 4
  \tuplet 3/2{g8 a b} a e g8 4 16 16
  8 a b g fis16 e fis8~8 g
  \time 3/4
  a4 b16 a b8~4
  \time 2/4
  \tuplet 3/2 {e,8 8 8} \tuplet 3/2 {b' g fis}
  fis8 8~8 e16 fis16 8 e4 d16 d
  \time 3/4
  cis8 4 \breathe d16 d d d d d
  \time 4/4
  8 4 e8 \tuplet 3/2 {fis8 8 8} 8 a
  \time 2/4
  a fis4.\fermata
  b8 a bes4 a4 16 g fis g a g a8 aes4 g4. 16 fis
  e8 g4 16 c b8 4 g8
  \tuplet 3/2 {8 8 a} \tuplet 3/2 {g fis8 8}
  fis8 4 r8 \trio {e e e} \trio {b' g fis}
  fis8 8~8 e16 fis16 8 e4 d16 d
  \time 2/4
  cis8 4 \breathe d16 d d d d d d8 4 e16 e fis16 16 16 a
  \time 2/4 a8 fis4.\fine
}

alt_lyrics = \lyricmode {
  Yo no quie -- ro que~a mi ni -- nã
  go -- lon -- dri -- na me la vuel -- van;
  se~hun -- de vo -- lan -- do~en el Cie -- lo
  ba -- ja~has -- ta mi~es -- te -- ra;
  
  en el a -- le -- ro~ha -- ce~el ni -- do
  y mis ma -- nos no la pei -- nan.
  Yo no quie -- ro que~a mi ni -- ña
  go -- lon -- dri -- na me la vuel -- van.
  
  Yo __ _ _ no quie -- _ ro prin ce -- _ sa.
  Con za -- pa -- ti -- tos de~o --  ro
  ¿có -- mo jue -- ga~en las pra -- de -- _ ras, __ 
  pra -- de -- _ _ ras? __

  Y cuan -- do lle -- gue la no --  che __ 
  a mi la -- do no se~a -- cues -- ta...
  Yo no quie -- ro que~a mi ni -- nã
  la va -- yan a~ha -- cer prin ce -- sa.
  
  O __ _ _ _ _ _ _ _ _ _ _ _ _
  La pon -- drí -- an en un tro -- no
  a don -- de mis ma -- nos no lle -- gan.
  
  Cuan -- do vi -- nie -- se la no -- che __
  no po -- drí -- a yo me -- cer -- la...
  ¡Yo no quie -- ro que~a mi ni -- nã
  me la va -- yan a~ha -- cer rei -- na!
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
  r8 b'16b d cis cis cis
  \time 3/4
  b8 4 16 b a a a cis
  \time 2/4
  cis8 b4.
  \time 4/4
  \tuplet 3/2 {g8 8 8} \tuplet 3/2 {g8 8 8} b8 c4.
  \time 2/4
  b8 a4 fis16 g g8 4. \tuplet 3/2 {g8 b b} \tuplet 3/2 {a d cis}
  d8 4 e16 16 8 4 d16 c
  \time 3/4
  b8 g4 \breathe a16 a b e, fis a
  g8 4 16 g fis a d b
  \time 2/4
  g8 4. r4 e'd b8 a g4 a g8 d' cis4 
  \tuplet 3/2 {d8 cis b} e cis e e4 r8 4. g8 d4. g8
  \time 3/4
  fis16 g fis8~2
  \time 2/4
  e4 fis d cis c a
  \time 3/4
  <g b>8 4 \breathe a16 a b e, fis a
  \time 4/4
  g8 4 8 \tuplet 3/2 {fis a a} d b
  \time 2/4
  g8 4.\fermata fis'4 g fis8 cis4.
  e4 f e4. 16 d cis8 4 d16 e
  e8 4 8 \tuplet 3/2 {d fis e} \tuplet 3/2 {e d b}
  <g b>8 4 r8 e'4 fis d cis c a
  \time 3/4
  <g b>8 4 \breathe a16 a b e, fis a g8 4
  g16 g fis a d b
  \time 2/4 g8 4.\fine
  
}


ten_lyrics = \lyricmode {
  Yo no quie -- ro que~a mi ni -- nã
  go -- lon -- dri -- na me la vuel -- van;
  se~hun -- de vo -- lan -- do~en el Cie -- lo
  ba -- ja~has -- ta mi~es -- te -- ra;
  
  en el a -- le -- ro~ha -- ce~el ni -- do
  y mis ma -- nos no la pei -- nan.
  Yo no quie -- ro que~a mi ni -- ña
  go -- lon -- dri -- na me la vuel -- van.
  
  Yo no quie -- _ ro prin ce -- _ sa.
  Con za -- pa -- ti -- tos de~o --  ro
  las pra -- de -- _ ras? __ _ _
  
  Y la no -- che no se~a -- cues -- ta...
  Yo no quie -- ro que~a mi ni -- nã
  la va -- yan a~ha -- cer prin ce -- sa.
  
  O __ _ _ _ _ _ _ 
  La pon -- drí -- an en un tro -- no
  a don -- de mis ma -- nos no lle -- gan.
  
  Y la no -- che me -- _ cer -- la...
  ¡Yo no quie -- ro que~a mi ni -- nã
  me la va -- yan a~ha -- cer rei -- na!
}


ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \alto_style
  \armure
  \relative c' {\dynamicUp
  \ten_music}
  \addlyrics {\ten_lyrics}
>>


bass_music = {
  r8 e,16 e e e e e
  \time 3/4
  g8 4 16 e b fis' d b
  \time 2/4
  e8 4.
  \time 4/4
  \tuplet 3/2 {8 8 8} \tuplet 3/2 {8 8 d} c8 4.
  \time 2/4
  a8 4 16 16 e'8 4. g,4 a
  e'8 4. a,8 4 fis'16 g
  \time 3/4
  e8 4 \breathe fis16 16 g g b, d 
  e8 4 16 e d d fis b,
  \time 2/4
  e8 4. r2
  <e e,> b <e e,> \tuplet 3/2 {e8 8 8} a, a
  c8 4 r8 a4. b8 c2
  \time 3/4 b4 e2 \time 2/4
  e4 d b <e e,> a, b
  \time 3/4
  <e e,>8 4\breathe fis16 16 g g b, d
  \time 4/4
  e8 4 8 \tuplet 3/2 {d d d} fis b,
  \time 2/4
  e8 4.\fermata g,4 e' d2 f,4 d'e4. 16 16
  8 4 16 d c8 4 8 \tuplet 3/2 {g g g} \tuplet 3/2 {c c c}
  e8 4 r8 e4 d b <e e,> a, b
  \time 3/4
  <e e,>8 4\breathe fis16 16 g g b, d
  e8 4 16 e d d fis b,
  \time 2/4
  e8 4.\fine
}

bass_lyrics = \lyricmode {
  Yo no quie -- ro que~a mi ni -- nã
  go -- lon -- dri -- na me la vuel -- van;
  se~hun -- de vo -- lan -- do~en el Cie -- lo
  ba -- ja~has -- ta mi~es -- te -- ra;
  
  en el ni -- do
  ma -- nos no la pei -- nan.
  Yo no quie -- ro que~a mi ni -- ña
  go -- lon -- dri -- na me la vuel -- van.
  
  O __ _ _
  Con za -- pa -- ti -- tos de~o --  ro
  las pra -- de -- _ ras? __
  
  Y la no -- che no se~a -- cues -- ta...
  Yo no quie -- ro que~a mi ni -- nã
  la va -- yan a~ha -- cer prin ce -- sa.
  
  O __ _ _ _ _ _ 
  La pon -- drí -- an en un tro -- no
  a don -- de mis ma -- nos no lle -- gan.
  
  Y la no -- che me -- _ cer -- la...
  ¡Yo no quie -- ro que~a mi ni -- nã
  me la va -- yan a~ha -- cer rei -- na!
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

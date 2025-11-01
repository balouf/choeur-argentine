% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Los Coflades de la Eztleya"}
  composer = "Juan de Araujo (1649-1712)"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 6/8
\tempo 4. = 84
\key g \major
}

sola_music = {
r4 d' c b8 c4 a8 b4
c8 d e4 d cis8 d4 b8 cis4 d8 4 r
a8~8 g4 fis8 g4 e8 fis4 g8 a b~
8 a4 fis8 g4 8 fis4 g r8 r4r d'8 c
b a c b fis4 g4. r8 a a fis8 8 g a gis4 a4. r8 cis8 8
d d d d cis4 b8 4 r8 d d e e e4 d cis8 8 d4 b
cis8 d4 8 cis4 d8 4 r4 d8 c c b a c4
b4 d8 e d f e d c b cis d cis4. r
c8 d e d e f e4. r8 c c b b b b a a g4. r8
d' d d4. r r4 r cis d4. r8 b cis
d d d d c4 b4. r4 d8 8 cis4 d8 a4 b4. r r2.
r4. r4 d8~8 b4 c b8 a4 c8 b cis d~8 e4 c8 d e~8
d4 e8 4
}

sola_lyrics = \lyricmode {
Los Cof -- la -- des de la~Ez -- tle -- ya
Va -- mo tu -- rus á Be -- le -- ya,
Y __ ve -- le -- mo~á Zio -- la be -- ya
Con __ Zio -- lo en lo Pol -- tal
Va -- mo, va -- mo cu -- ren -- do~a -- yá,
Va -- mo, va -- mo, cu -- ren -- do~a -- yá,
Oy -- le -- mo un Vi -- yan -- _ si -- co,
Que lo com -- pond -- la Fla -- si --co,
Zien -- do Gay -- ta zu fo -- zi -- co;
Y lue -- go lo can -- ta -- lá
Blas -- i -- co, Pel -- li -- co, 
Zuan -- i -- co~y to -- má;
Y lo~es -- tli -- vi -- yo di -- lá
Gu -- lum -- bé, gu -- lum -- bé, gu -- lum -- bá;
gu -- lum -- bá; Gua -- ché 
Mo -- le -- ni -- yo de Za -- fa -- lá, 
de Za -- fa -- lá. Gua -- ché
Va -- mo~á vel que tlaen de An -- go -- la~A __
Zi -- o -- lo, y~á __ Zi -- o -- la,
}


sola = \new Staff \with {instrumentName="Solo I"
  shortInstrumentName ="S. 1"} <<
  \soprano_style
  \armure
  \relative c' {\sola_music}
  \addlyrics {\sola_lyrics}
>>

solb_music = {
  R2.*8 r4. r8 d'c b a c b fis4
  g8 fis4 g8 a4 b4. r8 cis8 8  d d d cis b4
  cis4. r8 a a b b b b a4 gis8 4 r8 b b c c
  c4 b a8 g fis4 g4 8 fis4 g8 e4 fis8 4 
  r f8 e fis g g fis4 g b8 c b d c b a a a gis a4. r
  a8 b c c c b c4. r r r8 c c b b b b a a g4.
  r r2. r8 fis4 g4. r r8 e fis g g g g fis4 
  e4. r8 fis4 g4. r r2. r4. r4 fis8~8
  g4 e8 fis g~8 fis4 g8 a b~8 c4 a8 b c~8 b4 c8 4
}

solb_lyrics = \lyricmode {
  Va -- mo, va -- mo, cu -- ren -- do~a -- yá,
  cu -- ren -- do~a -- yá,
Va -- mo, va -- mo, cu -- ren -- do~a -- yá,
Oy -- le -- mo un Vi -- yan -- _ si -- co,
Que lo com -- pond -- la Fla -- si --co,
Zien -- do Gay -- ta zu fo -- zi -- co;
Y lue -- go lo can -- ta -- lá
Blas -- i -- co, Pel -- li -- co, 
Zuan -- i -- co~y to -- má;
Y lo~es -- tli -- vi -- yo di -- lá
Gu -- lum -- bé, gu -- lum -- bé, gu -- lum -- bá;
Gua -- ché
Mo -- le -- ni -- yo de Za -- fa -- lá. Gua -- ché
Va -- mo~á vel que tla -- en de~An -- go -- la~A __
Zi -- o -- lo, y~á __ Zi -- o -- la,
}

solb = \new Staff \with {instrumentName="Solo II"
  shortInstrumentName ="S. 2"} <<
  \soprano_style
  \armure
  \relative c' {\solb_music}
  \addlyrics {\solb_lyrics}
>>

sop_music = {R2.*10
 r4. r8 a' a g g a b a4 4 8 8 b4 a4.r
 R2.*13 r4. r8 a a b c d c a a b4. r R2.*3
 r8 a4 4. R2. r8 a a b b b b a4 4. R2.*4
}

sop_lyrics = \lyricmode {
Va -- mo, va -- mo, cu -- ren -- do~a -- yá, 
cu -- ren -- do~a -- yá.
Gu -- lum -- bé, gu -- lum -- bé, fu -- lum -- bá;
Gua -- ché de Za -- fa -- lá, de Za -- fa -- lá.
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
>>

alt_music = {R2.*10
 r4. r8 fis8 8 d d d g e4 d fis8 e gis4 e4. r
 R2.*13 r4. r8 fis8 8 g g g g fis8 8 g4. r R2.*3
 r8 e4 fis4. R2. r8 e fis g g g g e4 fis4. R2.*4
}

alt_lyrics = \lyricmode {
Va -- mo, va -- mo, cu -- ren -- do~a -- yá, 
cu -- ren -- do~a -- yá.
Gu -- lum -- bé, gu -- lum -- bé, fu -- lum -- bá;
Gua -- ché de Za -- fa -- lá, de Za -- fa -- lá.
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
>>

ten_music = {R2.*10
 r4. r8 d'8 8 b b c d cis4 a d8 cis e4 cis4. r
 R2.*13 r4. r8 d d d e f e d d d4. r R2.*3
 r8 cis4 a4. r8 b c d d d d c4 b d8 d cis4 d4. R2.*4
}

ten_lyrics = \lyricmode {
Va -- mo, va -- mo, cu -- ren -- do~a -- yá, 
cu -- ren -- do~a -- yá.
Gu -- lum -- bé, gu -- lum -- bé, fu -- lum -- bá;
Gua -- ché Mo -- le -- ni -- yo 
de Za -- fa -- lá. de Za -- fa -- lá.
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
>>

bass_music = {R2.*10
 r4. r8 d d g g g g a4 d,4 8 a e'4 a,4.r\break
 R2.*13 r4. r8 d d g g, g c d d g,4. r R2.*3
 r8 a4 d4. r8 g a b b b b a4 g g8 8 a4 d,4. R2.*4
}

bass_lyrics = \lyricmode {
Va -- mo, va -- mo, cu -- ren -- do~a -- yá, 
cu -- ren -- do~a -- yá.
Gu -- lum -- bé, gu -- lum -- bé, fu -- lum -- bá;
Gua -- ché Mo -- le -- ni -- yo 
de Za -- fa -- lá. de Za -- fa -- lá.
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\bass_music}
  \addlyrics {\bass_lyrics}
>>


upper = \relative c' {
  \armure
  \rpiano_syle
  <b' d>4. <a c> <g b>8 <g c>4 <a c>8 <g b>4
  <a c>4 <e g> <d g d'> <a'cis>8 <d,d'>4 <g b>8 
  <a cis,>4 <a d d,>4 4 4 <d, fis a>8 <d g b>4
  <d fis a>8 <d g b>4 
  <cis e a>8 <d a'd>4 <b e g>8 <d fis a> <d g b>~8
  <e a e'>4 <d fis a>8 <b d g>4
  <a d g>8~<a d fis>4 <b d g>4 <d a'c>8
  <d g b>8 <d a'd>4 <g b d>8 <d fis a d>4
  <d g b>8 <d a'd>4 <d g b>8 <d a'd>4
  <d g b>4 4 <cis e a> <d a' d>4. <cis e a>8 <e g b>4
  <e a cis>4. <e a e'> <e b'e>4 4 <e a cis>
  <e gis b>4. <e a c>8 <gis b d>4 <g c e>4 4 <g b e>
  <e a cis> <d a'd> <g b d> <e a e'>8 <fis a d>4 
  <g b d>8 <e a cis>4 <d a'd>4. <g b d> <e g c>4
  <d g b>8 <g a>8~<fis a>4 
  <d g b>4 <g b d>8 <g c e> <g b d>4
  <g c e>8 <g b d> <d a'c> <e a b> <e a cis> <e gis b d>
  <e a cis>4 4 <e gis b> <e a c>4. 
  <g c d>8 <g c e > <g b d f> <g c e>4. <e g c>
  <d g b>4 4 <fis a c> <d g b>4 4 <fis a d>
  <g b d> <g d'f>8 <g c e> <fis a d>4
  <d g b>4 4 <e a cis> <d a'd>4. <d g b>4 <cis e a>8
  <d g d'>4. 8 <d a'c>4 <d g b>4. <d fis a>
  <cis e a> <d fis a> <d g b>4. 4. 8 <c e a>4 <d g b>4.
  <d g b>8 <cis e a>4 <d fis a>4 8~8 <d g b>4 <e g c>
  <d g b>8 <d fis a>4. <d g b>4 8~8 <e g c>4 <f a c>
  <e g c>8 <d g b>4. <e g c>
}

lower = \relative c {
\armure
\lpiano_syle
g'4. fis g8 c,4 d8 g4 a8 b c4 b
a8 fis4 g8 a4 d, d d
d8 g4 d8 g,4 a8 d4 e8 fis g~8
cis,4 d8 g,4 d'4. g,4 fis'8( g)
fis4 g8 d4 g8 d4 g8 d4 g g a d,4. a8 e'4
a,4. a' gis4 4 a e4. a8 gis4
c, c g' a d, g a8 d,4 g8 a4 d,4. g c,4 g8 d'4.
g4. c,8 g'4 c,8 d4 e4. a4 4 e a4. g c, c
g'4 4 fis g g d g g,8 c d4 g g a d,4. g8 8 a
b4. 8 a4 g4. d a' d, g8 8 a b4. 8 a4 g4.
g8 a4 d, d8~8 g4 c, g'8 d4. g4 8~8 c,4 f c8 g'4. c,
}


piano = \new PianoStaff \with { instrumentName = "Arpa y Baxo" 
shortInstrumentName ="A&B"}
  <<
    \new Staff = "upper" \upper
    \new Staff = "lower" \lower
  >>

% instrumentName = "A&B"


#(set-global-staff-size conductor_size)
\book {
  \score {
        \layout {
  \context {
    \Staff
    \RemoveAllEmptyStaves
  }
}
<<
    \new ChoirStaff
    <<
      \sola
      \solb
      \sop
      \alt
      \ten
      \bass
    >>
>>
  }
   \score {
    \unfoldRepeats
    <<
      \sola
      \solb
      \sop
      \alt
      \ten
      \bass
      \piano
    >>
    \midi {}
  }
}

\book {
  \bookOutputSuffix "-full"
  \score {
        \layout {
  \context {
    \Staff
    \RemoveAllEmptyStaves
  }
}
<<
    \new ChoirStaff
    <<
      \sola
      \solb
      \sop
      \alt
      \ten
      \bass
    >>
    \piano
>>
  }
}


\book {
  \bookOutputSuffix "-piano"
  \score {
        \layout {
  \context {
    \Staff
    \RemoveAllEmptyStaves
  }
}
 \piano
  }
}

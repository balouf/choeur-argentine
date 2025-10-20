% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "A Este Sol Peregrino"
  composer = "Tomás Torrejón y Velasco"
  tagline = ""

}

conductor_size = 18
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 6/8
\tempo 4. = 90
\key bes \major
}


sop_music = {
  r8 f f g8. a16 bes8 a8 4 r4. r2.
  r8 bes8 8 c8. d16 es8 d4. es f8. es16 d8
  c4 8 r2. r4. c8. bes16 a8 g4 8 r4. r d'8. c16 bes8 a f c'~
  8 bes4 a8 f c'~8 bes4 a8. g16 f8 g4. c,8 r r
  g'8. f16 es8 d4 8 g8. f16 es8 d4 8
}	


sop_lyrics = \lyricmode {
  A~es -- te sol pe -- re -- gri -- no.
  A~es -- te sol pe -- re -- gri -- no,
  cán -- ta -- le glo -- rias,
  cán -- ta -- le glo -- rias,
  cán -- ta -- le glo -- rias,
  za -- ga -- le -- jo,
  za -- ga -- le -- - - - jo,
  cán -- ta -- le glo -- rias,
  cán -- ta -- le glo -- rias,
  
}


sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
>>


alt_music = {
  R2.*2 r4.
  r8 f f g8. a16 bes8 8 a4 bes2. r2.
  d8. c16 bes8 a f c'~8 bes4 a8 f c'~8 bes8. g16 a8 bes r
  r2. c8. bes16 a8 g4 8 c8. bes16 a8 g4 8
  r4 c8~8 bes4 a8. g16 f8 r c' c b4 8
  r c c b4 8
}	


alt_lyrics = \lyricmode {
  A~es -- te sol pe -- re -- gri _ -- no, __
  cán -- ta -- le glo -- rias,
  za -- ga -- le -- jo,
  za -- - ga -- le -- jo,
  cán -- ta -- le glo -- rias,
  cán -- ta -- le glo -- rias,
  za -- ga -- le -- - jo,
  za -- ga -- le -- jo,
  za -- ga -- le -- jo,
  
}



alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
>>

ten_music = {
  R2. r4. r8 bes'8 8 c8. d16 es8
  d4 8 es4 d8 f4. f g8. f16 es8 d8 bes f'~8 es4
  d8 bes f'~8 es4 d c8 8. f16 es8
  d4. f8. es16 d8 c4 8 f8. es16 d8 c4 8
  4.~c c c8. bes16 a8 g g g'~g f4
  es8. d16 g8~8 f4 es8. d16 c8 g4 8
}	


ten_lyrics = \lyricmode {
A~es -- te sol pe -- re -- gri -- no,
pe -- re -- gri -- no,
cán -- ta -- le glo -- rias, 
za -- ga -- le -- jo, za -- ga -- le -- jo,
za -- ga -- le -- jo,
cán -- ta -- le glo -- rias,
cán -- ta -- le glo -- rias, glo -- rias,
cán -- ta -- le glo -- rias,
za -- ga -- le -- jo,
za -- ga -- le -- -  jo,
za -- ga
}



ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \alto_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
>>


bass_music = {
  R2. r8
  f, f g8. a16 bes8 a4. bes
  es,8. f16 g8 f4. bes es8. d16 c8 bes8 g a~
  8 4 bes4. f4.~2. g8. f16 es8 d bes f'~8 es4
  d8 bes4 r8 f' f e4 8 r f f e4 8 f4 8 e4 8
  f8. es16 d8 c4 8 g'4. c, r
  
}	


bass_lyrics = \lyricmode {
  A~es -- te sol pe -- re -- gri -- no,
  sol pe -- re -- gri -- no,
  cán -- ta -- le glo -- rias, 
  za -- ga -- le -- jo, __
  cán -- ta -- le glo -- rias, 
  za -- ga -- le -- jo,
  za -- ga -- le -- jo,
  za -- ga -- le -- jo,
  za -- ga -- le -- jo,
  cán -- ta -- le glo -- rias, glo -- rias,
  }



bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
>>


upper = \relative c' {
  \armure
  \rpiano_syle
<bes d f>4. <bes es g>8. a'16 <bes, es bes'>8
<c f a>4 8 <es g bes> <bes es bes'>8 8 <c f a>4. <d f bes>
<es g bes>4 <d g bes>8 <f bes c>~ <f a c>4
<f bes d>4. <es g bes>8. f16 <c es bes'>8 
<d f bes>8~<d g bes> <f d'>~<f c'> <es f c'>4
<d f bes>4. <c f a>8 <es f>~<es f c'>
<d f c'> <d f bes> <c f bes> <c f a>4 <es a c>8
<d g c>~<d g bes> <es g bes> <f a> <d f bes>4
<c f a>8 <es f a>4 <d f bes>8. es16 <d f bes>8
<c f a>8.~<c bes'>16 <f a c>8 <c g' c>8~<c g'bes>4
<c f a>8.~<c f bes>16 <f a c>8 <c g' c>8~<c g'bes>4
<c f a>8.~<c g' bes>16 <f a c>8 <c g' c>8~<c g'bes~>8 8
<c f a>8.~<c g'>16 f8 <es g>8. f16 <es g c>8
<d g b>4 <d f b>8 <es g c>4 8
<d g b>4 8
}

lower = \relative c {
\armure
\lpiano_syle
bes4. es8. f16 g8 f4 8 es8. f16 g8 f4. bes,
es8. f16 g8 f4. bes, es8. d16 c8 bes g a~8 4
bes4. f f' f g8. f16 es8 d bes f'~8 es4
d8 bes4 f'4 8 e4 8 f4 8 e4 8 f4 8 e4 8
f8. es16 d8 c4. g' c, g'
}

piano = \new PianoStaff \with { instrumentName = "B.C." }
  <<
    \new Staff = "upper" \upper
    \new Staff = "lower" \lower
  >>

% instrumentName = "B.C."

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

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
\tempo 4. = 60
\key bes \major
}


sop_music = {
\repeat segno 2 {
r8 f f g8. a16 bes8 a8 4 r4. r2.
  r8 bes8 8 c8. d16 es8 d4. es f8. es16 d8
  c4 8 r2. r4. c8. bes16 a8 g4 8 r4. r d'8. c16 bes8 a f c'~
  8 bes4 a8 f c'~8 bes4 a8. g16 f8 g4. c,8 r r
  g'8. f16 es8 d4 8 g8. f16 es8 d4 8
  r c' c b4 8 r c c b4 8 r4.
  c8. 16 d8 es8. 16 d8 c8. 16 d8
  es8. 16 d8 c4 f,8~f4. 4. 4.
  f8 8 d' c8. d16 es8 d8. c16 d8
  r4. d8. c16 d8 r4. r8 es8 8 d4 8
  c c c b4 c8 r2. r8 es8 8 d4 8
  c c c b8. 16 es8~8 d4 es8 bes d~
  8 c4 d4 8 
\bar "||"
r2. r r4. r8 f f es8. f16 es8 d4 8 c4. c
r8 bes8 8 a8. bes16 a8 g4 8 f4 8 bes8 8 c
bes4. 4. r r2. g8 8 a bes4.~8 a4 bes4.~4.
g8 8 a bes2 a4 bes2. 
\volta 2 \fine
\pageBreak
\volta 1 {
  \repeat volta 2 {
  r4^"Coplas" d8 4 c8 c8 bes16 c bes8 8 a4
  bes4. d8 8 8 c bes bes a4.
  bes8 c d c c c c b4 c4. r2.
  es8 8 d c d es f2.
  }
}
}
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
  za -- ga -- le -- jo,
  za -- ga -- le -- jo.
  Y con gus -- toy do -- nai -- re
  con go -- zoy con -- ten -- to, 
  za -- ga -- le -- jo,
  za -- ga -- le -- _ jo, 
  cán -- ta -- le, cán -- ta -- le,
  que del or -- be do -- ra las cum -- bres,
  que del or -- be do -- ra las cum -- bres,
  za -- ga -- le -- jo, za -- ga -- le -- jo.
  
Y pues vi -- ve~a sus ra -- yos, ra -- yos.
Y pues vi -- ve~a sus ra -- yos, ra -- yos,
go -- ce sus lu -- ces,
go -- ce sus lu -- _ ces,
go -- ce sus lu -- _ ces.

Di -- vi -- no pe -- que -- _ ño tus glo -- rias
hoy a -- co -- bar -- dan mi voz,
que no de -- jar re -- gis -- trar -- _ se.
Su -- po -- ne la luz ma -- yor. __
}
sop_lb = \lyricmode {
\repeat unfold 147 {""}
De~o -- rien -- te a~o -- rien -- _ te ca -- mi -- na,
tu so -- be -- ra -- no~es -- plen -- dor.
Que~aún el o -- ca -- so~es prin -- ci -- _ pio.
Don -- de siem -- pre na -- ce~el sol. __
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
  \addlyrics {\sop_lb}
>>


alt_music = {
  \repeat segno 2 {
  R2.*2 r4.
  r8 f f g8. a16 bes8 8 a4 bes2. r2.
  d8. c16 bes8 a f c'~8 bes4 a8 f c'~8 bes8. g16 a8 bes r
  r2. c8. bes16 a8 g4 8 c8. bes16 a8 g4 8
  r4 c8~8 bes4 a8. g16 f8 r c' c b4 8
  r c c b4 8 g4.~8 f4 es8. d16 c8 d4. c8 r4
  r4. c'8. 16 bes8 a8. 16 bes8 c8. 16 bes8 a8. 16 bes8 
  c8 4 bes8 4 c8 4 bes8 4 a4. 
  bes8. c16 bes8 r4. bes8. c16 bes8 r4.
  r8 bes8 8 4 8 g g f g4 8  r2.
  r8 bes8 8 4 8 g g g g8. a16 bes8~8 4
  8 g bes~8 a4 bes4 8 
  \bar "||"
  r2. r8 bes8 8 a8. bes16 a8 g4 8
  f4 8 r c'8 8 bes8. c16 bes8 a4 8 g4 8
  r2. r8 bes8 8 a8. bes16 a8 g4 8 f4 8
  g g a bes4.~8 a4 bes8 f f
  es8. f16 es8 d4 8 c4 8 r f f g g a
  bes4 8 f f g f4. 2.
  \volta 2 \fine
  \volta 1 {
    \repeat volta 2 {
    r4 bes8 4 a8 g g g g f4 4. bes8 8 8
    a g g fis4. g8 8 8 8. 16 8 4. 4.
    r2. g8 a bes bes a a bes2.
    }
  }
  }
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
  za -- ga -- le -- _ _ _ jo.
  
  Y con gus -- toy do -- nai -- re
  con go -- zoy con -- ten -- to,
  za -- ga -- le -- jo,
  za -- ga -- le -- jo, 
  cán -- ta -- le, cán -- ta -- le,
  que del or -- be do -- ra las cum -- bres,
  que del or -- be do -- ra las cum -- bres,
  za -- ga -- le -- jo, za -- ga -- le -- jo.
  
Y pues vi -- ve~a sus ra -- yos, ra -- yos.
Y pues vi -- ve~a sus ra -- yos, ra -- yos.
Y pues vi -- ve~a sus ra -- yos, ra -- yos,
go -- ce sus lu -- _ ces.
Y pues vi -- ve~a sus ra -- yos, ra -- yos.
go -- ce, go -- ce sus lu -- ces,
go -- ce sus lu -- ces.

Di -- vi -- no pe -- que --  ño tus glo -- rias
hoy a -- co -- bar -- dan mi voz,
que no de -- jar re -- gis -- trar -- se.
Su -- po -- ne la luz ma -- yor. __

}
alt_lb = \lyricmode {
\repeat unfold 159 {""}
De~o -- rien -- te a~o -- rien -- te ca -- mi -- na,
tu so -- be -- ra -- no~es -- plen -- dor.
Que~aún el o -- ca -- so~es prin -- ci -- pio.
Don -- de siem -- pre na -- ce~el sol. __
}



alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
  \addlyrics {\alt_lb}
>>

ten_music = {
  \repeat segno 2 {
  R2. r4. r8 bes'8 8 c8. d16 es8
  d4 8 es4 d8 f4. f g8. f16 es8 d8 bes f'~8 es4
  d8 bes f'~8 es4 d c8 8. f16 es8
  d4. f8. es16 d8 c4 8 f8. es16 d8 c4 8
  4.~c c c8. bes16 a8 g g g'~g f4
  es8. d16 g8~8 f4 es8. d16 c8 g4 8
  c4 8 r4. g'4.~8 f4 es8. d16 c8
  r4. c8. 16 d8 es8. 16 d8
  c8. 16 d8 es8. 16 d8 c es4 d8 4 c8 es4
  d8 f4 4. 8. 16 8 r4. 8. 16 8 r4.
  r8 g g f4 8 es d c d4 es8 r2.
  r8 g g f4 8 es d c d8. 16 g8~8 f4
  g8 es f~8 4 4 8 
  \bar "||"
  r2. r4. r8 f f es8. f16 es8 d4 8 c4 8
  d d es f4.~8 e4 f2. r4. c8 8 d 
  es4.~8 d4 es4. r8 f f es8. f16 es8 d4 8
  c4 8 f f g f4 es8 d4 8 es4 c8 bes8 8 c d4.
  c d2.
  \volta 2 \fine
  \volta 1 {
    \repeat volta 2 {
    r4 f8 4 8~16 es d8 es c d es d4. f8 8 8
    8 d d d4. 8 8 8 es8. 16 8 d es f es4.
    c8 d es es d d es bes4 f'4. 2.
    }
  }
  }
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
za -- ga -- le -- jo,
za -- ga -- le -- _ jo.

Y con gus -- toy do -- nai -- re
con go -- zoy con -- ten -- to,
za -- ga -- le -- jo,
za -- ga -- le -- jo, 
cán -- ta -- le, cán -- ta -- le,
que del or -- be do -- ra las cum -- bres,
que del or -- be do -- ra las cum -- bres,
za -- ga -- le -- jo, za -- ga -- le -- jo.

Y pues vi -- ve~a sus ra -- yos, ra -- yos,
go -- ce sus lu -- _ ces,
go -- ce sus lu -- _ ces.
Y pues vi -- ve~a sus ra -- yos, ra -- yos,
go -- ce sus lu -- _ _ ces,
lu -- ces, go -- ce sus lu -- _ ces.

Di -- vi -- no pe -- que -- ño tus glo -- _ rias
hoy a -- co -- bar -- dan mi voz,
que no de -- jar re -- gis -- trar -- _  _ se.
Su -- po -- ne la luz ma -- yor, __ _ ma -- yor. __
}

ten_lb = \lyricmode {
\repeat unfold 161 {""}
De~o -- rien -- te a~o -- rien -- te ca -- mi -- _ na,
tu so -- be -- ra -- no~es -- plen -- dor.
Que~aún el o -- ca -- so~es prin -- ci -- _ _  pio.
Don -- de siem -- pre na -- ce~el sol, __ _
el sol. __
}


ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \alto_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
  \addlyrics {\ten_lb}
>>


bass_music = {
  \repeat segno 2 {
  R2. r8
  f, f g8. a16 bes8 a4. bes
  es,8. f16 g8 f4. bes es8. d16 c8 bes8 g a~
  8 4 bes4. f4.~2. g8. f16 es8 d bes f'~8 es4
  d8 bes4 r8 f' f e4 8 r f f e4 8 f4 8 e4 8
  f8. es16 d8 c4 8 g'4. c, r
  c'8. bes16 aes8 g4 8 c8. bes16 aes8 g4 8 r4.
  c8. 16 bes8 a8. 16 bes8 c8. 16 bes8 a8. 16 bes8 
  c4 bes8 a8 4 bes8 4 a8 4 bes8 8 8 f4 8
  bes8. a16 bes8 r4. bes8. a16 bes8 r4.
  r8 es8 8 bes4 8 c bes aes g4 c,8 r2.
  r8 es'8 8 bes4 8  c bes aes g8. f16 es8~8 bes'4
  es,8 8 bes~8 f'4 bes,4 8
  \bar "||"
  r8 bes'8 8 a8. bes16 a8 g4 8 f4 8 f f g
  bes4.~8 a4 bes4. f4 8 c4 8 d d es f4.~8 e4
  f4. g8 8 a bes4. es,8 8 8 d8. es16 d8 c4 8 bes4 8
  c4 8 d d es f4 8 bes4 8 es,8 8 f
  g4 8 d d es f4. bes,2.
  \volta 2 \fine
  \volta 1 {
    \repeat volta 2 {
    r4 bes'8 4 f8 8 g es es f4 bes,4. bes'8 8 8
    f g g d4. g8 8. f16 es8 d c g'4. c,
    aes'8 8 g f f f es4. f bes,2.
    }
  }
  }
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
  cán -- ta -- le glo -- rias,
  cán -- ta -- le glo -- rias.

Y con gus -- toy do -- nai -- re
con go -- zoy con -- ten -- to,
za -- ga -- le -- jo,
za -- ga -- le -- jo,
za -- ga -- le -- jo,
cán -- ta -- le, cán -- ta -- le,
que del or -- be do -- ra las cum -- bres,
que del or -- be do -- ra las cum -- bres,
za -- ga -- le -- jo, za -- ga -- le -- jo.

Y pues vi -- ve~a sus ra -- yos, ra -- yos,
go -- ce sus lu -- _ ces,
go -- ce, go -- ce, 
go -- ce sus lu -- _ ces,
go -- ce sus lu -- ces.
Y pues vi -- ve~a sus ra -- yos, ra -- yos,
go -- ce, go -- ce sus lu -- ces,
go -- ce, go -- ce sus lu -- ces,
go -- ce sus lu -- ces.

Di -- vi -- no pe -- que -- ño tus glo -- rias
hoy a -- co -- bar -- dan mi voz,
que no de -- jar re -- gis -- trar -- se.
Su -- po -- ne la luz ma -- yor, __  ma -- yor. __

}

bass_lb = \lyricmode {
\repeat unfold 174 {""}
De~o -- rien -- te a~o -- rien -- te ca -- mi -- na,
tu so -- be -- ra -- no~es -- plen -- dor.
Que~aún el o -- ca -- so~es prin -- ci -- pio.
Don -- de siem -- pre na -- ce~el sol, __
el sol. __
}


bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
  \addlyrics {\bass_lb}
>>


upper = \relative c' {
  \armure
  \rpiano_syle
\repeat segno 2 {
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
<d g b>4 8 <es g c> <c es c'> <c g'c>
<d g b> f <d f b> <es g c> <c es c'> <c g'c>
<d g b>~ <f b> <d f b> 
<es g c>8.~ <es g b>16~ <es g c>8
<es a c>8. 16 <f bes d>8
<f c'es>8. 16 <f bes d>8
<es a c>8. 16 <f bes d>8
<f c'es>8. 16 <f bes d>8
<es a c>8. 16 <f bes d>8
<f a c>8 <es a c>4 <d f bes>8 4
<c f a>8 <c es a>4 <d f bes>8 8 <f bes d>
<f a c>8.~ <f a d>16 <c'es>8
<f, bes d>8.~<f bes c>16 <f bes d>8
<<{\voiceOne c'16 es32 d c16 bes c es
  d8. c16 d8 <f, a c>16 f32 g a bes c d es d c es}
  \new Voice {\voiceTwo <es, g>4 <f a>8
  <f bes>4 8 s4 <f a>8}
>>
\oneVoice
<f bes d>8 <g bes es>8 8 <f bes d>4 8
<es g c> <d g c> <c f c'> <d g b>4 <es g c>8
r4. <g b d>8 g32 a b c <g b d>8
<g bes es>8 8 8 <f bes d>4 8
<es g c>8 <d g c> <c g'c>
<d g b>8. <a' b>16 <g bes es>8~8
<f bes d>4 <g bes es>8 <g bes> <f bes d>8~8
<f a c>4 <f bes d>4.
\bar "||"
<d f bes>4 8 
<<
  {\voiceOne a'8. bes16 a8 g <g bes>8 8 a8. bes16 a8}
  \new Voice {\voiceTwo <c, f>4 8 c4 8 <c f>4 8}
>>
\oneVoice <bes es g>8. <f' g>16 <es g a>8
<d f bes>4. <bes es g>8 <c es f>4 <bes d f> <es g>8
<c f a>4. <c f g>8 <c e g>4
<d f>8~<d f bes>4 <c f a>8.~<c bes'>16 <c f a>8
<c g'>8 <c g'bes>4 <c f a> <d a'>8 <es g bes>4 <c es a>8
<es f bes>8~<d f bes>4 <es g bes>4~<es a bes>8
<d f bes>4. <c es bes'>8~ <c es a>4 <d f bes>4 8
<c es g>4 <c es a>8 <bes f'bes>4 <d g bes>8
<bes f'bes>8~<bes f'a>~<c es a> <d f bes>4 8 
<es g bes>4 <c f a>8 <bes d bes'>4 <c a'>8
<d f bes>4 <es g bes>8 
<<{\voiceOne bes'8 a4}
  \new Voice {\voiceTwo <c, f>4 8}
>>
\oneVoice <d f bes>2.
\volta 2 \fine
\volta 1 {
  \repeat volta 2 {
r4 <f bes d>8 4 <f a c>8 
<f g c> <d g bes> <es g bes>~8 <f a> es
<d f bes>4. <f bes d>8 8 8 <f a c> <d g bes>4 <d fis a>4.
<d g bes>8 <g bes> <g bes d> <c, g'c>~<d g c> <es g c>
<d g c> <es g b>~<f g b> <es g c>4.
<c g'c>8~<d g c> <es g c> <es f bes>~<d f bes> <f bes d>
<g bes es>~<a es'> <g bes es>
<f bes c> <f a d>~<f a es'> <f bes d> 2.
  }
}
}
}

 

lower = \relative c {
\armure
\lpiano_syle
\repeat segno 2 {
bes4. es8. f16 g8 f4 8 es8. f16 g8 f4. bes,
es8. f16 g8 f4. bes, es8. d16 c8 bes g a~8 4
bes4. f f' f g8. f16 es8 d bes f'~8 es4
d8 bes4 f'4 8 e4 8 f4 8 e4 8 f4 8 e4 8
f8. es16 d8 c4. g' c, g'
c,8. bes16 aes8 g4 8 c8. bes16 aes8 g4. c
c8. 16 bes8 a8. 16 bes8 c8. 16 bes8 a8. 16 bes8
c8. 16 bes8 f'4. bes, f' bes, f4 8 bes8. a16 bes8 
c4. bes8. a16 bes8 f4. bes8 es es bes4 8
c bes aes g4 c8 r4. g' es8 8 8 bes4 8
c bes aes g8. f16 es8~8 bes'4 es, bes'8~8 f4 bes4.
\bar "||"
bes4 8 f'4 8 e4 8 f4 d8 es4. bes4.~8 a4 bes4. f' c
bes f'~8 e4 f4. es bes es bes c bes4 8
c4 8 d d es f4 8 bes,4 8 es8 8 f
g4 8 bes,8 8 8 f4 8 bes2.
\volta 2 \fine
\volta 1 {
  \repeat volta 2 {
  r4 bes8 4 f8~8 g es~8 f4 bes4. 8 8 8
  f8 g4 d'4. g,8 8. f16 es8 d c g'4. c,
  aes' bes es, f bes2.
  }
}
}
}

piano = \new PianoStaff \with { instrumentName = "B.C." 
shortInstrumentName ="B.C."}
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

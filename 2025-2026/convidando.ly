\version "2.24.4"

\header {
  title = "Convidando Està La Noche"
  composer = "Juan Garcia de Zespedes"
  opus = "(1619-1678)"
  tagline = ""
  
}

global = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \time 6/8
  \key f \major
  \tempo 4.=96
  \accidentalStyle modern-cautionary
}

conductor_size = 16


verseOne = \lyricmode {
  \set stanza = "1."
  Con -- vi dan -- do~es -- tà la no -- che
  a -- qui de mu -- ci -- cas va -- rias
  al re -- cién na -- ci -- do~in fan -- te
  can -- ten tier -- nas a -- la -- an -- zas.
  
  Ay que me~a -- bra -- so a -- y,
  di -- vi -- no due -- ño a -- y,
  en la hermo -- su -- ra a -- y,
  de tus o -- jue -- los a -- y,
}

verseTwo = \lyricmode {
  \set stanza = "2."
  A -- le -- gres cuan -- do fes -- ti -- vas
  u -- nas her -- mo -- sas za -- ga -- las
  con no -- vi -- dad en -- to -- na -- ron
  ju -- gue -- tes por la gua -- ra -- cha.
}



solo = \relative c'{
d'8 8 8 c8 4 2\( 8\) r
d e f e8 4 f2\( 8\) r
d8 8 8 c8 4 2\( 8\) r
bes8 8 a g8 4 c2\( 8\) r 
}

sOne = \lyricmode {
  \set stanza = "1."
  Ay que me~a -- bra -- so a -- y,
  Di -- vi -- no due -- ño a -- y,
  En la hermo -- su -- ra a -- y,
  De tus o -- jue -- los a -- y.
}

sTwo = \lyricmode {
  \set stanza = "2."
  Ay co -- mo llue -- ven a -- y,
  Cien -- to lu -- çe -- ros a -- y,
  Ra -- yos de glo -- ria a -- y,
  Ra -- yos de fue -- go a -- y.
}

sThree = \lyricmode {
  \set stanza = "3."
  Ay que la glo -- ria a -- y,
  Del por -- ta -- li -- ño a -- y,
  Y~a vis -- te ra -- yos a -- y,
  Si~a -- rro -- ja -- ya -- los a -- y.
}

sFour = \lyricmode {
  \set stanza = "4."
  Ay que su ma -- dre a -- y,
  Co -- mo~en su~es -- pe -- ra a -- y,
  Mi -- ra~en su lu -- cen-cia a -- y,
  Sus cre -- ci -- mien -- tos a -- y.
}

sFive = \lyricmode {
  \set stanza = "5."
  En la gua -- ra -- cha a -- y,
  Le fes -- ti -- ne -- mos a -- y,
  Mien -- tras el ni -- ño a -- y,
  Se rein -- de~al sue -- ño a -- y.
}

sSix = \lyricmode {
  \set stanza = "6."
  To -- quen y bay -- len a -- y,
  Por -- que te -- ne -- mos a -- y,
  Fue -- go~en la nie -- ve a -- y,
  Nie -- ve~en el fue -- go a -- y.
}

sSeven = \lyricmode {
  \set stanza = "7."
  Pe -- ro~el chi -- co -- te a -- y,
  A~un mis -- to tiem -- po a -- y,
  Llo -- ra y se rie a -- y,
  Que dos es -- tre -- mos a -- y.
}

sEight = \lyricmode {
  \set stanza = "8."
  Paz a los hom -- bres a -- y,
  Dan de los de los a -- y,
  A dios las gra -- cias a -- y,
  Por -- que cal -- le -- mos a -- y.
}


soprano = \relative c'' {
  \repeat volta 2 {
    r8 c8 8 4 8 d c4 a bes8 
    d d d c4 8 d c4 4.
    r8 c4 d8 c4 a8 d d d( cis4)
    d8\breathe 8 8 8 cis4 d8 c4 4. 2.
  }
  R2.*4^"Instru" \break \pageBreak
\repeat volta 8 {
<<\new Voice = "sol" {\solo}
  \addlyrics \sOne
  \addlyrics \sTwo
  \addlyrics \sThree
  \addlyrics \sFour
  \addlyrics \sFive
  \addlyrics \sSix
  \addlyrics \sSeven
  \addlyrics \sEight
>>
\bar "||"\break
d8 8 8 c8 4 2\( 8\) r
d8 8 8 c8 4 2\( 8\) r
f8 8 8 e8 4 f2\( 8\) r
f8 8 8 e8 4 f2\( 8\) r}\fine
}


alto = \relative c' {
  \repeat volta 2 {
  r8 f8 8 e4 f8 8 e4 d4 8
  g g g g4 f8 8 e4 f4.
  r8 a4 d,8 e4 f8 g g e4.
  fis8\breathe g g g f( e) d f f4( e) f2.
  }
  R2.*4  
  \repeat volta 8 {R2.*8
  f8 8 8 e8 4 f2\( 8\) r
  f8 8 8 e8 4 f2\( 8\) r
  bes8 8 a8 g8 4 a2\( 8\) r
  bes8 8 a8 g8 4 a2\( 8\) r
  }
}

tenor = \relative c' {
\repeat volta 2 {
  r8 a'8 8 g4 a8 bes g4 fis g8
  bes8 8 8 4 a8 bes g4 a4.
  r8 a4 bes8 g4 f8 bes8 8 a4.
  a8\breathe bes8 8 8 a( g) f a4 g4. a2.
}
  R2.*4
  \repeat volta 8 {R2.*8
  bes8 8 8 g8 4 a2\( 8\) r
  bes8 8 8 g8 4 a2\( 8\) r
  d8 8 8 c8 4 2\( 8\) r
  d8 8 8 c8 4 2\( 8\) r
  }
}

bass = \relative c {
\repeat volta 2 {
  r8 f8 8 c4 f8 bes, c4 d bes8
  g'8 8 f e4 f8 bes, c4 f4.
  r8 f4 bes,8 c4 d8 g, g a4.
  d8\breathe g, g g a4 bes8 f4 c'4. f2.
}
  R2.*4
  \repeat volta 8 {R2.*8
  bes,8 8 8 c8 4 f,2\( 8\) r
  bes8 8 8 c8 4 f,2\( 8\) r
  bes8 8 8 c8 4 f,2\( 8\) r
  bes8 8 8 c8 4 f2\( 8\) r
  }
}


sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S"} <<
    \global 
    \soprano
\addlyrics \verseOne
\addlyrics \verseTwo
>>

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A"} <<
    \global \alto  
  \addlyrics \verseOne
  \addlyrics \verseTwo
>>

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T"} <<
    \global \tenor  
  \addlyrics \verseOne
  \addlyrics \verseTwo
>>

bas = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B"} <<
    \global \clef bass \bass  
  \addlyrics \verseOne
  \addlyrics \verseTwo
>>



#(set-global-staff-size conductor_size)
\book {
  \score {
        \layout {
  \context {
    \Staff
    \RemoveAllEmptyStaves
  }
}
    \new ChoirStaff
       <<
      \sop
      \alt
      \ten
      \bas
    >>
  }
  \score {
    \unfoldRepeats
      <<
      \sop
      \alt
      \ten
      \bas
    >>
    \midi {}
  }
}

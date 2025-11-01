% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Xicochi Conetzintle"}
  subtitle = "Chanzoneta a4"
  composer = "Gaspar Fernández (1566-1629)"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 3/2
\tempo 2 = 112
\key f \major
}


sop_music = {
  R1.*3 c'2 1 1. 2 1 a1. R1.*3
  f'2 1 e2 c1 d2 c1 a1. R1.*5
  c2 1 d2 c1 a2 bes1 c2 d1 bes1 2 g1.
  f'2 1 2 e1 f2 d1 f2 1 d1 2 e1.
  2 1 f2 d1 f1. d2 c1 d2 e1 f1.
  c1.~2 1 a1. cis1 2~2 bes1 g1. a\fermata\fine
 }


sop_lyrics = \lyricmode {
  Xi -- co -- chi,  xi -- co -- chi,
  xi -- co -- chi co -- net -- zin -- tle
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me, 
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me,
  in an -- ge -- los -- me,
  in an -- ge -- los -- me,
  A -- le -- lu -- ya, a -- le -- lu -- ya.
  
}

sop = \new Staff \with {instrumentName="Soprano I"
  shortInstrumentName ="S. 1"} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
>>

alt_music = {
  c'2 1 1. 2 1 a1. 2 1 2 1 1 2 f'2 1
  e2 c1 d2 c1 a1. r2 e'1 f2 e1 c1.
  c2 1 d2 c1 a2 bes1 c2 d1 bes1 2 g1. R1.*5
  c2 1 d2 c1 a2 bes1 c2 d1 bes1 2 g1.
  c2 1 2 bes1 d1. bes2 a1 g1 2 a1.
  f'1.~2 e1 d1. e1 2~2 d1 c1. c\fermata\fine
}

alt_lyrics = \lyricmode {
  Xi -- co -- chi, xi -- co -- chi, xi -- co -- chi,
  xi -- co -- chi, xi -- co -- chi,
  co -- net -- zin -- tle, co -- net -- zin -- tle
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me, 
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me, 
  in an -- ge -- los -- me,
  in an -- ge -- los -- me,
  A -- le -- lu -- ya, a -- le -- lu -- ya.
}


alt = \new Staff \with {instrumentName="Soprano II"
  shortInstrumentName ="S. 2"} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
>>

ten_music = {
R1.*3 f2 1 1. 2 1 1. R1.*3
a2 1 g2 1 d2 e1 f1. R1.*5
g2 1 d2 e1 f2 d1 a'2 f1 g1 2 e1. 
a2 1 bes2 g1 a2 g1 a2 1 g1 2 1.
g2 1 a2 g1 f1. g2 e f~2 e1 c1.
a'1.~2 g1 f1. e1 a2~2 f1~2 e1 f1.\fermata \fine 
}

ten_lyrics = \lyricmode {
  Xi -- co -- chi, xi -- co -- chi,
  xi -- co -- chi co -- net -- zin -- tle
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me, 
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me, 
  in an -- ge -- los -- me,
  in an -- ge -- los -- me,
  A -- le -- lu -- ya, a -- le -- lu -- ya.
}

ten = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
>>


bass_music = {
  R1.*3 f2 1 1. 2 1 1. R1.*3
  2 1 c'2 1 bes2 c1 f,1. R1.*5
  c'2 1 bes2 a1 f2 g1 a2 bes1 g1 2 c1.
  f,2 1 bes2 c1 f,2 g1f2 d1 g1 2 c,1.
  c'2 1 f,2 g1 d1. g2 a1 bes2 c1 f,1.
  f1.~2 c1 d1. a'1. 2 bes1 c1. f,\fermata\fine
}

bass_lyrics = \lyricmode {
  Xi -- co -- chi, xi -- co -- chi,
  xi -- co -- chi co -- net -- zin -- tle
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me, 
  ca~o -- miz -- hui -- hui -- jo -- co
  in an -- ge -- los -- me, 
  in an -- ge -- los -- me,
  in an -- ge -- los -- me,
  A -- le -- lu -- ya, a -- le -- lu -- ya.
}

bass = \new Staff \with {instrumentName="Men"
  shortInstrumentName ="M."} <<
  \hommes_style
  \armure
  \relative c {\bass_music}
  \addlyrics {\bass_lyrics}
>>

%\include "utils/booksq.ly"

#(set-global-staff-size conductor_size)
\book {
  \score {
        \layout {
  \context {
    \Staff
    \RemoveEmptyStaves
  }
}
    \new ChoirStaff
       <<
%    \new StaffGroup
%    <<
      \sop
      \alt
      \ten
      \bass
%    >>
    >>

  }
  \score {
    \unfoldRepeats
    <<
%      \lead
      \sop
      \alt
      \ten
      \bass
    >>
    \midi {}
  }
}


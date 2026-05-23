% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Alto Zagales"}
  composer = "Juan Gutiérrez de Padilla"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

solo = \markup {\italic [Solo]}
tutti = \markup {\italic [Tutti]}


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 3/8
\tempo 4. = 72
\key c \major
}

coplas_tres = \lyricmode {
  \set stanza = "3."
  Va de pen -- sa -- do, va de -- re -- pen -- te,
  va -- ya de co -- pla ro -- da -- da~y co -- rrien -- te.
  }
coplas_cinq = \lyricmode {
  \set stanza = "5."
  Va -- ya~a las per -- las que se des -- gra -- nan
  cuan -- do su pe -- cho de~a -- mo -- res se~a -- bra -- za.
  }
coplas_sept = \lyricmode {
  \set stanza = "7."
  De -- jan las cho -- zas los ga -- na -- de -- ros,
  con la co -- di -- cia de ver un cor -- de -- ro.
  }
coplas_neuf = \lyricmode {
  \set stanza = "9."
  Le -- cho de pa -- jas la ha~na -- pres -- ta -- do
  al Sol her -- mo -- so que na -- ce tem -- blan -- do.
  }
coplas_onze = \lyricmode {
  \set stanza = "11."
  A los a -- rru -- llos de~u -- na pa -- lo -- ma
  tier -- no des -- can -- sa, dor -- mi -- do re -- po -- sa.
  }
coplas_treize = \lyricmode {
  \set stanza = "13."
  Cuan -- do se rí -- en sus dos cla -- ve -- les
  to -- das la glo -- rias del cie -- lo se vier -- ten.
  }
coplas_quinze = \lyricmode {
  \set stanza = "15."
  Flo tie -- ne~el he -- no, fru -- to la pa -- ja
  pues su a -- ris -- tas flo -- re -- cen y gra -- nan.
  }


coplas_quatre = \lyricmode {
  \set stanza = "4."
  Chis -- te fes -- ti -- vo, chis -- te de -- cent -- te,
  mo -- te pi -- can -- te, con -- cep -- to su -- til.
  }
coplas_six = \lyricmode {
  \set stanza = "6."
  Dul -- ces in -- cen -- dios quie -- bran en a -- gua,
  cuan -- do sus -- pi -- ra la más va -- ro -- nil.
  }
coplas_huit = \lyricmode {
  \set stanza = "8."
  Paz de la Tie -- rra, glo -- ria del Cie -- lo
  por quien se --  gu -- ro se que da~el re -- dil.
  }
coplas_dix = \lyricmode {
  \set stanza = "10."
  Y por -- que duer -- ma más so -- se -- ga -- do
  los ai -- re -- ci -- llos le van a mu -- llir.
  }
coplas_douze = \lyricmode {
  \set stanza = "12."
  De su re -- ga -- zo for -- ma~el au -- ro -- ra,
  cu -- na de pla -- ta si -- tial de jaz -- mín.
  }
coplas_quatorze = \lyricmode {
  \set stanza = "14."
  Na -- cen a -- bri -- les, ma -- yos flor -- re -- cen,
  vis -- te -- se~el cam -- po flo -- ri -- do ma -- tiz.
  }
coplas_seize = \lyricmode {
  \set stanza = "16."
  U -- nas re -- co -- gen o -- tras en -- sar -- tan,
  hi -- los de per -- las que llo -- ra~un ru -- bí.
  }


sola_music = {
  \partial 4. c'8 g g \bar "||"
  r2. c8^\solo g g c c8. b16 a8 a a
  d d8. c16 b8 8. a16 g8 8 8 c8 8. b16 a4 8 r d d
  cis d d a b8. c16 d8 g,8. a16 b8 c c c b8. 16 c4.
  r8 8. d16 e8 d d c b a b4.\fermata \bar "||"
  R4.*33 \break r4 b8~8 a4 \bar "||"
  \repeat segno 2 {
  b8 8 c d4 8 e e e e d d
  e c c c4 8 4.~c~c
  r4. r4 d8 a a a a b d c a4 b8 8 c
  d e4 d4 8 e e e d4. r8 b b a a4 b4.\fermata
  \volta 2 \fine
  \volta 1 {
    \repeat volta 2 {
    b8^\solo c d e c4 8 b b a b4
    a8 a b c b a b c a b c4 \bar "||"
    R4.*8
    } r4 b8~8 a4 \bar "||"
  }
  }
}

sola_lyrics = \lyricmode {
 Al -- to za...
 Al -- to, za -- ga -- les de to -- do~el e -- ji -- do
 al sol que~ha na -- ci -- do ga -- lán y pu -- li -- do
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril.
 
 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril, __
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril.
 
\set stanza = "1."
Va -- ya de gus -- tos, va -- ya de~a mo -- res,
al so -- le -- si -- co, que na -- ce de no -- che.

Al chaz
}


sola = \new Staff \with {instrumentName="Sop. Solo"
  shortInstrumentName ="S. 1"} <<
  \soprano_style
  \armure
  \relative c' {\sola_music}
  \addlyrics {\sola_lyrics}
  \addlyrics {\lyricmode {\repeat unfold 97 {""}} \coplas_tres}
  \addlyrics {\lyricmode {\repeat unfold 97 {""}} \coplas_cinq}
  \addlyrics {\lyricmode {\repeat unfold 97 {""}} \coplas_sept}
  \addlyrics {\lyricmode {\repeat unfold 97 {""}} \coplas_neuf}
  \addlyrics {\lyricmode {\repeat unfold 97 {""}} \coplas_onze}
  \addlyrics {\lyricmode {\repeat unfold 97 {""}} \coplas_treize}
  \addlyrics {\lyricmode {\repeat unfold 97 {""}} \coplas_quinze}
>>

alta_music = {
  \partial 4. g'8 d d \bar "||"
  g^\solo d d g g8. f16 e8 8 8 a a8. g16 fis8 8. e16
  d8 8 8 g8 8. f16 e4. e r8 f f e f8. g16
  a8 g g fis g g d e8. f16 g8 e4 f8 d8. 16 e8 a a
  g a a g4 8~8 fis4 g4.\fermata \bar "||"
  R4.*33 r4 g8~8 fis4 \bar "||"
  \repeat segno 2 {
  g8 8 8 4 f8 e e e e g g 
  e e d c4 e8 c4.~c r8 f f
  d a'4 4 8 fis8 8 8 8 g g g fis4 g4.
  r8 e e a g4 e4 8 fis8 8 8 8 g g g fis4 g4.\fermata
  \volta 2 \fine
  \volta 1 {
   \repeat volta 2 {
  g8^\solo 8 f e a4 8 g g fis g4
  f8 e d e e f d c c d e4 \bar "||"
  R4.*8 } r4 g8~8 fis4 \bar "||"
  }
}}

alta_lyrics = \lyricmode {
 Al -- to za...
 Al -- to, za -- ga -- les de to -- do~el e -- ji -- do
 al sol que~ha na -- ci -- do ga -- lán y pu -- li -- do
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril.

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril, __
con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril.
 
\set stanza = "1."
Va -- ya de gus -- tos, va -- ya de~a mo -- res,
al so -- le -- si -- co, que na -- ce de no -- che.

Al chaz
}


alta = \new Staff \with {instrumentName="Alt. Solo"
  shortInstrumentName ="A. 1"} <<
  \soprano_style
  \armure
  \relative c' {\alta_music}
  \addlyrics {\alta_lyrics}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_tres}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_cinq}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_sept}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_neuf}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_onze}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_treize}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_quinze}
>>


tena_music = {
  \partial 4. c'8 g g
  r4. c8^\solo g g c c8. b16 a8 8 8 d d8. c16
  b8 8. a16 g8 8 8 c c8. b16 a4 8 r d d cis d d
  a b8. c16 d8 g,8. a16 b8 c c g a4 f8 g8. 16 c8 f f 
  e f f c b4 a4. g\fermata \bar "||"
  R4.*33 r4 g8~8 d'4 \bar "||"
  \repeat segno 2 {
  g,8 8 a b4 8 c c c g g g 
  g g g g4 c8 f,4 8 g g g c4.
  r4. r4 a8 d d d d b b c d4 4.
  r8 g, g a b4 g c8 a a a a b g a4 d8 b4.\fermata
  \volta 2 \fine
  \volta 1 {
    \repeat volta 2 {
    g8^\solo a b c a4 8 b c d g,4
    d'8 c b a g f g a a g c,4 \bar "||"
    R4.*8 } r4 g'8~8 d'4 \bar "||"
  }
  }
}

tena_lyrics = \lyricmode {
 Al -- to za...
 Al -- to, za -- ga -- les de to -- do~el e -- ji -- do
 al sol que~ha na -- ci -- do ga -- lán y pu -- li -- do
 en di -- ciem -- bre me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, me -- jor, que~en a -- bril, 
 en di -- ciem -- bre me -- jor, que~en a -- bril.

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán
  y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril.
 
\set stanza = "1."
Va -- ya de gus -- tos, va -- ya de~a mo -- res,
al so -- le -- si -- co, que na -- ce de no -- che.

Al chaz
}


tena = \new Staff \with {instrumentName="Ten. Solo"
  shortInstrumentName ="T. 1"} <<
  \tenor_style
  \armure
  \relative c' {\tena_music}
  \addlyrics {\tena_lyrics}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_tres}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_cinq}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_sept}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_neuf}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_onze}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_treize}
  \addlyrics {\lyricmode {\repeat unfold 104 {""}} \coplas_quinze}
>>


sop_music = {
  \partial 4. g'8 d d 
  R4.*21 \break
  R4.*2 g8^\tutti d d g g8. f16 e8 4 a4 8 g8 4
  a4 e8 f f f~f e e d d g g g fis
  g4 8 a g f e4 a8 g a8. 16 g8 a4
  r4 8 g a8. 16 g8 a8. 16 g8 e4 f8 8 d~
  8 e4 d8 b c d4 8 e e e d d d
  d g g f d4 e4 8 fis8 8 8 8 g g
  g fis4 g4. r \bar "||"
  \repeat segno 2 {
  r4. r r4 8~8 4 8 e f g4 8 a a a g g g g a a
  g e4 fis4. r r r r4 d8
  g g g f e e g4 a8 4. r8 d, b e d4 4.\fermata
  \volta 2 \fine \break
  \volta 1 {
  \repeat volta 2 {
  R4.*8 \break e8^\tutti f g a f4 8 e e d e4 d8 8 e
  f g f e fis8 8 g4.
  } R4.*2 \bar "||"
  }
  }
}

sop_lyrics = \lyricmode {
Al -- to za...
Al -- to za -- ga -- les de mil en mil, de mil en 
mil, nin -- gún pe -- li -- gro re -- ce -- la y to -- do pas -- 
tor, a más y me -- jor, 
re -- pi -- que, re -- pi -- que,
re -- pi -- que, re -- pi -- que,
la fo -- li -- güe -- la, al
chaz -- chaz con la cas -- ta ñue -- la
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 con el tam -- bo -- ril.
 

\set stanza = "2."
Va -- ya de ra -- yos, va -- ya de~a do -- res,
va -- ya de nue -- vo, bri -- llar y lu -- cir.

}

sop = \new Staff \with {instrumentName="Sop./Alt."
  shortInstrumentName ="S.A. II"} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
  \addlyrics {\lyricmode {\repeat unfold 114 ""} \coplas_quatre}
  \addlyrics {\lyricmode {\repeat unfold 114 ""} \coplas_six}
  \addlyrics {\lyricmode {\repeat unfold 114 ""} \coplas_huit}
  \addlyrics {\lyricmode {\repeat unfold 114 ""} \coplas_dix}
  \addlyrics {\lyricmode {\repeat unfold 114 ""} \coplas_douze}
  \addlyrics {\lyricmode {\repeat unfold 114 ""} \coplas_quatorze}
  \addlyrics {\lyricmode {\repeat unfold 114 ""} \coplas_seize}
>>

ten_music = {
  \partial 4. d'8 a a
  R4.*21 \break
  d8^\tutti a a d d8. c16 b8 4 e4 8 c8 4 f4 8 e8 4
  cis4 8 d a d~8 c c b b b e d c
  b4 e8 a, b b c4. r4 f8 e f8. 16 
  c8 f4 r4 8 e a,8. 16 b8 cis4 d8 8 b~
  8 c4 b8 g a b4 8 c c c b b b b e e a, b4 c4 8 a8 8 8 8 d d
  c a4 b4. r \bar "||"
  \repeat segno 2 {
  r4. r r4 c8~8 d4 c8 c d e4 8 f f f e e e e a, a
  b cis4 d4. r r r4 d8 b b b
  b c c d d4 c4. d8 8 8 8 8 8 c a4 g4.\fermata
  \volta 2 \fine
  \volta 1 {
  \repeat volta 2 {
  R4.*8 c8^\tutti b b a d4 8 c c b c4 b8 a g
  a8 8 d c a a b4.
  } \break R4.*2 \bar "||"
  }
  }
}

ten_lyrics = \lyricmode {
Al -- to za...
Al -- to za -- ga -- les de mil en mil, 
de mil en mil, de mil en 
mil, nin -- gún pe -- li -- gro re -- ce -- la y to -- do pas -- 
tor, a más y me -- jor, 
re -- pi -- que, re -- pi -- que,
re -- pi -- que
la fo -- li -- güe -- la, al
chaz -- chaz con la cas -- ta ñue -- la
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,

 al chaz -- chaz con la cas -- ta -- ñue -- la
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 ta -- pa -- la -- tán con el tam -- bo -- ril.
 

\set stanza = "2."
Va -- ya de ra -- yos, va -- ya de~a do -- res,
va -- ya de nue -- vo, bri -- llar y lu -- cir.
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T. II"} <<
  \tenor_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
  \addlyrics {\lyricmode {\repeat unfold 119 ""} \coplas_quatre}
  \addlyrics {\lyricmode {\repeat unfold 119 ""} \coplas_six}
  \addlyrics {\lyricmode {\repeat unfold 119 ""} \coplas_huit}
  \addlyrics {\lyricmode {\repeat unfold 119 ""} \coplas_dix}
  \addlyrics {\lyricmode {\repeat unfold 119 ""} \coplas_douze}
  \addlyrics {\lyricmode {\repeat unfold 119 ""} \coplas_quatorze}
  \addlyrics {\lyricmode {\repeat unfold 119 ""} \coplas_seize}
>>

bass_music = {\partial 4. g'8 d d
  R4.*21 \break
  R4. g8^\tutti d d g8 8. f16 e8 4 a4 8 f f f c' b4
  a4 a,8 d d d~d e f g g g c b a
  g4 e8 f e d c4 f8 e f8. 16 c8 f4
  r4 8 e f8. 16 c8 f8. 16 g8 a4 d,8 8 g~
  8 c,4 g'4.~g r4 c,8 g' g g g e e f g4 c, a8 d d d d b b
  c d4 g,4. r \bar "||"
  \repeat segno 2 {
  r4. r r4 c8~8 g4 c4.~c r4 f8 c c c c f f
  g a4 d,4. r r r4 d8 g g g g e e f g4
  c, a8 d d d d b b c d4 g,4.\fermata
  \volta 2 \fine
  \volta 1 {
  \repeat volta 2 {
  R4.*8 c8^\tutti d e f d4 8 e f g c,4 g'8 f e
  d c b c d d g,4. 
  } R4.*2 \bar "||"
  }
  }
}

bass_lyrics = \lyricmode {Al -- to za...
Al -- to za -- ga -- les de mil en mil, 
de mil en __ _  mil, en 
mil, nin -- gún pe -- li -- gro re -- ce -- la y to -- do pas -- 
tor, a más y me -- jor, 
re -- pi -- que, re -- pi -- que,
re -- pi -- que, re -- pi -- que,
la fo -- li -- güe -- la, al
chaz -- chaz __
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
y~al ta -- pa -- la -- tán con el tam -- bo -- ril,

 al chaz -- chaz __ 
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril,
 y~al ta -- pa -- la -- tán con el tam -- bo -- ril.
 

\set stanza = "2."
Va -- ya de ra -- yos, va -- ya de~a do -- res,
va -- ya de nue -- vo, bri -- llar y lu -- cir.
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B. II"} <<
  \hommes_style
  \armure
  \relative c {\bass_music}
  \addlyrics {\bass_lyrics}
  \addlyrics {\lyricmode {\repeat unfold 110 ""} \coplas_quatre}
  \addlyrics {\lyricmode {\repeat unfold 110 ""} \coplas_six}
  \addlyrics {\lyricmode {\repeat unfold 110 ""} \coplas_huit}
  \addlyrics {\lyricmode {\repeat unfold 110 ""} \coplas_dix}
  \addlyrics {\lyricmode {\repeat unfold 110 ""} \coplas_douze}
  \addlyrics {\lyricmode {\repeat unfold 110 ""} \coplas_quatorze}
  \addlyrics {\lyricmode {\repeat unfold 110 ""} \coplas_seize}
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
<<
    \new ChoirStaff
    <<
      \sola
      \alta
      \tena
    >>
    \new ChoirStaff
    <<
      \sop
      \ten
      \bass
    >>
>>
  }
   \score {
    \unfoldRepeats
    <<
      \sola
      \alta
      \tena
      \sop
      \ten
      \bass
    >>
    \midi {}
  }
}


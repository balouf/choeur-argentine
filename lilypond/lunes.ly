% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Lunes Otra Vez"
  subtitle = ""
  composer = "Eduardo Correa"
  tagline = ""

}

conductor_size = 18
individual_size = 20

\include "utils/macros.ly"
\include "swing.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 4/4
\tempo \markup {
    Swing
    \hspace #0.4
    \rhythm { 8[ 8] } = \rhythm { \tuplet 3/2 { 4 8 } }
  }  4 = 132
\key d \major
}

cross = 
#(define-music-function
  (notes)
  (ly:music?)
  #{
  \override NoteHead.style = #'cross
  #notes
  \revert NoteHead.style

  #})

ghost = 
#(define-music-function
  (notes)
  (ly:music?)
  #{
  \hideNotes
  #notes
  \unHideNotes
  #})


sop_music = {
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
  \set Timing.beatStructure = 1,1,1,1
  \override Glissando.style = #'zigzag
  \partial 4 r4
  r a'^"Sonidos de pato" gis2
  g8 8~8 fis8~4 d'->^"Resfriado"
  b8 8~8 8~ 2*1/2\>\glissando \ghost {d4}
  a8\! 8~8 8~  2*1/2\>\glissando \ghost {b4}
  r\! a gis2
  g8 8~8 fis8~4 d'
  b4. a r4
  r2 r4 b8\< a~ 4\!\fermata r
  \cross {a8\fff 8~^\markup {\italic "¡Exclamado!"}4}
  \bar "||"
  8 8~8 b8~4 a8 fis~2 r
  e8 fis~8 g~4 a8 8~2~2
  a8 8~8 b~4 a8 fis~2 r
  g8 8~8 8~4 a8 8~2~2
  a2\cresc ais b8 cis~8 d~2
  r1
  a8-> 8~8 8~4 
  d,8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~4
  r r2
  r8 gis~\sfz8 a~4 r4
  8 8~8 b~4 a8 fis~2 r
  e8 fis~8 g~4 a8 8~2\<~2
  d8\ff 8~8 8~4 4
  4. 4. r4
  8^"Solo sop." a8 b a~4 e8 d~2 r 
  \bar"||" \mark \markup { \musicglyph "scripts.ufermata" }
  a'2\mp ais b8 cis~8 d~2 r1
  a8\f 8~8 8~4
  d,8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~4 r r2
  r8 gis\sfz~8 a~4 r \bar "||"
  b8^"¡Rock!" a b a b a b a b4 8 8~2
  b8 a b a b a b a d4 b8 a~2
  b8^"va cresc." a b a b4 8 a b4 8 8~4 8 8
  cis\p 8^"Subito y estático" 8 8 8 8 8 d e4 d8 cis~4\fermata \caesura r \bar "||"
  r a^"Vuelven los patos" gis2 
  g8 8~8 fis~4 d'->
  b8 8~8 8~2
  a8 8~8 8~2
  a8\mp a~8 b~4 a8 fis~2 r
  e8 fis~8 g~4 a8 8~2~2
  a8 a~8 b~4 a8 fis~2 r
  g8 g~8 g~4 a8 8~2~2
  2\p ais b8 cis~8 d~2
  d4^"sonoro" 4 4 8 cis~2 r4
  d,8^"legato" e fis a~8 b~8 a f d
  e4 r8 g g g~8 fis~2 g2\p fis r4
  d8\p\< e fis a~8 b~8 a f d
  e4 g a b d1\ff\fermata^"¡VIBRATO!"
  r2^"Lento" r4 b8\< a~4\fermata\! r^"Ad libitum"
  a8 b d^"rit." b d1~\fff 4 \cross d, r2 \fine
 }


sop_lyrics = \lyricmode {
  Cua cua cua -- rac __ cua, __ cua?
  Lu -- nes, uh __ \markup \italic "¡Caída!"
  Lu -- nes, uh; __ _
  cua cua cua -- rac __ cua, __ cua?
  chiu -- rap, lu -- nes, __ ¡LU -- NES!
  
  Lu -- nes __ o -- tra vez __
  so -- bre __ la __ ciu -- dad, __
  la gen -- te __ que ves __
  vi -- ve~en so -- le -- dad. __
  
  So bre~el bos -- que __ gris __
  mue -- re~el sol __ 
  que ma -- ña -- na __ so -- bre 
  la~a -- ve -- ni -- da __ na -- ce -- rá. __
  
  Cuá __ cuá. __ 
  Ca -- lles __ sin __ co -- lor __
  ves -- ti -- das __ de gris, __
  des -- de __ mi __ ven -- ta -- na __
  ve -- o~el ver -- de __ ta piz __
  
  de~u -- na pla -- za __ que __
  mo -- ri -- rá, __ 
  y muer -- to el __ ver -- de, 
  só -- lo hie -- rro __ cre -- ce -- rá. __
  
  Cuá __ cuá. __
  Vie -- jas en la~es -- qui -- na men -- di gan su -- pan, __
  en las o -- fi -- ci -- nas muer -- te~en so -- cie -- dad. __
  To -- dos cie -- gos hoy sin sa -- ber mi -- rar __
  la~es --  pan -- to -- sa ri -- sa de la pá -- li -- da ciu -- dad. __

  Cua cua cua -- rac __ cua, __ cua?
  Lu -- nes, uh __ 
  Lu -- nes, uh __ 

  Lu -- nes __ o -- tra vez __
  so -- bre __ la __ ciu -- dad, __
  la gen -- te __ que ves __
  vi -- ve~en so -- le -- dad. __
  
  Siem -- pre se -- rá~i -- gual, __
  nun -- ca cam -- bia -- rá. __
  Lu -- nes es el __ dí -- a tris -- te~y gris
  de so -- le -- dad, __ chiu rap,
  
  pa -- ba da -- bap __ da -- ba -- da -- ba -- da,
  bua bua bua bua.
  Vier -- nes __ o -- _ _ tra vez. __ Uffff!!!

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
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
  \set Timing.beatStructure = 1,1,1,1
  \partial 4 r4
  r fis eis2
  e8 8~8 dis8~2
  r4 d8 8~4\> cis
  r\! fis8 8~4 \cross {fis^"sin altura"}
  r fis eis2
  e8 8~8 dis8~2
  d4. cis4. r4
  r4 g'8\< fis~2
  \cross {d8\!^\markup {\italic "¿Sorpresa?"} a' r4 8\fff 8~4}
  \bar "||"
  fis4. eis\( 8\)-. r
  e4. dis\( 8\)-. r
  d8 8~8 e~4 eis8 fis~4. e8~2
  fis8 8~8 eis8~4 cis8 e~4. dis8~2
  d8 8~8 e~4 eis8 fis~2 a8-> 8~4
  fis2\cresc e d8 e~8 f~2
  d8 8 e fis~4 d e2 r4
  d8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~4
  r4 r2
  r8 eis\sfz~8 fis~4 r4
  r4 4\ppp eis2 e8 8~8 dis~2
  r4 d8-> 8~4 cis
  r4 fis8-> 8~4 \cross{4}
  8\ff a~8 gis~4 e g4. fis r4 r1
  r4 g8 fis~4
  \cross{d8
  ^\markup{\override #'(baseline-skip . 1)
    \left-column { \box \tiny \left-column{ "Momento histericó de"
                                        "las contraltos: el coro se" 
                                        "espanta y el calderón"
                                        "recompone la escena."}
  \huge ↓}} %\once \override NoteColumn.X-offset = #16
  a'}
  \bar"||" \mark \markup { \musicglyph "scripts.ufermata" }
  fis2 e d8 e~8 f~2
  d8^"Contralto como pato resfriado" 8 e fis~4 a4 e2 r4
  d8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~4 r r2
  r8 eis\sfz~8 fis~4 r \bar "||"
  f8 8 8 8 8 8 g f g4 8 8~2
  a8 8 8 8 8 8 g8 fis a4 g8 fis~2
  f8 8 8 8 4 g8 f g4 8 8~4 8 gis
  a8 8 gis8 8 g fis e fis a4 gis8 g~4\fermata \caesura r \bar "||"
  r4 fis eis2 e8 8~8 dis~2
  r4 d8 8~4 cis r fis8 8~4 \cross {4}
  fis4.\mp eis\( 8\)-. r
  e4. dis\( 8\)-. r
  d8 8~8 e~4 eis8 fis~4. e8~2
  fis8 8~8 f~4 cis8 e~4. dis8~2
  d8 8~8 e~4 eis8 fis~2 a8-> 8~4
  fis2\p e d8 e~8 f~2
  g4 a4 b4 8 e,~2 r4
  d8 e fis a~8 b~8 a f d
  e4 r8 e d cis~8 d~2 d2\p d r4
  d8\p\< e fis a~8 b~8 a f d
  e4 d d d g1\ff\fermata
  r4 g8\< fis~2~ 4\fermata\! r a,8 b d b fis'1~\fff 4 \cross d r2 \fine
  }

alt_lyrics = \lyricmode {
  Cua cua cua -- rac __ cua, __ 
  Lu -- nes, __ uff!!
  Lu -- nes, __  pfff;
  cua cua cua -- rac __ cua, __
  chiu -- rap, lu -- nes, __  ¿lu -- nes? ¡LU -- NES!
  
  Chiu -- ru -- p,
  Chiu -- ru -- p,
  so -- bre __ la __ ciu -- dad, __ _
  la gen -- te __ que ves __ _
  vi -- ve~en so -- le -- dad, __
  
  lu -- nes. __
  
  So bre~el bos -- que __ gris __
  ve -- o mo -- rir __ al sol
  que ma -- ña -- na __ so -- bre 
  la~a -- ve -- ni -- da __ na -- ce -- rá. __
  
  Cuá __ cuá. __ 
  Cua cua cua -- rac __ cua, __
  Lu -- nes, __ uff!
  Lu -- nes, __  pfff,
  des -- de __ mi __ ven -- ta -- na __
  lu -- nes, __ ¡¡¡Lu -- nes!!!
  
  de~u -- na pla -- za __ que __
  ma -- ña -- na
  mo -- ri -- rá, 
  y muer -- to el __ ver -- de, 
  só -- lo hie -- rro __ cre -- ce -- rá. __
  
  Cuá __ cuá. __
  Vie -- jas en la~es -- qui -- na men -- di gan su -- pan, __
  en las o -- fi -- ci -- nas muer -- te~en so -- cie -- dad. __
  To -- dos cie -- gos hoy sin sa -- ber mi -- rar __
  la~es --  pan -- to -- sa ri -- sa de la pá -- li -- da ciu -- dad. __

  Cua cua cua -- rac __ cua, __ 
  Lu -- nes, uff! 
  Lu -- nes, pfff;
  chiu -- ru -- p
  chiu -- ru -- p
  

  so -- bre __ la __ ciu -- dad, __ _
  la gen -- te __ que ves __ _
  vi -- ve~en so -- le -- dad, __
  lu -- nes. __
  
  Siem -- pre se -- rá~i -- gual, __
  nun -- ca cam -- bia -- rá. __
  Lu -- nes es el __ dí -- a tris -- te~y gris
  de so -- le -- dad, __ chiu rap,
  
  pa -- ba da -- bap __ da -- ba -- da -- ba -- da,
  bua bua bua bua.
  Mar -- tes __ o -- _ _ tra vez. __ Uffff!!!
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
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
  \set Timing.beatStructure = 1,1,1,1
  \partial 4 r4
  r c' b2
  bes8 8~8 a8~4 \tuplet 3/2 {a8 b a}
  gis4~8 8~4 \tuplet 3/2 {g8 a g}
  fis8 a~8 d^"trompetas"~2\>
  r4\! c b2
  bes8 8~8 a~4 \tuplet 3/2 {a8 b a}
  gis8 b d fis e d b a d\< a~4~2~4\fermata\!
  r \cross {d8\fff 8~4}
  \bar "||"
  d4. cis\( 8\)-. r
  r8 a fis'4 eis8 fis~4
  <d g,>4. <cis a>\( 8\)-. r
  \cross {<d a>2} b8-> a~4
  d8 8~8 cis~4 a8 c~4. b8~2
  <b e,>4. 4. \cross {a4}
  <d fis,>8 8~8 <f g,>~8 <e gis,> <d a>4
  d2\cresc cis b8 a~8 b~2 r1
  d8-> 8~8 cis~4
  d,8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~8
  d' b a b a fis e d b'~\sfz8 a~4 r r c\ppp b2 
  bes8 8~8 a~4 \tuplet 3/2 {a8 b a}
  gis4. 4. \tuplet 3/2 {g8 a g} fis8 a~8 d~2
  a8\ff 8~8 b~4 4 bes4. a r4 r1 d8 a~4~2
  \bar"||" \mark \markup { \musicglyph "scripts.ufermata" }
  d2\mp cis b8 a~8 b~2 r1
  d8\f 8~8 cis~4
  d,8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~8
  d'8 b a b a fis e 
  d8 b'\sfz~8 a~4 r \bar "||"
  d8 8 8 8 8 8 8 8 4 8 f~2
  c8 8 8 8 8 8 d c d4 8 8~2
  8 8 8 8 4 8 8 4 8 f~4 d8 8
  e8 8 8 8 8 8 8 d cis4 d8 e~4\fermata \caesura r \bar "||"
  r c b2 bes8 8~8 a~4 \tuplet 3/2 {a8 b a}
  gis4. 4. \tuplet 3/2 {g8 a g}
  fis8 a~8 d~2
  d4.\mp cis\( 8\)-. r
  r8 a fis'4 eis8 fis~4
  <d g,>4. <cis a>\( 8\)-. r
  \cross {<d a>2} b8-> a~4
  d8 8~8 cis~4 a8 c~4. b8~2
  <b e,>4. 4. \cross {a4}
  <d fis,>8 8~8 <f g,>~8 <e gis,> <d a>4
  d2\p cis b8 a~8 b~2
  b4 d4 f4 e8 a,~2 r4
  d,8 e fis a~8 b~8 a f d
  e4 r8 b' b a~8 a~2 b2\p a r4
  d,8\p\< e fis a~8 b~8 a f d
  e4 b' a gis b1\ff\fermata
  d8\< a~4~2~4\fermata\! r a8 b d b d1~\fff 4 \cross 4 r2 \fine
}

ten_lyrics = \lyricmode {
  Cua cua cua -- rac __ cua, __ 
  da -- ra -- ba dun __ dun, __ 
  da -- ra -- ba da ba __ ba; __
  cua cua cua -- rac __ cua, __
  da -- bi -- ri da -- bi -- ra -- ba di -- bi -- ri -- ba,
  lu -- nes, __  ¡LU -- NES!
  
  Chiu -- ru -- p,
  du -- bap bi -- bap, __
  Chiu -- ru -- p,
  pfff, lu -- nes,  __
  la gen -- te __ que ves __ _
  vi -- ve, __ pfff, 
  vi -- ve~en so -- le -- dad.
    
  So bre~el bos -- que __ gris __
  mue -- re~el sol __
  que ma -- ña -- na __ so -- bre 
  la~a -- ve -- ni -- da __ na -- ce -- rá. __
  Chiu -- ru -- ru du -- bi da -- bi -- ru.
  
  
  Cuá __ cuá. __ 
  Cua cua cua -- rac __ cua, __
  da -- ra -- ba dun __ dun __ 
  da -- ra -- ba da -- ba __ ba, __
  des -- de __ mi __ ven -- ta -- na __
  lu -- nes, __ 
  
  de~u -- na pla -- za __ que __
  mo -- ri -- rá, 
  y muer -- to el __ ver -- de, 
  só -- lo hie -- rro __ cre -- ce -- rá. __
  Chiu -- ru -- ru du -- bi da -- bi -- ru.

  
  Cuá __ cuá. __
  Vie -- jas en la~es -- qui -- na men -- di gan su -- pan, __
  en las o -- fi -- ci -- nas muer -- te~en so -- cie -- dad. __
  To -- dos cie -- gos hoy sin sa -- ber mi -- rar __
  la~es --  pan -- to -- sa ri -- sa de la pá -- li -- da ciu -- dad. __

  Cua cua cua -- rac __ cua, __ 
  da -- ra -- ba dun __ dun __ 
  da -- ra -- ba da -- ba __ ba; __
  chiu -- ru -- p
  du bap bi bap,
  chiu -- ru -- p
  

  pfff,  ul -- nes, __
  la gen -- te __ que ves __ _
  vi -- ve, __ pfff,
  vi -- ve~en so -- le -- dad.
  
  Siem -- pre se -- rá~i -- gual, __
  nun -- ca cam -- bia -- rá. __
  Lu -- nes es el __ dí -- a tris -- te~y gris
  de so -- le -- dad, __ chiu rap,
  
  pa -- ba da -- bap __ da -- ba -- da -- ba -- da,
  bua bua bua bua.
  Lu -- nes __ o -- _ _ tra vez. __ Uffff!!!
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
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
  \set Timing.beatStructure = 1,1,1,1
  \partial 4 
  \tuplet 3/2 {a,8 b cis} d2 cis
  c8 8~8 b~2 
  e8 8 8 8 a,2\>
  d8\! 8 8 8 a4
  \tuplet 3/2 {8 b cis} d2 cis
  c8 8~8 b~2
  e4. a,4. r4
  r2 e'8\< d~4~4\fermata\! r
  \cross {a'8\fff 8~4} \bar "||"
  <a d,>4. <gis cis,>\( 8-.\) r
  <g c,>4. <fis b,>\( 8-.\) r
  g,4 b a r8 8 d4 cis b a
  <d a'>8 8~8 <cis gis'>~4 <cis a'>8 <c g'>~4. <b fis'>8~2
  g4 b a r8 8 d4 cis b a
  d2\cresc fis b,8 a~8 gis~2 r1
  <a a'>8-> 8~8 8~4
  d8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~4 r r2
  r8 8\sfz~8 8~4 \tuplet 3/2 {a8\f b cis}
  d2\ppp cis c8 8~8 b~2
  e8^\markup {\italic "¡Exclamado!"} 8 8 8 a,2
  d8\< 8 8 8 a4\! r
  d8\ff 8~8 f~4 4 e4. d r4 r1
  r2 e8 d~4
  \bar"||" \mark \markup { \musicglyph "scripts.ufermata" }
  d2 fis b,8 a~8 gis~2 r1
  <a a'>8\f 8~8 8~4
  d8\mp e fis a~8 b~8 a f d e d~8 b~8 d~8 8~4 r r2
  r8 d\sfz~8 d~4 r \bar "||"
  g,8 8 b b d d e d f4 e8 d~2
  d8 8 fis8 8 a a b a c4 b8 a~2
  g,8 8 b b d4 e8 d f4 e8 d~4 8 8
  <a a'>8 8 8 8 8 8 8 8 4 8 8~4\fermata \caesura 
  \tuplet 3/2 {a8 b cis} \bar "||"
  d2 cis c8 8~8 b~2
  e8 8 8 8 a,2
  d8 8 8 8 a4 \tuplet 3/2  {a8 b cis}
  <d a'>4.\mp <cis gis'>\( 8\)-. r
  <c g'>4. <b fis'>\( 8\)-. r
  g4 b a r8 8 d4 cis b a
  <d a'>8 8~8 <cis gis'>~4 <cis a'>8 <c g'>~4. <b fis'>8~2
  g4 b a r8 8 d4 cis b a
  d2\p fis b,8 a~8 gis~2
  <e e'>4 <fis fis'>4 <g g'>4 <gis gis'>8 <a a'>~2 r4
  d8 e fis a~8 b~8 a f d
  e4 r8 e e a,~8 d~2 d2\p d r4
  d8\p\< e fis a~8 b~8 a f d
  e4 g fis f e1\ff\fermata
  r2 e8\< d~4~4\fermata\! r a8 b d b 
  <d a'>1~\fff 4 \cross 4 r2 \fine
  
}

bass_lyrics = \lyricmode {
  Da -- ra -- ba dun  dun, da ba __ da, __
  Lu -- nes o -- tra vez,
  Lu -- nes o -- tra vez;
  da -- ra -- ba dun  dun, da ba __ da, __
  chiu -- rap,
  lu -- nes, __  ¡LU -- NES!
  
  Chiu -- ru -- p,
  Chiu -- ru -- p,
  dun dun dun pa dun dun dun dun
  la gen -- te __ que ves __ _
  dun dun dun pa dun dun dun dun
    
  So bre~el bos -- que __ gris __
  mue -- re~el sol __
  que ma -- ña -- na __ so -- bre 
  la~a -- ve -- ni -- da __ na -- ce -- rá. __
  
  
  Cuá __ cuá. __ 
  Da -- ra -- ba dun  dun, da ba __ da, __
  Lu -- nes o -- tra vez,
  Lu -- nes o -- tra vez,
  des -- de __ mi __ ven -- ta -- na __
  lu -- nes, __ 
  
  de~u -- na pla -- za __ que __
  mo -- ri -- rá, 
  y muer -- to el __ ver -- de, 
  só -- lo hie -- rro __ cre -- ce -- rá. __
  
  Cuá __ cuá. __
  Vie -- jas en la~es -- qui -- na men -- di gan su -- pan, __
  en las o -- fi -- ci -- nas muer -- te~en so -- cie -- dad. __
  To -- dos cie -- gos hoy sin sa -- ber mi -- rar __
  la~es --  pan -- to -- sa ri -- sa de la pá -- li -- da ciu -- dad. __

  Ba -- ra -- ba dun  dun, da ba __ da, __
  Lu -- nes o -- tra vez,
  Lu -- nes o -- tra vez;
  da -- ra -- ba
  chiu -- ru -- p,
  chiu -- ru -- p,

  dun dun dun pa dun dun dun dun
  la gen -- te __ que ves __ _
  dun dun dun pa dun dun dun dun
  
  Siem -- pre se -- rá~i -- gual, __
  nun -- ca cam -- bia -- rá. __
  Lu -- nes es el __ dí -- a tris -- te~y gris
  de so -- le -- dad, __ chiu rap,
  
  pa -- ba da -- bap __ da -- ba -- da -- ba -- da,
  bua bua bua bua.
  Jue -- ves __ o -- _ _ tra vez. __ Uffff!!!
}


bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\dynamicUp
  \bass_music}
  \addlyrics {\bass_lyrics}
>>


\include "utils/swing.ly"

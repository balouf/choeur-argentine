% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Se equivocó la paloma"
  subtitle = ""
  composer = "Carlos Guastavino"
  tagline = ""

}

conductor_size = 16
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 3/4
\tempo "Allegretto" 4 = 96
\key f \minor
}


sop_music = {
  \partial 4. 
  \set Timing.beamExceptions = #'()
  \set Timing.beatStructure = 1,1,1
  c8( es g f-.) r
  f2--~\> 4~ 8-.\! c( es g f4-- 8-.) c( es g 
  f4-- 8-.) c( es g f-.) r
  f2~\> 4~ 8\! c\( f g\< 
  \time 2/4 \bar "||"
  aes4 g8\> aes
  \time 3/4 f4 8\)\!
  \set Timing.beamExceptions = #'()
  \set Timing.beatStructure = 1,1,1
  c\( es g f4-- 2~4~8\) 
  c\( f g aes4 4 g8 aes f4~ 8\)
  c\(\p f g aes4 4 g8 aes f4-- 8\)
  c\( es g f4 2~ 4~ 8\)
  f\(\mf aes bes c2 8 bes c4-- 8\) r r4
  aes2\p( g4 c2. es4 des8)
  aes\(\dim bes c aes4 2 c4-- bes8-.\)
  f\( g aes f4 8\)
  c\( es g f4 2~4~8\)\!
  f\< g aes c4 bes8\> aes bes c
  aes4 8\!
  f\< g aes bes c bes\> aes bes c
  aes4 8\!
  8->\f bes-> des-> c4-> 2->~4~8 r r4
  r2. r^"accel."
  r4 r8^"lento"
  f,-> g-> bes-> aes4-> 8->
  8\ff-> bes->^"rit." des-> c4-> 2->\>~8\! r r4^"a tempo"
  g8\(\p aes bes4 4 aes8 g f4 8\) r
  g\(^"Eco" aes c bes8 4 aes8 g f4 8\)
  c\( es g f4-> 8\)
  c\( es g f4-> 2~2\>~8\) r\!
  \times 2/4 \bar "||" \tempo "Menos"
  f\f(\(\<^"portando" c') 4\)\!
  bes8\( aes bes c aes4\> 4~4~8\)\! r
  bes\(\p r8 8 c c aes g aes f4-- 4~2~\>
  \time 3/4 \bar "||"
  4~8\)\!
  \tempo "Tempo I"
  c(\p es g f) r8 2~4~8
  c( es g f4-- 8-.) 
  c( es g f4-- 8-.) 
  c( es g f) r
  f2--\<~2.~\>4~8\! r r4\fine
  
 }


sop_lyrics = \lyricmode {
  B.c. \repeat unfold 5 { _ } 
  Se~e -- qui -- vo -- có
  la pa -- lo -- ma
  se~e -- qui -- vo -- ca -- ba.
  
  Por ir al nor -- te fue al sur 
  cre -- yó que~el tri -- go e -- ra 
  a -- gua se~e -- qui -- vo -- ca -- ba
  cre -- yó que~el mar e -- ra~el cie -- lo
  B.c.
  se~e -- qui -- vo -- ca -- ba _ _
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  
  Que las es -- tre -- llas _
  ro _ -- ci -- o que la ca -- lor _
  la _ ne _ -- va -- da
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  
  que tu fal -- da~e -- ra tu blu -- sa
  que tu co -- ra -- zón su _ ca -- sa
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  
  E -- lla se dur -- mió~en la~o -- ri -- lla,
  tú, en la cum -- bre de~u -- na ra -- ma
  B.c.
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
  \partial 4. r8 bes4( des8-.) r c2~--\> 4~8-.\! r
  bes4( des-- c8-.) r bes4( des-- c8-.) r
  bes4( des8-.) r c2~\> 4~ 8\! c\( c c\<
  \time 2/4
  des4 c8\> 8
  \time 3/4
  des4 c8\)\! 8\( bes8 8 des4-- c2~ 4~ 8\)
  8\( f g f4 4 e8 8 des4( c8)\)
  c\(\p 8 8 4 b bes8 8 des4-- c8\)
  c\( bes8 8 des4 c2~ 4~ 8\)
  f\(\mf aes bes aes2 g8 8 es4-- 8\) r r4
  f2.\p f2. 4~8 f\(\dim es es des4 2~4~8\)
  8\( c c bes4 8\) c\( bes8 8 des4 c2~4~8\)\! r r4
  f2( e4 es4~8) r r4
  f( e es4 4~8)
  aes\f-> bes-> des->
  c4-> c2->~4~8 r r4 r2.
  r4 r8 bes,-> c-> es-> des4-> 2->~4~8
  8->\ff 8->^"rit." f-> es4-> 2->\>~8\! r r4^"a tempo"
  f8\(\p f e4 4 8 8 c4 8\) r
  f8\(^"Eco" f e e e4 e c4 8\)
  c\( bes8 8 des4-> c8\)
  c\( bes8 8 des4-> c2~2\>~8\) r\!
  \time 2/4 \bar "||"
  des\f\<(\( f) 4\)\!
  f8\( f e e es4\> 4~~4~8\!\) r
  f\(\p r e e es8 8 8 8 8-- des ces4~2\>~
  \time 3/4  \bar "||"
  4~8\!\) r 
  bes4\p( des8-.) r c2~4~8 r
  bes4( des-- c8-.) r
  bes4( des-- c8-.) r
  bes4( des8) r c2--\<~2.\>~4~8\! r r4 \fine
  
}

alt_lyrics = \lyricmode {
  B.c. \repeat unfold 5 { _ } 
  Se~e -- qui -- vo -- có
  la pa -- lo -- ma
  se~e -- qui -- vo -- ca -- ba.
  
  Por ir al nor -- te fue al sur 
  cre -- yó que~el tri -- go e -- ra 
  a -- gua se~e -- qui -- vo -- ca -- ba
  cre -- yó que~el mar e -- ra~el cie -- lo
  B.c. _ _
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  B.c. _
  
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  
  que tu fal -- da~e -- ra tu blu -- sa
  que tu co -- ra -- zón su ca -- sa
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  
  E -- lla se dur -- mió~en la~o -- ri -- lla,
  tú, en la cum -- bre de~u -- na ra _ -- ma
  B.c.
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
  \partial 4. r8 g'4( bes8-.) r aes2~--\> 4~8-.\! r
  g4( bes-- aes8-.) r g4( bes-- aes8-.) r
  g4( bes8-.) r aes2~\> 4~ 8\! c\( c c\<
  \time 2/4
  bes4 8\> 8
  \time 3/4
  4 aes8\)\! c8\( g8 8 bes4-- aes2~ 4~ 8\)
  c8\( 8 8 d4 des4 c8 8 bes4( aes8)\)
  bes\(\p aes8 g8 f4 f e8 8 bes'4-- aes8\)
  8\( g8 8 bes4 aes2~ 4~ 8\)
  f'\(\mf e es d2 des8 8 c4-- 8\) r r4
  des2.\p c des4~8 8\(\dim c c bes4 2~4~8-.\)
  bes\( aes8 8 g4 8\)
  g\( g g bes4 aes2~4~8\)\! r r4
  des2.( c4~8) r r4 des2( g,4 c~8)
  aes->\f bes-> des-> c4-> 2->~4~8 r r4
  r r8 es,-> f-> aes-> g4-> 2->~2. f4~8
  f->\ff f->^"rit." aes-> g4-> 2->\>~8\! r 
  r4^"a tempo"
  bes8\(\p c des4 4 c8 bes aes4 8\) r
  bes\(^"Eco" c des8 8 4 c8 bes aes4 8\)
  aes\( g g bes4-> aes8\)
  aes\( g g bes4-> aes2~2\>~8\) r\!
  \time 2/4 \bar "||"
  aes8\((\f\< des8) 4\)\!
  des8\( 8 8 8 4\> c~4~8\)\! r
  des\(\p r8 8 8 c c aes8 8 ces-- bes aes4~2~\>
  \time 3/4 \bar "||"
  4~8\!\) r
  g4\p( bes8-.) r aes2~4~8 r
  g4( bes-- aes8) r
  g4( bes-- aes8) r
  g4( bes)-- aes2--\<~2.~\> 4~8\! r r4 \fine
  
}

ten_lyrics = \lyricmode {
  B.c. \repeat unfold 5 { _ } 
  Se~e -- qui -- vo -- có
  la pa -- lo -- ma
  se~e -- qui -- vo -- ca -- ba.
  
  Por ir al nor -- te fue al sur 
  cre -- yó que~el tri -- go e -- ra 
  a -- gua se~e -- qui -- vo -- ca -- ba
  cre -- yó que~el mar e -- ra~el cie -- lo
  B.c. _ _
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  B.c. _
  
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba _
  se~e -- qui -- vo -- ca -- ba
  
  que tu fal -- da~e -- ra tu blu -- sa
  que tu co -- ra -- zón su _ ca -- sa
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  
  E -- lla se dur -- mió~en la~o -- ri -- lla,
  tú, en la cum -- bre de~u -- na ra _ -- ma
  B.c.
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
  \partial 4. r8 c,4( f~ 8) c es g f4-- 8-. 
  r c4( f-- 8-.) r c4( f-- 8-.) r c4( f~ 8)
  c( es g f4~8)
  c'\( aes g\<
  \time 2/4
  f4 e8\> 8
  \time 3/4
  f4 8\)\! c'\( c, c f4-- 8\)
  c\( es g f4 8\)
  c'\( 8 8 b4 4 bes8 8 f4~8\)
  g\(\p f es d4 4 c8 8 f4-- 8\)
  8\( c c f4 8\) c\( es g f4 8\)
  8\(\mf 8 8 bes2 es,8 8 aes4-- 8\) r
  aes\( bes\< c4 4 bes8\> c aes4 8\!\)
  8\( bes c aes4 8\)
  8\(\dim g g f4 8\) 8\( g aes f4 8-.\)
  8\( es es des4 8\) c\( 8 8 f4 8\)
  c\( es g f4 8\)\! r r4
  es2.( aes4~ 8) r r4
  es2.( aes4~ 8)
  aes,8->\f bes -> des->
  c4-> 2->~ 4~ 8
  aes8-> bes -> des->
  c4-> 2->~ 2.~ 2. bes4~ 8
  bes->\ff 8->^"rit." 8-> c4-> 2->\>~8\! r r4^"a tempo" r4
  4\p\( 4 8 8 f4 8\) r 
  f\(^"Eco" f c c c4 4 f4 8\)
  f\( c c f4-> 8\)
  f\( c c f4-> 2~2~\>8\) r\!
  \time 2/4 \bar "||"
  bes,(\(\f\< aes'8) 4\)\!
  8\( 8 g g aes4\> 4~ 4~ 8\)\! r
  aes8\(\p r g g aes aes c, c des4-- 4~ 2~\>
  \time 3/4 \bar "||"
  4~ 8\)\! r
  c4(\p f-.) 8-. c( es g f4-- 8-.) r
  c4( f-- 8-.) r c4( f-- 8-.) r 
  c4( f8) r f2--~\< 2.~\> 4~ 8\! r r4
  \fine
  
  
}

bass_lyrics = \lyricmode {
  B.c. \repeat unfold 9 { _ } 
  Se~e -- qui -- vo -- có
  la pa -- lo -- ma
  se~e -- qui -- vo -- ca -- ba,
  se~e -- qui -- vo -- ca -- ba.
  
  Por ir al nor -- te fue al sur 
  cre -- yó que~el tri -- go e -- ra 
  a -- gua se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  cre -- yó que~el mar e -- ra~el cie -- lo
  que la no -- che la ma -- ña -- na
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba  
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba 
  se~e -- qui -- vo -- ca -- ba
  B.c. _
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba _
  se~e -- qui -- vo -- ca -- ba
  
  fal -- da~e -- ra tu blu -- sa
  que tu co -- ra -- zón su ca -- sa
  se~e -- qui -- vo -- ca -- ba
  se~e -- qui -- vo -- ca -- ba
  E -- lla se dur -- mió~en la~o -- ri -- lla,
  tú, en la cum -- bre de~u -- na ra -- ma
  B.c.
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

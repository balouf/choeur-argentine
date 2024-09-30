% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Dicotomía Incruenta"
  subtitle = ""
  composer = "Jorge Maronna"
  tagline = ""

}

conductor_size = 16
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 6/8
\tempo "Giocoso" 4. = 84
\key f \major
}


sop_music = {
  r2. r
  r8\mf a' bes c d e f e d e d c
  d8. f, g a
  r8 g\< a bes bes c d4.\! 
  g,8. a bes a bes a g\> f\! r4. r2.
  \bar "||"
  r8\mf c d e\< e f g8.\> c,\!
  r\p g' c, e c d
  e8\cresc e d c8. d e f g8 g f
  e8.\< f g a
  \time 9/8
    \tempo \markup {
    \rhythm { \stemUp 4. } = \rhythm { \stemUp 4. }
  }
  bes8.\f a g f e d c4.^"poco rall." 2. r4. r r
  \time 3/4 \bar "||"
  \tempo \markup {
    
    poco più mosso
  } 4=84

  r2.  
  \time 3/8
  r8 a'\mp bes   
  \time 2/4
  c d-- e f-- g f e d c f e d r 
  bes c d e f g4 c, r4 r
  a8->\f g16 a f8 e d d
  \time 3/4 \bar "||" \mark \markup { \musicglyph "scripts.ufermata" }
  
  r8 c\f\< e[ c] e[ g]
  \time 2/4
  bes\! g bes g
  \time 3/8
  e g e
  \time 2/4
  c'\> a\! r f
  a\< f a c\!
  es c es c
  \time 3/8
  a c a fis a r
  r fis\f a c\< a c es\> c\! r

  \time 3/4
  r gis\f\< b[ d] b[ d] f\> d\! r4 r
  \tempo "poco meno mosso"
  r8\f e[ c] a[ f d] bes'[ g e]
  r bes' g
  \time 3/8 \tempo "rall. al fine"
  e cis bes'
  \tempo "burlesco"
  g-- e'-- cis--
  \tuplet 4/3 {bes-- a-- e-- cis--}
  d4.\f\fermata \fine
 }


sop_lyrics = \lyricmode {
  Siem -- pre lle -- ga mi
  ma -- nos más tar -- de que
  o -- tra ma -- no
  que se mez -- cla~a la mí -- a
  y for -- man u -- na ma -- no.
  
  Cuan -- do voy a sen -- tar -- me
  ad -- vier -- to que mi
  cuer -- po se sien -- ta~en o -- tro
  cuer -- po que~a -- ca -- ba
  de sen -- tar -- se~a -- don -- de yo me sien -- to.

  Y~en el pre -- ci -- so~ins -- tan -- te
  de~en -- trar en u -- na ca -- sa,
  des -- cu -- bro que ya~es -- ta -- ba
  an -- tes de~ha -- ber lle -- ga -- do.

  Por e -- so~es muy po -- si -- ble
  que no~a -- sis -- ta~a -- mi~en -- tie -- rro,
  y que mien -- tras me rie -- guen de
  lu -- ga -- res co -- mu -- nes,
  
  ya me~en -- cuen -- tre~en la tum -- ba,
  ves -- ti -- do de~es -- que -- le -- to,
  bos -- te -- zan -- do los tó --  pi -- cos
  y los llan -- tos fin  --
  gi -- _ _ _ _ _ _ dos.
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
r8\mf a bes c d e f e d e d c
d8. f g a
  r8 g\< a bes bes c d4.\! 
  g,8. a bes a bes a g\> f\! r4. r2. r r \bar "||"
  
  r2. r8\mf c d e\< e f g8.\> c,\!
  r\p g' c, e c d
  e8\cresc e d c8. d e f g8 g f
  \time 9/8
  e8.\< f g a bes\f a g f e d c4.\> c r4.\! r
  \time 3/4 \bar "||"

  r8 a\mp bes[ c] d[ e] 
  \time 3/8
  f g\< f
  \time 2/4
  e d\! c f e d r 
  bes c\< d e f g4\> c,\! r2
  a'8->\f g16 a f8 e d d r4 r2
  \time 3/4 \bar "||" \mark \markup { \musicglyph "scripts.ufermata" }

  r4 r8 c8\f e[ c] 
  \time 2/4
  e g bes g 
  \time 3/8
  bes g e-- 
  \time 2/4
  g e c' a r f
  a f a c
  es c
  \time 3/8
  es c a-- c a fis-- a r
  r fis\f a c-- a\< c es-- 
  \time 3/4
  c\!
  r8 r gis8 b[ d] b[ d] f[ d] r4 r r8
  e8\f c[ a]-- f[ d] bes'[ g] e
  r 
  \time 3/8
  bes' g e-- cis 
  bes' g--  
  \tuplet 4/3 {g-- e-- cis-- bes--}
  a4.\f\fermata \fine

}

alt_lyrics = \lyricmode {
  Siem -- pre lle -- ga mi
  ma -- nos más tar -- de que
  o -- tra ma -- no
  que se mez -- cla~a la mí -- a
  y for -- man u -- na ma -- no.

  Cuan -- do voy a sen -- tar -- me
  ad -- vier -- to que mi
  cuer -- po se sien -- ta~en o -- tro
  cuer -- po que~a -- ca -- ba
  de sen -- tar -- se~a -- don -- de yo me sien -- to.

  Y~en el pre -- ci -- so~ins -- tan -- te
  de~en -- trar en u -- na ca -- sa,
  des -- cu -- bro que ya~es -- ta -- ba
  an -- tes de~ha -- ber lle -- ga -- do.
  
  Por e -- so~es muy po -- si -- ble
  que no~a -- sis -- ta~a -- mi~en -- tie -- rro,
  y que mien -- tras me rie -- guen de
  lu -- ga -- res co -- mu -- nes,
  
  ya me~en -- cuen -- tre~en la tum -- ba,
  ves -- ti -- do de~es -- que -- le -- to,
  bos -- te -- zan -- do los tó --  pi -- cos
  y los llan -- tos fin  --
  gi -- _ _ _ _ dos.
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
  r2. r r
r8\mf a'\< bes c d e\! f e d e d c
d8. f, g\> a\!
  r8 g\< a bes bes c d4.\! 
  g,8. a bes a bes a g\> f\! r4. \bar "||"

  r4. r8\mf c d e\< e f g8.\> c,\!
  r\p g' c, e c d
  e8\cresc e d c8. d e f g8 g f
  e8.\< f
  \time 9/8
  g a bes\f a g f e d c4.\> c\! r4. r r
  \time 3/4 \bar "||"
  
  r4 r r8 a'\mp  
  \time 3/8
  bes c d--  
  \time 2/4
  e f-- g f e d c f e d r 
  bes c d e f g4 c, r2
  a8->\f g16 a f8 e d d r4
  \time 3/4 \bar "||" \mark \markup { \musicglyph "scripts.ufermata" }

  r4 c8\f[ e]-- c[ e]
  \time 2/4
  g bes-- g bes 
  \time 3/8
  g e-- g 
  \time 2/4
  e c'-- a r f
  a\< f a c\!
  es c es
  \time 3/8
  c a-- c a fis-- a r
  r fis\f a c-- a c es-- c
  
  \time 3/4
  r4 gis8 b d[ b] d[ f]-- d r8 r4 r
  e8[\f c] a f d[ bes'] g[ e]
  r bes'
  \time 3/8
  g e-- cis 
  bes' g-- e'-- 
  \tuplet 4/3 {cis-- bes-- a-- e--}
  d4.\f\fermata \fine

}

ten_lyrics = \lyricmode {
  Siem -- pre lle -- ga mi
  ma -- nos más tar -- de que
  o -- tra ma -- no
  que se mez -- cla~a la mí -- a
  y for -- man u -- na ma -- no.

  Cuan -- do voy a sen -- tar -- me
  ad -- vier -- to que mi
  cuer -- po se sien -- ta~en o -- tro
  cuer -- po que~a -- ca -- ba
  de sen -- tar -- se~a -- don -- de yo me sien -- to.

  Y~en el pre -- ci -- so~ins -- tan -- te
  de~en -- trar en u -- na ca -- sa,
  des -- cu -- bro que ya~es -- ta -- ba
  an -- tes de~ha -- ber lle -- ga -- do.
  
  Por e -- so~es muy po -- si -- ble
  que no~a -- sis -- ta~a -- mi~en -- tie -- rro,
  y que mien -- tras me rie -- guen de
  lu -- ga -- res co -- mu -- nes,
  
  ya me~en -- cuen -- tre~en la tum -- ba,
  ves -- ti -- do de~es -- que -- le -- to,
  bos -- te -- zan -- do los tó --  pi -- cos
  y los llan -- tos fin  --
  gi -- _ _ _ _ _ dos.
  
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
r2.
r8\mf a,\<  bes c d e\! f e d e d c
d8. f g\> a\!
r8 g\< a bes bes c d4.\! 
g,8. a bes a bes a g\> f\! r4. r2. r \bar "||"

  r2. r4. r8\mf c d e\< e f g8.\> c,\!
  r\p g' c, e c d
  e8\cresc e d c8. d e f 
  \time 9/8
  g8 g f e8.\< f g a bes\f a g f e\mf d c4.\> c r4.\!
  \time 3/4 \bar "||"

  r4 r8 a\mp bes[ c] 
  \time 3/8
  d e f-- 
  \time 2/4
  g\< f e d\! c f e\> d\! r 
  bes c\< d e f g4\> c, r4\! r4
  a'8->\f g16 a f8 e d d r2
  \time 3/4 \bar "||" \mark \markup { \musicglyph "scripts.ufermata" }

  r4 r4 c8\f e-- 
  \time 2/4
  c e g bes-- 
  \time 3/8
  g bes g 
  \time 2/4
  e g e c'-- a r f
  a f a c
  es--
  \time 3/8
  c es c a c a
  d,4.-> 4.~4 r8
  \time 3/4
  e4 4-> 4~2 r4
  a,2.\f a
  \time 3/8
  4.~a~a d\f\fermata \fine

}

bass_lyrics = \lyricmode {
  Siem -- pre lle -- ga mi
  ma -- nos más tar -- de que
  o -- tra ma -- no
  que se mez -- cla~a la mí -- a
  y for -- man u -- na ma -- no.

  Cuan -- do voy a sen -- tar -- me
  ad -- vier -- to que mi
  cuer -- po se sien -- ta~en o -- tro
  cuer -- po que~a -- ca -- ba
  de sen -- tar -- se~a -- don -- de yo me sien -- to.
  
  Y~en el pre -- ci -- so~ins -- tan -- te
  de~en -- trar en u -- na ca -- sa,
  des -- cu -- bro que ya~es -- ta -- ba
  an -- tes de~ha -- ber lle -- ga -- do.

  Por e -- so~es muy po -- si -- ble
  que no~a -- sis -- ta~a -- mi~en -- tie -- rro,
  y que mien -- tras me rie -- guen de
  lu -- ga -- res co -- mu -- nes, __
  
  ves -- ti -- do __ bos -- te -- zan -- do.
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

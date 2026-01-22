% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Misa a San Ignacio"}
  composer = "Dominico Zipoli (1688-1726)"
  subtitle = "1 - Kyrie"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

allegro = {
\tempo "Allegro" 2 = 80
}

adagio = {
\tempo "Adagio" 2 = 72
}


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 2/2
\allegro
\key f \major
}


sop_mus = {R1*6 
\adagio
\bar "||"  c'2. 4 1
d2. 4 2 r4 c d2 bes a1 r
c2. 4 b2 c c b c1 r
c2. 4 f, g( a bes8 a) g2. 4 a1 
\allegro
R1*4
\bar "||"
c2 a4 c bes8( c a bes) g4. 8
a4 f c'4. bes8 a( bes) c4 4 b c2 r4
a d c bes8( d c bes) a( c bes) a g2 r1
g2 e4 g f8( g e f) d4. 8 e4 c f4. 8 4 4 4 e
f c' a c bes8( c a bes) g4. 8 a2 r r
f' d4 f es8( f d es) c4 4 bes d d d c2 r
r4 c a c b8( c a b c d bes c a c bes a)
g4 4 a g f8( e f) g g4 r
r c a c bes8( c a bes) g4. 8 a2.
c4 bes a d2( c bes4 f) 2. bes4 a1
\bar "||"
\time 3/8
\tempo 4.=54
a8^"solo" bes4( c8a) c bes g4
a16( g a bes a8 c) bes a g4.
c8 d4 e8.( d16) c( b) c( d) b8. c16 4. r r
g8 c16( d) bes( c) a4 r8
f8( bes16 d c bes a g a c bes a g f g bes a g
f8 d d' e) cis8. d16 4 r8 r4.
r8 a a bes16( a) bes4 r4. g8 c16( d) bes( c) a4 r8
d16( c d bes a bes c bes c a g a bes a bes g) f g
a4 r8 r c4 8 bes8. 16 4 a16( g) a( bes) g8. f16
4 r8 r a bes c8.( bes16) a( g) a( bes) g8. f16 4 r8
\bar "||"
\time 2/2 \adagio
a2( g) f2. 4 e1
\bar "||" \allegro
f2.^"tutti" 4 g8( f g a g a f g) a4( f8 g a4 b)
c g c2~2 b c4. 8 bes2
a8( g a bes a bes g a bes a bes c bes d c bes
a g a bes) c4 d g,2 r8 e( f g) a2 g g r
r c,4 4 d8( c d e d e c d e4 d8 c) d4 e f c f2~2 e f a4 f
bes( a8 g c2~4 a8 bes c4 d e8 d e f e g f e d c d e d f e d)
c8 8 g4 c2 c b c r a8( g a bes) a( c) bes( a) g2 r
bes8( a bes c) bes( d) c( bes) a2 d( cis8 b cis a) d2~2 cis d r
r1 f,2. 4 g8( f g a g a f g a g a bes a bes g a bes a bes c bes c
a bes c2) 2~( 4 d8 c bes2~4 c8 bes a2) g2. 4 f1 
c'4 4 f es( d8 es c es d es c d) bes2. 4 a1\fermata \fine
}


sop_lyr  = \lyricmode {
  Ky -- ri -- e Ky -- ri -- e 
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  
  Chri -- ste e -- lei -- son e -- le -- i -- son.
  Chri -- ste Chri -- ste e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Chri -- ste Chri -- ste e -- le -- i -- son
  e -- le -- i -- son.
  
  Chri -- ste   Chri -- ste   Chri -- ste e -- le -- i- -- son.
  Chri -- ste   Chri -- ste   e -- le -- i- -- son e -- le -- i -- son.
  
  Ky -- ri -- e e -- le -- i -- son e -- le  -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.  
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_mus}
  \addlyrics {\sop_lyr}
>>

alt_mus = {R1*6 
\bar "||"  a'2. 4 1
f2. 4 2 r4 4 2 g c,1 r
a'2. 4 g2 2 f2. 4 e1 r
f2. 4 d( e) f2 2 e f1 R1*4
R1*2 f2 e4 g f8( g e f) d4. 8
e4 c f4. e8 d( e) f2 e8 8 f2 r4
e a g f8( a g f) e( f e) d c2 r1
g'2 a4 c bes8( c a bes) g4. 8
a4 f f4. 8 4 4 4. e8
f4 a bes4 4 4 4 4 a bes2 r r1
r2 r4 f d f e8( f d e f g e f)
d4. 8 e4 r r2 r4 d c e
d( g~8 a g f) g2. f8( e)
f4 4 4 e f2. a4 f f 
f8( e f g a2 f8 g f e) d2. 4 c1
\bar "||"
\time 3/8
\tempo 4.=54
f8 g4( a8 f) a g e4 f16( e f g f8 a) g f e4. r r r
g8 a4 g8.( f16) e( d) e( f) d8. c16 4 r8
c f16( g) e( f) d4 r8 c( f16 a g f e d e g f e 
d e f g a8 g16 f) e8. d16 4 r8 r4. r r8
d d e16( d) e4 r4. c8 f16( g) e( f) d4 r8
a'16( g a f e f g f g e d e f e f d) c d e8
r16 f( g a d,8. e16 f g d4 c8 f16 g) e8. f16 4 r8 r
f g a8.( g16) f( e) f( g) e8. f16 4 r8
\bar "||" \time 2/2
f2( c) 4( d) b2 c1
\bar "||"
r1 r r c2.^"tutti" 4 d8( c d e d e c d)
e4( d8 c d4 e) f4 c f2~2 e f4. 8 f2
e8( d e f e g f e f g e f) d4. 8 e2 2
f8( e f g f g) e( f) g2 4 4 a( g8 e) f4 g
a f8 g a4 g8( f) g2. 4 f2 4 4
g8( f g a g a f g a4 f8 g) a4 b c g c2~2 b c
g4( e) f8( e f g f g e f g4 f8 e f4) g
c,2 r e8( d e f e g f e) d2 r
f8( e f g f a g f e4) a f g8( f) e( d e f) e( g f e) d2 r
r1 d2. 4 e8( d e f e f d e f e f g f g e f g f g a g a f g a2)
2 f2. g8( f) e2 f~( 4 e8 d) e4. 8 f1 r2 a4 4 f2. 4 
d2. 4 c1\fermata \fine
}


alt_lyr  = \lyricmode {
  Ky -- ri -- e Ky -- ri -- e 
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e
  e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.

  Chri -- ste e -- lei -- son e -- le -- i -- son.
  Chri -- ste Chri -- ste e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Chri -- ste Chri -- ste e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Chri -- ste Chri -- ste e -- le -- i -- son
  e -- le -- i -- son.
  
  Ky -- ri -- e e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son.
  Ky -- rie Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_mus}
  \addlyrics {\alt_lyr}
>>

ten_mus = {R1*6 
\bar "||"  f'2. 4 1
d2. 4 2 r4 a bes2 g f1 r
f'2. 4 2 e d2. 4 c1 r
a2. 4 bes2 f c'2. 4 f,1 R1*4
R1*4 c'2 a4 c bes8( c a) bes g4. 8
a4 f c'2 f4( e) d4. 8 c2 r4
e d8( e) c d b4. 8 c2 r4
a d c bes8( d c bes a bes a) g f2 r1
f'2 d4 f es8( f es) d c4. 8 bes8 8 d4
c8( d bes c a4.) 8 bes4 4 4. 8 f2 r1 r1 r4
c' d f e8( f d e f4 e d8 e c d e f e) d
c2 f4 a, bes2 c4. 8 f,2. f'4 d f 
bes,8( c d e f2 bes,4 a) bes2. 4 f1
R4.*39 R1*3
R1*6
f2.^"tutti" 4 g8( f g a g a f g a4) f8( g) a4 b 
c g c2~2 b c bes a8( g a bes a bes g a bes a bes c
bes c) a( bes) c4 a bes c f,2 d'
bes8( a bes c bes d) c( bes) a4 c f2~2 e f r r1 r
c2. 4 d8( c d e d e c d e4) d8( c) d4 e f2 f, 
c'4 d e c g2 2 d'4 e f d a2 bes
g8( f g a g bes) a( g) f4 a d2~( 4 cis8 b cis d) b( cis)
d2. 4 c2. 4 f,1 r f'2. 4 d8( c d e d f e d c2) d4( c)
bes2 c f,1 r2 4 4 bes8( c a c bes c) f,( a) bes2. 4
f1\fermata \fine
}


ten_lyr  = \lyricmode {
  Ky -- ri -- e Ky -- ri -- e 
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.  
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  
  Ky -- rie e -- le -- i -- son
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  }

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\ten_mus}
  \addlyrics {\ten_lyr}
>>

bass_mus = {R1*6 
\bar "||"  f2. 4 1
d2. 4 2 r4 a bes2 g f1 r
f'2. 4 2 e d2. 4 c1 r
a2. 4 bes2 f c'2. 4 f,1 R1*4
R1*4 c'2 a4 c bes8( c a) bes g4. 8
a4 f c'2 f4( e) d4. 8 c2 r4
e d8( e) c d b4. 8 c2 r4
a d c bes8( d c bes a bes a) g f2 r1
f'2 d4 f es8( f es) d c4. 8 bes8 8 d4
c8( d bes c a4.) 8 bes4 4 4. 8 f2 r1 r1 r4
c' d f e8( f d e f4 e d8 e c d e f e) d
c2 f4 a, bes2 c4. 8 f,2. f'4 d f 
bes,8( c d e f2 bes,4 a) bes2. 4 f1
R4.*39 R1*3
R1*6
f2.^"tutti" 4 g8( f g a g a f g a4) f8( g) a4 b 
c g c2~2 b c bes a8( g a bes a bes g a bes a bes c
bes c) a( bes) c4 a bes c f,2 d'
bes8( a bes c bes d) c( bes) a4 c f2~2 e f r r1 r
c2. 4 d8( c d e d e c d e4) d8( c) d4 e f2 f, 
c'4 d e c g2 2 d'4 e f d a2 bes
g8( f g a g bes) a( g) f4 a d2~( 4 cis8 b cis d) b( cis)
d2. 4 c2. 4 f,1 r f'2. 4 d8( c d e d f e d c2) d4( c)
bes2 c f,1 r2 4 4 bes8( c a c bes c) f,( a) bes2. 4
f1\fermata \fine
}


bass_lyr  = \lyricmode {
  Ky -- ri -- e Ky -- ri -- e 
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son.  
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  
  Ky -- rie e -- le -- i -- son
  e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  
  Ky -- ri -- e e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son.
  Ky -- rie e -- le -- i -- son e -- le -- i -- son
  e -- le -- i -- son e -- le -- i -- son
  Ky -- ri -- e e -- le -- i -- son.
  Ky -- ri -- e e -- le -- i -- son.
  }

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\bass_mus}
  \addlyrics {\bass_lyr}
>>


violin_style = {
\set Staff.midiInstrument = "violin"
\set Staff.midiMinimumVolume = #0.5
\set Staff.midiMaximumVolume = #0.7
\clef treble
\accidentalStyle modern-cautionary
}



vioa= \new Staff \with {instrumentName="Violin 1"
  shortInstrumentName ="V.1"} <<
  \violin_style
  \armure
  \relative c' {f'8 c d e f g a f
g( f) e d c g' g g
a( g) f e f c c c
a'( g) f e f c c c
a'4 bes8( a) g2\trill a1\break
\bar "||"
a8( f) f f a( f) f f
a( g) a bes a( bes) a g
f2. r4 1
f8( d) e f g( e) f g a1 r1
2. 4 b b c2 2 b c1 r
f,8( a) g a f( a) g a
d,( e) f g a4 bes f2 e f1
\allegro
f8( c) d e f g a f
g( f) e d c g' g g
a( g) f e f c d g g2\trill a
\bar "||"
c2 a4 c bes8 c a bes g4. 8
a4 f c'4. bes8 a bes c4 4 b c2 r4
a d c bes e, f8 a g f e f g e
a f g e f a g f e f e d c4 g'
a g f e8 d e g f g c,4 f8 e 
d bes c a bes d c bes
a g a bes c a bes c d d c c d d e e 
f2 d4 f bes,8 8 4 4 a
f'8 8 8 8 8 8 8 8 c c c c d d d d
f f f f a a a a bes8 8 8 8 g g g g 
a f f f d d d d e c c c a a' a a
c c bes bes a a g g f e d g e f e d
c bes a g f f' g a d, e f f g2 a r4
8 8 bes bes a a bes8 8 8 8 
a a a a bes8 8 f f bes1 a
\time 3/8
\tempo 4.=54
a,8 bes4 c8 a c bes g4 a16 g a bes a8
c bes a g4. c8 d4 e8. d16 c b c d b8. c16 4.
r r g8 c16 d bes c a4 r8 f bes16 d c bes
a g a c bes a g f g bes a g f8 d d'
e cis8. d16 8 g f e16 g f e d cis d8 a a
bes16 a bes4 r4.
g8 c16 d bes c a4 r8 d16 c d bes a bes
c bes c a g a bes a bes g f g a4 r8 r c c
c bes8. 16 8 8 a16 g a bes g8. f16 8
a'16 f e g f8 a bes c8. bes16 a g a bes g8. f16 4 r8
\bar "||"
\time 2/2 \adagio
a8 8 8 8 g g g g f f f f f f f f e1
\bar "||"
\allegro
f2. 4 g8 f g a g a f g a4 f8 g a4 b
c g c2 8 8 8 8 b b b b c2 bes
a8 g a bes a bes g a
bes a bes c bes d c bes 
a g a bes c4 d c g c2 8 8 8 8 b b b b c2 bes
a8 g a bes a bes g a bes a bes c bes c a bes
c4 a bes c a f8 g a4 g8 f g2. 4 f2 a,4 f
bes a8 g c2 4 a8 bes c4 d e8 d e f e g f e
d c d e d f e d c4 g c2 2 b c r
a8 g a bes a c bes a g2 r
bes8 a bes c bes d c bes a2 d
cis8 b cis a d2~2 cis d r r1
f2. 4 g8 f g a g a f g a g a bes a bes g a bes a bes c bes c
a bes c2 2~ 4 d8 c bes2~4 c8 bes a2 g2. 4 f1 
c4 4 f es d8 es c es d es c d bes2 2 a1\fermata \fine

  }
>>

viob= \new Staff \with {instrumentName="Violin 2"
  shortInstrumentName ="V.2"} <<
  \violin_style
  \armure
  \relative c' {f'8 c d e f g a f
e( d) c bes c e e e
f( e) d c c a g g
f'( e) d c c c e e
f4 g8( f) 4 e f1
c8( a) a a c( a) a a
c bes c d c d c bes a2. r4 1
d8( bes) c d e( c) d e f1 r1
c2. 4 g' g g2 f2. 4 e1 r
c8( f) e f c( f) e f
bes,( c) d e f2 g1 f
f8( c) d e f g a f
e d c bes c c c c
f( e) d c c a bes d
e2\trill f
R1*2
f2 e4 g f8 g e f d4. 8
e4 c f4. e8 d e f2 e4
f2 r4 e f8 d e c d f e d
e f e d c4 e f8 g e f d4. 8
c e d e c4 a8 g bes g a f g bes a g 
f e f g a f g a bes8 8 a a bes8 8 c c
a2 bes4 4 4 4 f2 d'4 f es8 f d es a, a a a f f f f
d' d d d c c c c f f f f c c c c a a a a b c a b
c c c c a f' f f g g g g c, c c c d g, g g g a g f
c' bes a g f4 f'8 e bes c d bes f' f e e f2 r4
8 8 d d f f f e f g f f f f f g f e d1 c
\bar "||" \time 3/8
\tempo 4.=54
f,8 g4 a8 f a g e4 f16 e f g f8 a g f e4. r r r
g8 a4 g8. f16 e d e f d8. c16 4 r8
c f16 g e f d4 r8 c f16 a g f e d e g f e 
d e f g a8 g16 f e8. d16 8 bes' f g a16 g f e f8 8 8 d
d d e16 d e4 8 8 8 c8 f16 g e f d4 r8
a'16 g a f e f g f g e d e f e f d c d e8.
f16 g a d,8. e16 f g d8 8 c8 f16 g e8. f16 8
f'16 a, c8 a
f' g a8. g16 f e f g e8. f16 4 r8
\bar "||" \time 2/2
c8 8 8 8 e e e e a, a a a d d d d c1
\bar "||"
r1 r r c2. 4 d8 c d e d e c d
e4 d8 c d4 e
f4 c f2~2 e f f
e8 d e f e g f e f g e f d8 8 8 8 e2 2
f8 e f g f g e f 

d c d e d e c d e4 d8 c d4 e f c
f2~2 e f2
f,4 4
g8 f g a g a f g a4 f8 g a4 b c g c2~2 b c
g4 e f8 e f g f g e f g4 f8 e f4 g
c,2 2 e8 d e f e g f e d2 2
f8 e f g f a g f e4 a f g8 f e d e f e g f e d2 r
r1 d'2. 4 e8 d e f e f d e f e f g f g e f g f g a g a f g a2
2 f2. g8 f e2 f~ 4 e8 d e2 f1
a,4 4 4 4 f2 4 4 
d2 2 c1\fermata \fine

  }
>>


upper = \relative c' {
  \armure
  \rpiano_syle
<<
  {\voiceOne a'4 bes c a
  g e f g a bes c2
  a4 bes c2~4 bes8 a g2 a1}
  \new Voice {\voiceTwo c,2 <c f>
  c1 2 <c f>4 <e g>
  c2 <c f>4 <e g> <f a> <d f> f e <c f>1}
  >>
\oneVoice
\adagio
<f a c>2. 4 1
<f a d>2. 4 2 <c f c'>
<d f bes> <bes e bes'>
<<{\voiceOne 
  a'8 c d e f e f g 
  a g a bes a bes a g
  <c, f>2 <a c> <g b> <g c>
  c b c8 g a b c <b d> <c e> <d f>
  <e g> <d f> <c e> <b d> c <e g>8 8 8
  <c f>2 c d c <g c>1 <a c>
  a4 bes c a g e f g a bes c d <c g>2 <a c>
  }
  \new Voice {\voiceTwo
  <c, f>2 r c'4 f c8 d c bes a2 f
  d c f2. 4 e2 s2 s1 f2 2 4 g a f f2 e f1
  c2 <c f> c1 2 f e f
  }
>> \oneVoice
c'2 a4 c bes8 c a bes g4. 8
<<
{\voiceOne 
a4 f c'4. bes8 a bes c2 b4 <c g>2 r4
a d c bes8 d c bes a c bes a g2
a8 b c2 b4 c2 g f8 g e f d4. 8
e2 f4 a d f2 e4
f c a c d c g2 <f a> bes4 4 2. a4
bes2 a4 bes c2 d d c bes1
a4 g f2 e4 c' a4. bes8 c2 a4 c
bes8 c a bes g2
r4 c a c bes a g2 <f a>4 c'
bes8 c a c d4 c bes2
a4 <a c> f2
d'8 bes c a bes d c bes <f a>1
}
\new Voice {\voiceTwo
f2 e4 g f8 f e f d4. 8 e4 c
f4. e8 d e f2 e4 c4. d8 e2
c4 <c g'> f2 e8 f e d e4 c
s2. c8 b c2 r4 c f <f c'> <g bes>2
a2 f4 a f f f e c2 d4 f g f es2
d4 f es d <c f>2 f f4 g a2
f <c g'> c2. b4 c e f c <c g'>2 c4
g' f g e2 r4 <e g> c f8 e d e f2 e4
c a' g f f a d, f c f d c f2 d4 f c1
}
>> \oneVoice
\bar "||" \time 3/8
<<
  {\voiceOne 
   f4 e8 f a c bes g c <c, f a>4 8
   <c a'> <e g> <f a> g16 f g a g8
   4. 4 c8 d c b c a4 g e8 f d4 e8 g c
   a4 c8
  }
  \new Voice
  {\voiceTwo 
   a,8 bes c a c a' d, e c s4. s e
   e8 d b e f g a <g d>4 <e g>8 c f
   c b c a c b c16 d e f g8 f16 g a bes f8
  }
>> \oneVoice
<f d'>4 <g c>8 <f a c>4. <g c> <d a' d>
<e bes' d>8 <e a cis>4 <d f d'>8 <d g d'> <d a' d>
<e g d'> <f d'> <e a cis>
<<
  {\voiceOne 
   d' a16 g f e d8 <d f>8 8 e <c e> <d f>
   <e g> <e g c> <g c> <f a c> <c f a> <c f c'>
   d'4. <a c> bes a16 g a f e f g8 f a~8 g4
   f16 e f g a8 bes g4 c8 8 8 a4 g8 
   a16 g a bes c8 d c16 d c bes
  }
  \new Voice
  {\voiceTwo 
   <f a>8 f d s4. s s s f4 g8~8 f4~8 e4 <c f>4.
   <c e>8 c f d bes c <bes d>4 c8 <d f> f e
   <c f>8 8 <e g> <c f>4 e8 <c f> f f <f bes> <f g> <e g>
  }
>> \oneVoice
<c f a>4 r8
\bar "||" \time 4/4 \adagio
2 <c e g>
<<
  {\voiceOne 
   f1
  }
  \new Voice
  {\voiceTwo 
   a,2 g4 b
  }
>> \oneVoice
<c e>1
\bar "||" \allegro
R1*6
<c f a>2. 4 <f bes>2 <e bes'>
<<
  {\voiceOne 
   c'4. bes8 a4 g g2 c~2 b
   c8 d e f e f d e f2 c
  }
  \new Voice
  {\voiceTwo 
   f,1 e2 g a4 e8 f <d g>2 <e g> <g c>
   <a c> a4 g
  }
>> \oneVoice
<d g bes>4 4 4 <e c'> <e a c>2 
<d f bes>4 <c g'c> <f a c>2 <f a d> <f g> <e g> 
<<
  {\voiceOne 
   a8 g a bes a bes g a
  }
  \new Voice
  {\voiceTwo 
   <f c>1
  }
>> \oneVoice
<d g bes>2 <c g'c> <c f a> r r1 r1
<e g c>2. 4
<<
  {\voiceOne 
   c'2 b c2. bes4
  }
  \new Voice
  {\voiceTwo 
   f1 <e g>
  }
>> \oneVoice
<f a>2 2 <e g c>2 2 <d g bes>2 2 <d f a>2 2 
<cis e a> <d f>
<<
  {\voiceOne 
   e1 f4. g8 a4 g
  }
  \new Voice
  {\voiceTwo 
   d2 cis d1
  }
>> \oneVoice
<d g>2 <cis e> <a d f>2. 4 <c e g>2. 4
<c f a>2 <c f> <f bes> <e bes'> <c f a>2 2
<<
  {\voiceOne 
   c'2 bes bes a g1 a2 s s1 d4 c d c
  }
  \new Voice
  {\voiceTwo
   f,1 e2 f <d f> e f8 e f g a g a bes
   <a c>4 4 <f a c>4 4 f2 f
  }
>> \oneVoice
<d f bes>2. 4 <c f a>1\fermata\fine
}


%<<
%  {\voiceOne 
%  }
%  \new Voice
%  {\voiceTwo 
%  }
%>> \oneVoice


lower = \relative c {
\armure
\lpiano_syle
f4 g a f e c d e f g a c, f g a c, f bes, c2 f1
f2. 4 2 2 d2. 4 2 a bes g f1 f'2 e
f2. 4 2 e d2. 4 c1 2 2 a'2. 4 bes2 f
c'2. c,4 f1 4 g a f e c d e
f g a bes, c2 f,
a' f4 a g2 e4 4 f2 c4 4 f2 g,2 c
a'4 c bes a g c, a' f c'2 f,4 e d2
c2. e4 d c b g' c,2 r4 f bes a g c
f,2 4 4 bes a bes c f,2 bes4 d es d c f,
bes d c bes a a, bes4 4 2 f4 f'
d8 8 8 8 e e e e f4 e d g, c2 d4 f
e2 f4 e d bes c2 2 f4 a, bes2 c f2. 4 bes f bes,8 c d e
f2 bes4 a bes2. 4 f1
\bar "||" \time 3/8
8 g c, f f f g c, e f e f f c f c'4.
c,8 b g c d e f g g, c f d e g, c f g c, c c e
f f a, bes bes e f c f e c e f d f g a a, d bes f'
g a a, d4. bes8 8 8 c c c c c e f f a, bes8 8 8
f' f f g c, c f4 8 c a' f g e c f f f bes, c c
f a, c f4 c8 f d a bes c c f4 r8
\bar "||" \time 4/4
2 c c4 d b g c1
\bar "||"
R1*6
f2. 4 g8 f g a g a f g a4 f8 g a4 b c2 e,4 c f a
g2 c c, f4 f f e g g g c a g f e f2 d bes8 a bes c 
bes d c bes a4 c f2~2 e f r r1*2
c2. 4 d8 c d e d e c d e4 d8 c d4 e
f1 c g' d a'2 bes g a d,4 e f d
g2 a d,2. 4 c2. 4 f2 a g2. 4 f2. 4 d2. 4
c2 d4 a bes2 c f1 r2 2 bes,4 a bes a bes2 2
f'1\fermata \fine
}


piano = \new PianoStaff \with { instrumentName = "Basso Cont." 
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
      \vioa
      \viob
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
    \vioa
    \viob
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
<<
 \vioa
 \viob
 \piano
>>
  }
}

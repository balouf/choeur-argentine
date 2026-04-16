% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Misa a San Ignacio"}
  composer = "Dominico Zipoli (1688-1726)"
  subtitle = "2 - Gloria"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

allegro = {
\tempo "Allegro" 2 = 72
}

adagio = {
\tempo "Adagio" 2 = 72
}

rall = \markup {\italic "rall."}
solo = \markup {\italic [Solo]}
tutti = \markup {\italic [Tutti]}


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 2/2
\allegro
\key f \major
}


sop_mus = {
  R1*2 c'4 8 8 \breathe e4 8 8 \breathe a,4 8 8 \breathe c4 4
  d8( c) bes( a) g2 a r
  r^\solo c8( bes c d bes a bes c a g a bes g4.) 8 4 r
  c--^\tutti 4-- 4---> 4--
  r2^\solo a8( g a bes g a g a f e f g e4.) 8 4 r
  a--^\tutti 4-- 4---> 4--
% Page 2
r2  a8 (^\solo bes8
   g8  a8 | % 4
   bes8  c8  a8  bes8 g8
   a8  f8  g8 | % 5
   a4. )  a8  a4 r4 | % 6
   c4--^\tutti c4--  c4---> e4--
   a,4--  a4--  a4--->  c4-- | % 8
   bes8 (  c8   a8  bes8
  g2)
   a2 r2 | 
   a8 (^\solo  bes8   a8  bes8  c4)
   bes8  a8 | % 11
   g4  c4  c4 bes8(  a8 )
   g8(  c8 bes8  a8  g2)
   % Page 3
   a2  r2 | % 2
   c4^\tutti  c8  c8  e4  e8
   e8 | % 3
   a,4  a8  a8  c4  c4 | % 4
   d8(  c8)  bes8 (  a8 )  g2
  | % 5
   f2 r2 | % 6
   a8 (^\solo bes8)  a8(  bes8 )
   c4  bes8 (  a8 ) | % 7
   g8 (  c8  bes8  a8  g2
  ) | % 8
   a2 r2 | % 9
   c8 ^\tutti  c8
   e8  e8  a,8  a8  c8
   c8 
   f,8  f8  a8  a8^\rall  g2 | % 11
  a1 | % 12
  R1
  % P4
  R1*2 \bar "||" \adagio
  d2.. r8 \breathe | % 4
  a2.. r8 \breathe | % 5
  f2.. r8 \breathe | % 6
  d2.. r8 | % 7
  r2  a'2  | % 8
  d2  bes2 | % 9
   g2  a2 |
   g2.  g4 | % 11
   c,2 r2 | % 12
   c'2 r2 | % 13
   d2 r2 | % 14
   g,2  c2
   % P5
   c b c1 R1*7
   r4 a^\tutti a a bes8( c a bes g a f g a2) r
   %P6
   r4 c c8( d) e( d) c4 4 8( d) e( d) c2 r
   a8(^\solo bes) a( bes) c4 bes8 a g( f g a bes a bes c a4) r r2
   r4 c^\tutti c8( d) e( d) c4 8 8 a4 8 8 f2 r
   r4 d'^\solo d d c a8 bes c4 d8 c bes8( a g a bes d c bes
   %P7
   a bes a bes c4 bes8 a g2) c2 4 d8( c) b4. c8 2 r R1*6
   2^\tutti 8( d) bes( c) a2~( 8 bes g a)
   %P8
   f4 d' d d c c r c d8( c) bes( a) g4. 8 a2 r4 c d d 
   g,4.^\rall 8 a1
   \bar "||" \time 6/8 \adagio
   a4.~^\solo 8 b cis d e f cis4. d r r2. a4.~8 b cis d e f cis4. 
   d4. r r f4 d8 bes( c) d c d bes a( g) f r4. c'8( bes c a bes c d c d bes c d
   e) d c r4. f4.(~8 e d e) d c b4. c r r2. r4. c4 d8
   bes( a) bes d c bes a a r r4. r f'8 8 e d e f e f d cis( b) a r4. e'4 a,8 4 e'8
   f\( e d\) cis4. d r bes4 a8 g4 8 e'( d e a, b cis d) e f cis4. d2.
   \bar "||" \time 2/2
   R1*22
   f2.^\solo  e8 d c4 bes8( a) bes4 c a8 g f4 r2 r d' c r r bes a r r f'8( e f g
   e d e f d4) e8( f) d2 c a g r1 a4( b8 c d e f d b4) c8( d) b2 c1
   \bar "||" \time 6/8
   R2.*17
   \bar "||" \time 2/2 \adagio
   %P15
   r2 a^\tutti 1 g r2 c a1~2 bes4( a) g1
   %P16
   g c2. d4 es4 4 4 4 2 d c1 bes2 4 4 4 4 a a
   g1 f2 f'4 4 4 es4 4 4 2 d g, c4( bes) a2 bes bes( a)^\rall bes1
   \bar "||" \time 3/4
   %P17
   r2 d4^\solo d c r8 f f( bes,8) 2 r2 bes4 4 a r8 d d( g,) 2 r2 4
   f8 bes es,2 d d'4 c8 f bes,2 a2.
   \bar "||" \time 4/4 \allegro
   c4^\tutti 8 8 4 8 8 4 8 8 r2
   d4 a8 8 4 8 8 4 8 8 r2
   d4 8 8 c4 8 8 d4 8 8 r2
   bes4 4 4 4 2 a r c4 4 d2. e8( d)
   c4 4 2~4 d8( c) bes2~4 c8( bes) a2~(
   4 bes8\( a\) g2~4 a8 g) f2 \breathe g( a4 bes c2. bes8 a g1) a
   \bar "||" \time 3/4 R2.*32 
   \time 4/4 R1*21 \bar "||" R1*19 \bar "||"
c2^\tutti a4 f d'4. 8 4 4
c bes8\( a\) g4 f8( e) f( e f g f a g f e4) c
f2~4 4 4 4 2( g a8 g a bes) c2
% P26
r1 g2 e4 c a'4. 8 4 4 g f8 e d4 g e c
c'2~( 4 bes8 a bes d c bes a4 bes) c2
r4 4( a f bes a bes c)
f, bes( a8 c bes a g1) f\fermata
\fine
}


sop_lyr  = \lyricmode {
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.
Glo -- ri -- a in ex -- cel -- sis
Glo -- ri -- a in ex -- cel -- sis
Glo -- ri -- a in ex -- cel -- sis
in ex -- cel -- sis De -- o.
Glo -- ri -- a
in ex -- cel -- sis De -- o.
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.
in ex -- cel -- sis De -- o.
in ex -- cel -- sis in ex -- cel -- sis
in ex -- cel -- sis De -- o.

Et in ter -- ra in ter -- ra pax ho -- mi -- ni -- bus
pax pax pax ho -- mi -- ni -- bus
Lau -- da -- mus te. __
Lau -- da -- mus te. Lau -- da -- mus te.
Be -- ne -- di -- ci -- mus te. __
Lau -- da -- mus te. Be -- ne -- di -- ci -- mus  te.
Lau -- da -- mus te. Be -- ne -- di -- ci -- mus  te. __
Be -- ne -- di -- ci -- mus  te. Glo -- ri -- fi -- ca -- mus
glo -- ri -- fi -- ca -- mus glo -- ri -- fi -- ca -- mus te.
Glo -- ri -- fi -- ca -- mus te.

Gra -- ti -- as a -- gi -- mus ti -- bi
Gra -- ti -- as a -- gi -- mus ti -- bi
pro -- pter ma -- gnam glo -- ri -- am tu -- am
glo -- ri -- am glo -- ri -- am tu -- am

pro -- pter ma -- gnam glo -- ri -- am tu -- am.
Gra -- ti -- as a -- gi -- mus a -- gi -- mus ti -- bi
pro -- pter ma -- gnam glo -- ri -- am tu -- am
pro -- pter ma -- gnam glo -- ri -- am tu -- am.

Do -- mi -- ne Fi -- li u -- ni -- ge -- ni -- te
Je -- su Je -- su Je -- su Chri -- ste 
Je -- su Je -- su Chri -- ste.

Qui tol -- lis pec -- ca -- ta mun -- di,
mi -- se -- re -- re mi -- se -- re -- re no -- bis
mi -- se -- re -- re mi -- se -- re -- re 
mi -- se -- re -- re mi -- se -- re -- re 
mi -- se -- re -- re no -- bis.

Qui to -- lis qui to -- lis qui to -- lis qui to -- lis
pec -- ca -- ta mun -- di, pec -- ca -- ta mun -- di,
su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe

de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem no -- stram.

Cum San -- cto Spi -- ri -- tu,
in glo -- ri -- a De -- i Pa -- tris.
De -- i Pa -- tris. A -- men.

Cum San -- cto Spi -- ri -- tu,
in glo -- ri -- a De -- i Pa -- tris.
A -- men. A -- men. A -- men.
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_mus}
  \addlyrics {\sop_lyr}
>>

alt_mus = {R1*2
a'4 8 8 \breathe g4 8 8 \breathe f4 8 8 \breathe a4 4 d,8( e) f4 4( e) f2 r
R1*3 a4-- g-- a---> g-- R1*3 f4-- e-- f---> e-- R1*3 a4-- g-- a---> g--
f4--  e4--  f4--->  a4-- | % 8
g8 (  a8  f8  g8  e2 )
f2 r2 R1*3
% P3
R1 | % 2
   a4  a8  a8  g4  g8  g8 | % 3
   f4  f8  f8  f4  a4 | % 4
   d,8 (  e8 )  f4  f4 (  e4 ) | % 5
   f2 r2 | % 6
  R1 | % 7
  R1*2 | % 9
   a8  a8  g8  g8  f8  f8
   e8 e8 
   d8  d8  c8  f8  f4 (  e4
  ) | % 11
  f1 | % 12
  R1
  % P4
  R1*2 \bar "||"
  R1*4 | % 7
  r2  f2 | % 8
  f2  g2 | % 9
   e2  f2 |
   f2  e2 | % 11
   f2 r2 | % 12
   a2 r2 | % 13
   f2 r2 | % 14
   d2  e2
   d2. 4 e1 r2
   f~^\solo4 d g f e2. c4 f( g)
   a( g8 f g2.) a8( g f2.) e8( d) e1 d4
   f^\tutti f f g8( a f g e f d e f2) r
   %P6
   r4 a g g a a g g a2 r
   f8(^\solo g) f( g) a4 g8 f e( d e f g f g a f4) r r2
   r4 a^\tutti g g a g8 8  f4 e8 8 d2 r
   r4 bes'4^\solo 4 4 a f8 g a4 bes8 a g( f e f g bes a g
   %P7
   f g f g a4 g8 f e2) g g4 f8( e) d4 8( c) 2 r R1*6
   a'8(^\tutti g a bes) a( bes) g( a) f( e f g f g e f
   d c d e f e f g a4) 4 r f d8( e) f4 4 e f2 r4 f f f f e f1
   \bar "||" \time 6/8
   R2.*30
   \bar "||" \time 2/2
   R1*5 d2.^\solo e8 f e4 4 4 f8( g) f( e) d4 r f8 c d4 e8 f f4 e f2 r4
   f8 c d( e c d e f d e f g e f g a f g a4) e f2~( 4 g8 d) e4. 8 f1
   r2 c4 4 d8( c d e c4 f e8 f g a) f2 a g4 f e4. f8 2
   R1*17
   \bar "||" \time 6/8
   c4.~^\solo 8 d e f4 8 4 8 8 d4 r4. d~8 e f g4. 8 8 8
   f e4 r4. e4( f8) g4 d8 cis( d e a,4 e'8) f( e d) r4. es~8 f d cis4( d8 f4 e8)
   d4. r a'~8 g f e4( a8~4 gis8) a2. r r
   \bar "||" \time 2/2
   %P15
   r2 f^\tutti 1 e2 2 g1~( 2 f4 e) f1~2 e4( d)
   %P16
   e1 R1*2 d2. es4 f f f f f2 es d c
   bes'2 2 a bes2 2 g f~4 4 4 es4 4 4 2 d c1 d
   \bar "||" \time 3/4
   R2.*11
   \bar "||" \time 4/4
   a'4^\tutti 8 8 g4 8 8 a4 8 8 r2
   f4 8 8 e4 8 8 f4 8 8 r2
   f4 8 8 4 8 8 4 8 8 r2
   d4 4 4 4 c2 2 f4 g a2~4 g8( f)
   g2~( 4 f8 e) f2~2. g8 f e2. f8( e)
   d2.( e8 d) c2.( f4)  \breathe e2( f g a4 f~2 e) f1
   \bar "||" \time 3/4 R2.*32 
   \time 4/4 R1*21 \bar "||" R1*19 \bar "||"
R1*2 f2^\tutti e4 c a'4. 8 4 4 g e8 d c4 f
bes8( a bes c bes d c bes a4) f c2~4 4 4 4
c2( d e8 d e f) g2 R1*2 c,2 f4 a d, d d d
c d8 8 e4 4 f f f2~( 4 es8 d es g f es d4 e)
f2~4 e8( d e2) f1\fermata
\fine
}


alt_lyr  = \lyricmode {
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.  
in ex -- cel -- sis in ex -- cel -- sis
in ex -- cel -- sis
in ex -- cel -- sis De -- o.  
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.  
in ex -- cel -- sis in ex -- cel -- sis
in ex -- cel -- sis De -- o.
in ter -- ra pax ho -- mi -- ni -- bus
pax pax pax ho -- mi -- ni -- bus
bo -- nae vo -- lun -- ta -- tis
bo -- nae vo -- lun -- ta -- tis.
Lau -- da -- mus te. __
Lau -- da -- mus te. Lau -- da -- mus te.
Be -- ne -- di -- ci -- mus te. __
Lau -- da -- mus te. Be -- ne -- di -- ci -- mus  te.
Lau -- da -- mus te. Be -- ne -- di -- ci -- mus  te. __
Be -- ne -- di -- ci -- mus  te. Glo -- ri -- fi -- ca -- mus
glo -- ri -- fi -- ca -- mus te.
Glo -- ri -- fi -- ca -- mus te.

Do -- mi -- ne De -- us, Rex cae -- le -- stis,
De -- us Pa -- ter o -- mni -- po -- tens
De -- us Pa -- ter o -- mni -- po -- tens
De -- us Pa -- ter Pa -- ter o -- mni -- po -- tens.

Do -- mi -- ne De -- us, A -- gnus De -- i,
Do -- mi -- ne De -- us, A -- gnus De -- i,
Fi -- li -- us Pa -- tris Fi -- li -- us Pa -- tris
Fi -- li -- us Pa -- tris.

Qui tol -- lis pec -- ca -- ta mun -- di,
mi -- se -- re -- re mi -- se -- re -- re
mi -- se -- re -- re mi -- se -- re -- re 
mi -- se -- re -- re mi -- se -- re -- re 
no -- bis.

su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe

de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem no -- stram.

Cum San -- cto Spi -- ri -- tu,
in glo -- ri -- a De -- i Pa -- tris. De -- i Pa -- tris.
A -- men.
Cum San -- cto Spi -- ri -- tu,
in glo -- ri -- a De -- i Pa -- tris.
A -- men. A -- men.
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_mus}
  \addlyrics {\alt_lyr}
>>

ten_mus = {R1*2
f'4 8 8 \breathe c4 8 8 \breathe d4 8 8 \breathe a4 4 bes f d'2 f, 2 r
R1*3 f'4-- e-- f---> c-- R1*3 d4-- cis-- d---> a--
R1*3 f'4-- e-- f---> c--
   d4--  c4--  d4--->  a4--
   bes2 (  c2 )  
   f,2  r2 
  R1*3
% P3
  R1 | % 2
   f'4  f8  f8  c4  c8
   c8 | % 3
   d4  d8  d8  a4  a4 | % 4
   bes4  f4  c'2 | % 5
   f,2 r2 | % 6
  R1 | % 7
  R1*2 | % 9
   f'8  f8  c8  c8  d8
   d8  a8  a8 
   bes8  bes8  f8  f8  c'2 | % 11
  f,1 | % 12
  R1
% P4
  R1*2 \bar "||"
  d'2.. r8 \breathe | % 4
  a2.. r8 \breathe | % 5
  f2.. r8 \breathe | % 6
  d2.. r8 | % 7
  r2  d'2  | % 8
  bes2  g2 | % 9
   c2.  c4 |
   bes2.  bes4 | % 11
   a2 r2 | % 12
   f'2 r2 | % 13
   d2 r2 | % 14
   b2  c2
   % P5
   g2. 4 c2 2~^\solo 4 a d c
   bes2.( g4 c bes) a2~4 c f2~4
   e8( d e2~4) a, d2~(2 cis) d r R1*2
   %P5
   r4^\tutti f e c f f e c f2 r2 R1*3
   r4 f e c f c8 8 d4 a8 8 bes2 r2 R1*3
   %P7
   R1*3 r2 c~^\solo 4 bes8( a) bes( a bes c) a2 f'~4
   es8( d) es( d es f) d2 bes~4 a g4. 8 f1
   f'8(^\tutti e f g) f4 c d8( c d e d4 a
   %P8
   bes8 a bes c d c d e f4) 4 r a, bes f c'4. 8 f,2
   r4 f' d bes c4. 8 f,1
   \bar "||" \time 6/8
   R2.*30
   \bar "||" \time 2/2
   R1*20
   f'2.^\solo e8 d c4 bes8( a) bes4 c a8 g f4 r2 r1
   r2 d' c r r bes a r r f'8( e f g e d e f d c d e c b c d b4) c8( d) b2 c
   r1 a2 g f( f'~4) e8( f) d2 c1
   \bar "||" \time 6/8
   R2.*17
   \bar "||" \time 2/2
   %P15
   r2 c^\tutti 1 1 r2 e, f1~2 d' b1
   %P16
   c r g2. a4 bes4 4 4 4 2 a g1 f2 f'4 4 4 es4 4 4
   2 d g,2. 4 a2 bes es,1 f f bes
   \bar "||" \time 3/4
   R2.*11
   \bar "||" \time 4/4
   f'4^\tutti 8 8 e4 8 8 f4 8 8 r2
   d4 8 8 cis4 8 8 d4 8 8 r2
   bes4 8 8 a4 8 8 bes4 8 8 r2
   g4 4 4 f e2 f r2 4 4 bes2. c8( bes) a2 2
   d2. e8( d) c2. d8( c)
   bes2.( c8 bes) a2.( f4)  \breathe c'2( f e4 c f2 c1) f,
   \bar "||" \time 3/4
   f'4^\solo e8( c d e f4) e8( d) c( bes) a( bes) a( g) f4 r2 d'4 bes g c f,8( e f g a bes
   c bes c d e c f4) e2 r4 d c b g( c~8 d) b2 c r4
   R2.*2 r4 f( e) d( bes a) g e'( d) c8( bes a4) g
   f d'( c bes8 a g4 f e c' bes a8 g) f4 r r es'4 4 4 d r r f f
   e c( f) f8( bes, a4 g) f2. d'2 4 e,2 f4~( 8 bes) a4( g) f2.
   \time 4/4 R1*21 \bar "||" R1*19 \bar "||"
   R1*4
c'2^\tutti a4 f d'4. 8 4 4 c bes8 a g4 c f,8( e f g a g a bes
c g c2 b4) c2 r4 e( f8 g f e d e f d e4 d8 c b c a b c2) f,
bes8( a bes c bes4 g a g8 f e f d e) f1
g4\( f\) g\( a\) bes( a) f2 c'1 f,\fermata
\fine
}


ten_lyr  = \lyricmode {
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.  
in ex -- cel -- sis  in ex -- cel -- sis
in ex -- cel -- sis
in ex -- cel -- sis De -- o.  
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.  
in ex -- cel -- sis in ex -- cel -- sis
in ex -- cel -- sis De -- o.
Et in ter -- ra in ter -- ra pax ho -- mi -- ni -- bus
pax pax pax ho -- mi -- ni -- bus
bo -- nae vo -- lun -- ta -- tis
bo -- nae vo -- lun -- ta -- tis.
Lau -- da -- mus te. Lau -- da -- mus te.
Lau -- da -- mus te. Be -- ne -- di -- ci -- mus  te.
A -- do -- ra -- mus a -- do -- ra -- mus a -- do -- ra -- mus te.
Glo -- ri  -- fi -- ca -- mus
glo -- ri -- fi -- ca -- mus te.
Glo -- ri -- fi -- ca -- mus te.

Do -- mi -- ne Fi -- li u -- ni -- ge -- ni -- te
Je -- su Je -- su Je -- su Chri -- ste 
Je -- su Je -- su Chri -- ste.


Qui tol -- lis pec -- ca -- ta mun -- di,
mi -- se -- re -- re mi -- se -- re -- re
no -- bis mi -- se -- re -- re 
mi -- se -- re -- re no -- bis.
mi -- se -- re -- re no -- bis.

su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe

de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem no -- stram.

Qui se -- des ad dex -- te -- ram 
ad dex -- te -- ram Pa -- tris,
mi -- se -- re -- re no -- bis.
Qui se -- des ad dex -- te -- ram Pa -- tris,
mi -- se -- re -- re mi -- se -- re -- re no -- bis
mi -- se -- re -- re no -- bis.

Cum san -- cto Spi -- ri -- tu,
in glo -- ri -- a De -- i Pa -- tris.
A -- men. A -- men. De -- i Pa -- tris.
A -- men. A -- men.
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\ten_mus}
  \addlyrics {\ten_lyr}
>>

bass_mus = {R1*2
f4 8 8 \breathe c4 8 8 \breathe d4 8 8 \breathe a4 4 bes f' d2 f2 r
R1*3 f4-- e-- f---> c-- R1*3 d4-- cis-- d---> a--
R1*3 f'4-- e-- f---> c--
   d4--  c4--  d4--->  a4--
   bes4( f'  c2 )  
   f2  r2 
  R1*3
% P3
  R1 | % 2
   f4  f8  f8  c4  c8
   c8 | % 3
   d4  d8  d8  a4  a4 | % 4
   bes4  f'4  c2 | % 5
   f2 r2 | % 6
  R1 | % 7
  R1*2 | % 9
   f8  f8  c8  c8  d8
   d8  a8  a8 
   bes8  bes8  f'8  f8  c2 | % 11
  f1 | % 12
  R1
% P4
  R1*2 \bar "||"
  d'2.. r8 \breathe | % 4
  a2.. r8 \breathe | % 5
  f2.. r8 \breathe | % 6
  d2.. r8 | % 7
  r2  d'2  | % 8
  bes2  g2 | % 9
   c2.  c4 |
   bes2.  bes4 | % 11
   a2 r2 | % 12
   f2 r2 | % 13
   d2 r2 | % 14
   b2  c2
   % P5
   g'2. 4 c,1 R1*10
   r4 f e c f f e c f2 r2 R1*3
   r4 f e c f c8 8 d4 a8 8 bes2 r2 R1*3
   %P7
   R1*10
   f'2^\tutti f4 c d2~( d4 a
   %P8
   bes8 a bes c d c d e f4) 4 r a bes f c'4. 8 f,2
   r4 f d bes c4. 8 f1
   \bar "||" \time 6/8
   R2.*30
   \bar "||" \time 2/2
   R1*37
   \bar "||" \time 6/8
   R2.*17
   \bar "||" \time 2/2
   %P15
   r2 c'^\tutti 1 1 r2 e, f1~2 d' b1
   %P16
   c r g2. a4 bes4 4 4 4 2 a g1 f2 
   f g1 a2 bes es,2. 4 a2 bes es,1 f2( bes,) f'1 bes,
   %f'4 4 4 es4 4 4
   %2 d g,2. 4 a2 bes es,1 f f bes
   \bar "||" \time 3/4
   R2.*11
   \bar "||" \time 4/4
   f'4^\tutti 8 8 e4 8 8 f4 8 8 r2
   d4 8 8 cis4 8 8 d4 8 8 r2
   bes'4 8 8 a4 8 8 bes4 8 8 r2
   g4 4 4 f e2 f r2 4 4 bes2. c8( bes) a2 2
   d2. e8( d) c2. d8( c)
   bes2.( c8 bes) a2.( f4) \breathe c2( f e4 c f2 c1) f
   \bar "||" \time 3/4 R2.*32 
   \time 4/4 R1*21 \bar "||" R1*19 \bar "||"
   R1*4
c'2^\tutti a4 f d'4. 8 4 4 c bes8 a g4 c f,8( e f g a g a bes
c g c2 b4) c2 r4 e,( f8 g f e d e f d e4 d8 c b c a b c2) f
bes,8( a bes c bes4 g' a g8 f e f d e) f1
g4\( f\) g\( a\) bes( a) f2 c'1 f,\fermata
\fine
}


bass_lyr  = \lyricmode {
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.  
in ex -- cel -- sis  in ex -- cel -- sis
in ex -- cel -- sis
in ex -- cel -- sis De -- o.  
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.  
in ex -- cel -- sis in ex -- cel -- sis
in ex -- cel -- sis De -- o.
Et in ter -- ra in ter -- ra pax ho -- mi -- ni -- bus
pax pax pax ho -- mi -- ni -- bus
Lau -- da -- mus te. Lau -- da -- mus te.
Lau -- da -- mus te. Be -- ne -- di -- ci -- mus  te.

Glo -- ri  -- fi -- ca -- mus
glo -- ri -- fi -- ca -- mus te.
Glo -- ri -- fi -- ca -- mus te.

Qui tol -- lis pec -- ca -- ta mun -- di,
mi -- se -- re -- re mi -- se -- re -- re
no -- bis 
mi -- se -- re -- re no -- bis.
mi -- se -- re -- re no -- bis.

su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe
su -- sci -- pe su -- sci -- pe su -- sci -- pe

de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem
de -- pre -- ca -- ti -- o -- nem no -- stram.

Cum san -- cto Spi -- ri -- tu,
in glo -- ri -- a De -- i Pa -- tris.
A -- men. A -- men. De -- i Pa -- tris.
A -- men. A -- men.
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\bass_mus}
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
  \relative c' {
a''8 8 8 8 g g g g a4 bes8( a) g g g g
a a a a g g g g f f f f c c c c 
d( e) f f g2 a8 8 8 8 g g g g
f4 f, c'8 bes c d bes a bes c a g a bes g2
e'8 c d e f f g g a a g g f g a f d4 d,
g'8 f g a f e f g e2 a,8 e'f g a a a a a a a a
a4  a,4  a8 bes8 g8 
a8 | % 4
bes8  c8  a8  bes8 
g8  a8  f8  g8 | % 5
a2  a8  a8  c8  c8 | % 6
f8  f8  g8  g8  a8
a8  g8  g8 | % 7
   f8  f8  e8 e8  f8
   f8  e8  e8 | % 8
   d8 (  e8 )  f8  f8  g8
   g8  g8  g8 | % 9
   f4  f,4  a8  a8  c8
   f8 | 
   a8 (  bes8 )  a8  bes8
   c4  bes8  a8 | % 11
   g4  c4  c4  bes8 (  a8
  ) | % 12
   g8 (  c8 )  bes8  a8 
  g2
%P3
   f2 r4  f4 | % 2
   a8  a8  a8  a8  g8
   g8  g8  g8 | % 3
   f8  f8  f8  f8  c8
   c8  c8  c8 | % 4
   d8  e8  f8  f8  g8
   g8  g8  g8 | % 5
   f4  f,4  a8  a8  c8
   f8 | % 6
   a8  bes8  a8  bes8  c4
   bes8  a8 | % 7
   g8  c8  bes8  a8  g2 | % 8
   f2 r2 | % 9
   a8  a8  g8  g8  f8
   f8  e8  e8 |
   d8  d8  a'8  a8  g8
   g8  g8  g8 | % 11
  a1 | % 12
   a8  a8  a8  a8  g8
   g8  g8  g8
%P4
   a4  bes8  a8  g8 (  a8
  )  f8  g8 | % 2
  a1 \bar "||" \adagio
  d,1 | % 4
  a1 | % 5
  f1 | % 6
  d1 | % 7
   d'2  f4 ~  f4 | % 8
   d4 ~  d4  bes'4 ~  bes4 | % 9
   bes4 ~  bes4  a4 ~  a4 |
   g4 ~  g4  g4 ~  g4 | % 11
   f2 r2 | % 12
   a2  f8 (  g8 )  a8  g8
  | % 13
   f2  d8 (  e8 )  f8  e8
  | % 14
   f4 ~  f4 (  e4 ) ~  e4
   %P5
   d1 e c4 a d c bes2 g e2. c4 f g a g8 f
   g2. a8 g f2. e8 d e1 f4 a' a a bes 
   a8 bes g a f g a2 r8 c, d e
   %P6
   f4 a8 8 g f e e f4 f, r2 f'4 f, r2
   a'8( bes) a bes c4 bes8( a) g( f) g a bes( a) bes c a2
   r8 c, d e f4 a8 8 g( e) f( g) a a g g f f e e d( c) bes a bes2
   r4 d d d c a8 bes c4 d8 c bes a g a bes d c bes
   a bes a bes c4 bes8 a g2 c c4 d8( c) b4. c8
   2 e4 4 f f f g c,2 4 a bes4 4 4 c f,2 r e4 f c2 f1
   a'8 8 8 8 8 8 g g f f f f f f e e
   %P8
   d c d e f e f g a2 r4 c, bes' a g8 8 8 8 a2 r4 4 f bes8 a g g g g f1
   \bar "||" \time 6/8
   R2.*2 a8( f g) a( g a) bes( a g) f( g e) d4 r8 r4. r2.
   a'8( g f) e4.\trill d r r2. f8( e f) f( e f) f( g a) f4. r2.
   e8( f g) a( bes e,) f4. r r2. e8( f g) a( bes e,) f g a e f d c4. r
   r2. f8 e f f e f f g a f4. r2. a8 a, a'a g f e4. r
   r2. d8 cis d d cis d d4. r r a' a8 g f e4. d2.
   \bar "||" \time 2/2
   d4 2 e8 f e4 a, e' f8 g f e d4 f8 g a f bes a g f e a f d f e d cis d2 4 2 e8 f
   e4 a, e' f8 g f e d4 r f8 c d4 c8 d bes4. a8 a2 r4 f'8 c d e c d e f d e f g e f g a f g
   a4 e f2~4 g8 d e4. 8 a g f e f c d bes c4 f c c d8 c d e c4 f bes,8 a bes c a2
   a' g4 f e4. f8 2 r1 f,4 f' f e f r r2 f,4 f' f e
   f a, bes bes' a a, bes bes' a f f e f f, f e f f' r2 r f8 e f g
   e d e f d4 e8 f d2 g4 4 a c, c c a' c, c c f,2 f' f4 e8( f) d2 c1
   \bar "||" \time 6/8
   c4.~8 d e f4 8 4 8 8 bes8 8 8 8 8 4. d,8 e f g4 8 4 8
   8 c c c c c cis4 d8 g,4 d8 cis d e a,4 e'8 f e f r f d es4 8 8 f d cis4 d8 f4 cis8
   d a' a a bes g a4. 8 g f e d c b4. a e'4 8 8 d c b4. a2.
   \bar "||" \time 2/2
   %P15
   r2 c f a g1 r2 2 a a, a' bes4 a g2 f
   %P16
   e1 R1*2 r4 d d es f f f f bes4 4 4 4 2 a
   g4 4 4 4 f2 2 4 es4 4 4 2 d g,4 g' g g f es d bes'4 2 a d1
   \bar "||" \time 3/4
   bes,4 4 d d c r8 f f bes,8 2 g4 4 bes4 4 a r8 d d g,8 2 es'4 4 g
   f8 bes es,2 d2 4 c8 f bes,2 a2.
   \bar "||" \time 4/4
   a'8 8 8 8 g g g g
   %P18
   a8 8 8 8 16 g a bes a bes a g f8 8 8 8 e e e e
   f8 8 8 8 16 es f g f g f es d8 8 8 8 c c c c
   d8 8 8 8 16 c d e f g a f bes8 8 8 8 8 8 a a
   g e f g a4 a, r2 a'4 4 4 bes8 a g4 4 4 a8 g f4 4 4 4 4 g8 f e4 4 4 f8 e
   d4 e8 f g4 4 4 f8 e f4 a g8 e f g a g a f g e f g a a a a
   g g g g g g g g a1
   \bar "||" \time 3/4
f4 e8 c d e f4 e8 d c bes a bes a g f4 d' f d bes g c f,8 e f g a bes
c bes c d e c f4 e2 a,4 d c b g c c8 d d2 c g'8 e
a4 g8 f e d e f g e c4 4 f e d bes a g e' d c8 bes a4 g
f d' c bes8 a g4 f e c' bes a8 g f4 r es es'4 4 4 d r f, f' f
e c f f8 bes, a4 g f2. d'4 4 4 e2 f4 8 bes a4 g f2.
   \time 4/4 R1*21 \bar "||" R1*19 \bar "||"
c2 a4 f d'4. 8 4 4 c bes8 a g4 f8 e f e f g f a g f
c'2 a4 f d'4. 8 4 4 c bes8 a g4 f8 e f e f g a4 a'
a8 8 g g f a g f e f e d c g' f g
a g f e f g a f g4 f8 e d f e d
c4 d8 e f4 4 4 g8 a bes4 bes, c d e8 f g e f1
bes,8 8 a a bes8 8 c c d d e e f a g f f4 e8 d e2 f1\fermata
\fine
}
>>

viob= \new Staff \with {instrumentName="Violin 2"
  shortInstrumentName ="V.2"} <<
  \violin_style
  \armure
  \relative c' {
c'8 8 8 8 8 8 8 8 f4 g8( f) e e e e
f f f f e e e e d d d d f f f f
bes,( c) d d f f e e f f f f e e e e
f4 f, a8 g a bes g f g a f e f g e2
e'8 c d e a, a g g c c c c a bes c a f2
e'8 d e f d cis d e cis2 a8 cis d e
f f e e f f e e
f2  f,8  g8  e8  f8 | % 4
g8  a8  f8  g8  e8  f8
d8  e8  | % 5
f2  f8  f8  a8  a8 | % 6
a8  a8  c8  c8  c8
c8  e8  e8 | % 7\fine
   a,8  a8  a8  a8  a8  a8
   c8  c8 | % 8
   bes8 (  c8 )  d8  d8 
  e8 e8  e8  e8 | % 9
   a,2  f8  f8  a8  c8 |
   f8 (  g8 )  f8  g8  a4
   g8  f8 
   e4   e4  e4  g8  f8 | % 12
   e4  f4  f4 (  e4 )
   f2 r4  f4 | % 2
   c8  c8  c8  c8  e8
   e8  e8  e8 | % 3
   a,8  a8  a8  a8  f'8 
  f8  f8  f8 | % 4
   bes,8  c8  d8  d8  f8
   f8  e8  e8 | % 5
   f4  f,4  f8  f8  a8  c8
  | % 6
   f8  g8  f8  g8  a4
   g8  f8 | % 7
   e4  f4  f4 (  e4 ) | % 8
   f2 r2 | % 9
   c8  c8  e8  e8  a,8
   a8  c8  c8 
   bes8  bes8  f'8  f8  f8
   f8  e8  e8 | % 11
  f1 | % 12
   f8  f8  f8  f8  e8
   e8  e8  e8
%P4
   f4  g8  f8  e8 (  f8 )
   f8  e8 | % 2
  f1 \bar "||"
  d1 | % 4
  a1 | % 5
  f1 | % 6
  d1 | % 7
   d'2  a4 ~  a4 | % 8
   bes4 ~  bes4  g'4 ~  g4 | % 9
   g4  g4  c,4  c4 |
   bes4  bes4  bes4  bes4 | % 11
   a2 r2 | % 12
   f'2  f8 (  e8 )  f8  e8
  | % 13
   d2  b8 (  c8 )  d8  c8
  | % 14
   d4  d4  c4  c4
%P5
c2 b c1 r2 f,~4 d g f c'bes a2 4 c f2~4
e8 d e2~4 a, d2~2 cis d4 f f f
g f8 g e f d e f2 r8 c d e
f4 c8 8 8 8 8 bes a2 r a r
f'8( g) f g a4 g8( f) e( d) e f g f g a f2
r8 c d e f4 c8 8 8 8 8 8 8 8 8 8 a a a a
bes( a) bes a bes2 r4 bes4 4 4 a
f8 g a4 bes8 a g f e f g bes a g
%P7
f g f g a4 g8 f e2 g g4 f8 e d4. c8 2 c'~4 bes8( a) bes( a bes c) a2 r
r4 es'4 4 4 d2 bes~4 a g4. 8 f1 f'8 8 8 8 8 8 e e d d d d d d c c
%P8
bes a bes c d c d e f2 r4 c d8 e f f f f e e f2 r4 4 4 g8 f f f e e f1
\bar "||" \time 6/8
R2.*2 f8( d e) f( e f) g f e d e cis d4 r8 r4. r2.
f8( e d) 4( cis8) d4. r r2. a8( bes c) d( c bes) c( bes c) a4. r2.
e'8( f g) a( bes e,) f4. r r2. e8( f g) a( bes e,) f4 c8 c d b c4. r
r2. a8 bes c d c bes c bes c a4. r2. a'8 a, a' f e d cis4. r
r2. f,4 g8 a g f bes4. r r cis4 e8 f e d cis4. d2.
\bar "||" \time 2/2
f,4 2 d4 a'2 r4 4 d2 f8 g a f g f e d cis e f d f e d cis d2 f,4 2 d4
a'2 r4 4 d2 c4 f, bes f2 e4 f2 c'4 a bes a g f a2 g4 c
f bes, a2 g4 2 4 a'8 g f e f c d bes c4 f c f, f2 4 c' e,2 f
f' e4 d c2 a r1 f4 c' bes2 a4 c r2 f,4 c' bes2
a d4 4 c c d d c c bes4 4 a a bes4 4 a2 f'8 e f g e d e f d c d e
c b c d b4 c8 d b2 c4 e f a, g g f a g g a f' f2 b,4 c8 d b2 c1
\bar "||" \time 6/8
c4.~ 8 d e f4 c8 4 8 f4. r d d8 e f g4 d8 4 8
c4. r e4 f8 g4 d8 cis d e a,4 e'8 f e f r f d bes4 8 g4 bes8 e,4 f8 g4.
f8 f' e f g e f4. 8 e d c b a a4 gis8 a4. c4 b8 c b a a4 gis8 a2.
   \bar "||" \time 2/2
   %P15
   r2 c c f c1 r2 c f c f g4 f f2 d
   %P16
   c1 r4 4 4 d es4 4 4 4 2 d r4 c c c f2 es d c
   bes4 4 4 4 c2 d bes4 g g g c2 bes g c4 bes a2 bes c1 bes'
   \bar "||" \time 3/4
   bes,4 4 4 4 a r8 8 d g,8 2 4 4 4 4 f r8 8 es2. es'4 4 4
   bes4 4 a bes2. f4 4 e f2.
   \bar "||" \time 4/4
   f'8 8 8 8 c c c c
   % P18
   f8 8 8 8 16 e f g f g f e d8 8 a8 8 a8 8 8 8 d8 8 8 8
   16 c d es d es d c bes8 8 8 8 f8 8 8 8 bes8 8 8 8
   d16 c d e f g a f d8 8 8 8 8 8 8 8 c8 8 8 8 f4 f, r2
   c'4 4 d d d e8 d c4 4 4 4 4 d8 c bes4 4 4 c8 bes a4 4
   a4 bes8 a g4 e' g, a8 g f4 f' g8 e f g a g a f g e f g f f f f
   f f f f e e e e f1
   \bar "||" \time 3/4
f, 4 g2 a4 bes g f2 r4 d' f d bes g c f,8 e f g a bes
c bes c d e c b4 c2 4 b a g d e c'8 d b2 c g'8 e
a4 g8 f e d e f g e c4 4 f e d bes a g e' d c8 bes a4 g
f d' c bes8 a g4 f e c' bes a8 g f4 r es bes' c c bes r f c' d
g,2 a4 bes8 g f4 e f2. bes4 4 4 g2 a4 bes8 g' f4 e f2.
   \time 4/4 R1*21 \bar "||" R1*19 \bar "||"
 R1*2 f,2 e4 c a'4. 8 4 4 g e8 d c4 bes8 a bes a bes c
 bes d c bes a2 c c c
 c'4 4 4 b c2 8 g' f g a g f e f g a f e4 d8 c b d c b
 c2 4 a d d d d c bes8 a g4 4 a1
 g8 8 f f g g a a bes8 8 g g a c bes a g2 4 4 f1\fermata
\fine
  }
>>

% <<{\voiceOne 
%  }
%  \new Voice {\voiceTwo
%  }
%>> \oneVoice


upper = \relative c' {
  \armure
  \rpiano_syle
<f a>2 <c g'>4 <c g'c>
<f a c> <g d'> <e g c>2
<f a c>4 4 <g c e>4 4
<d f a>4 4 <c f c'>4 4
<<{\voiceOne 
   <bes' d>4 4 <g c>2
 }
 \new Voice {\voiceTwo
   f2. e4
 }
>> \oneVoice
<c f a>2 <c g'>4 <c g' c> <c f a>2 2 <e bes'>
<f a>4 <f g> <e g>2 r
<a c>4 <g c> <a c> < e g c> <f a>1
<g c>2 <a d>4~<bes d>
<e, a cis>2 <e a e'> <a f'>4 <a e'> <f d'> <e cis'>
<f a d>2  <f a>2 | % 4
<d bes'>2~<e bes'> | % 5
<f a>2  <c a'>4  <c a'>4 | % 6
<a'c>4  <g c>4  <f a c>4  <e g c>4 | % 7
<f a>4  <e a>4  <f a>4  <f c'>4 | % 8
<d bes'>2  <e g>2 | % 9
<c a'>2 r2 |
<c f a>2  <c f a>4  <d f bes>4 | % 11
<c e g>2.  <c f a>4 | % 12
<e g>4  <f a>4  <f g>~<e g>
<<
  {\voiceOne 
   a8  bes8  a8  bes8  c8  d8
   c8  bes8 | % 2
   <f a c>4  <f a c>4  <g c e>4  <g c
  e>4 | % 3
   <d f a>4  <d f a>4  <c f c'>4  <c f c'>4
  | % 4
   <d f bes>2  g | % 5
  a1 | % 6
   a2  c4  bes4 | % 7
   g4  a4 <g c,>2 | % 8
   <c, f a>2 r2 | % 9
   <f a c>4  <g c e>4  <d f a>4  <c e
  c'>4 
   f4  a4  g2 | % 11
   a8  g8  a8  bes8  c8 
  d8  c8  bes8 | % 12
   <f a>2  g8  e8  f8  g8
  }
  \new Voice
  {\voiceTwo 
   <c, f>2  <f a>2 s1*2 s2 f4 e | % 5
  f1 | % 6
   <c f a>2  <f a c>4  <d f>4 | % 7
   <c e>4  <c f>4  f4 e s1*2 |
   d4  c4  f4  e4 | % 11
  <c f>1 | % 12
   c2  c2  }
>> \oneVoice
% P4
<c f a>4 <d f bes> <c g'>2 <c f a>1 \bar "||"
<a d f>~1 <d f a>~1 r2 <f a> <f d'> < g bes>
<g c> <a c> <g bes>1 <f a>2 r <f a c> r 
<f a d> e <d g d'> <e g c>
%P5
<<
  {\voiceOne 
   c'2 b <c g e> c2~4 a d c bes1 c a g f e
  }
  \new Voice
  {\voiceTwo 
   d1 s1 s2 f~4 d g f e1 c2 f~2 e~2 d~2 cis
  }
>> \oneVoice
d4 <f a>4 4 4 <d bes'>2 <e g> <f a> <f a c>
r4 <f a c> <c g'c> <e g c> <f a c>2 <g c>
<<
  {\voiceOne 
   a8 g a bes c d c bes
  }
  \new Voice
  {\voiceTwo 
   <f c>2 s
  }
>> \oneVoice
<c f a>2 4 <d g bes> <e g>2 <e bes'>
<<
  {\voiceOne 
   <a c,> <f a>
  }
  \new Voice
  {\voiceTwo 
   f8 e f g s2
  }
>> \oneVoice
r4 <f a c> <c g'c> <e g c> <f a c> <e g c>
<d f a> <c f a>
<<
  {\voiceOne 
   f2 bes8 a bes c
  }
  \new Voice
  {\voiceTwo 
   <bes, d>2 <d f>
  }
>> \oneVoice
<f bes d>1 <f a c> <f bes>2 <e bes'>
%P7
<c a'>2. 4 <e g>2 2 <e g c>4 <f a c> <d g b>2 <e g c> <e c'>
<<
  {\voiceOne 
   c'2 bes
  }
  \new Voice
  {\voiceTwo
   f2. g4
  }
>> \oneVoice
<a c,>2 <f a>
<<
  {\voiceOne 
   bes2. c4
  }
  \new Voice
  {\voiceTwo
   f, es es2
  }
>> \oneVoice
<d bes'>2 2 <g bes>4 <a c,> <f g> <e g>
<<
  {\voiceOne
   a8 bes c a bes a bes c a4 <a c>4 4 <g c>
  }
  \new Voice
  {\voiceTwo <f c>1 f2 4 e
  }
>> \oneVoice
<d f a>2. <c f a>4
%P8
<d f>2 <f bes> < c a'> r4 <f a c>
<<
{\voiceOne <bes d> <a c> <g c>2}
\new Voice {\voiceTwo f2. e4}
>> \oneVoice
<c f a>2 r4 <f a c>
<<
  {\voiceOne <a d> <bes d> <g c>2}
  \new Voice {\voiceTwo  f2. e4}
>> \oneVoice <c f a>1
\bar "||" \time 6/8
<f a>4. <f d'>4 <g cis>8
<<{\voiceOne d'4. cis} \new Voice {\voiceTwo a4 bes8 e,4.}>> \oneVoice 
<f a d>4. <d a'> <d bes'> <d e>4 <cis e>8
<<
  {\voiceOne f g a <f d'>4 <g cis>8 d'4. cis}
  \new Voice {\voiceTwo  d,4. s a'4 bes8 e,4.}
>> \oneVoice
<f a d>4. <f d'>8 <e cis'>4 <f a d>4. <f a> <d bes'> <e g>
<c f a> <d f> <c f a> r4 8 <d f bes>4. r4 8
<<{\voiceOne g4. a4 bes8} \new Voice {\voiceTwo e,4 c8 4 e8}>> \oneVoice <f c'>4. <d g d'>
<<{\voiceOne <g c>4 <a c>8 b4.} \new Voice {\voiceTwo e,4 f8 d g f}>> \oneVoice 
<e g c>4. <c a'>4 <e bes'>8 <f c'>4 <f d'>8 <g c e>4 <g b d>8
<<{\voiceOne <g c> d' c bes a g} \new Voice {\voiceTwo e2.}>> \oneVoice 
<f bes>4. <c g'> <c a'> <d f> <c f a> <c f c'> <d f bes> <e bes'> <e a> <f a>
<<{\voiceOne a cis} \new Voice {\voiceTwo e, a4 e8}>> \oneVoice 
<f a d>4 <e bes' d>8 <e a cis>4. <f a d> <d f d'> <d g bes> <e bes'>
<cis e a> r4 8 <d a' d>4 <d f bes>8 <cis e a>4. <d f a>2.
\bar "||" \time 2/2
<f a d>2 2 <e a e'>2 2 <f a d>2 2 <d g bes> <cis e a>4 <d f a> 
<<{\voiceOne <e a>2 <f a>} \new Voice {\voiceTwo d4 cis d2}>> \oneVoice <f a d>2 2
<e a e'>2 2 <f a d> <f c'> 
<<{\voiceOne f2. e4 f8 e f g} \new Voice {\voiceTwo d4 c bes2 c}>> \oneVoice 
<c f a>4 <f c'> <f d'>2 <e g c> <f a> <c g'>
<c a'>4 <bes e> <c f>2 <d f> e
<<{\voiceOne a4 bes c d} \new Voice {\voiceTwo <c, f>2 f}>> \oneVoice <c f c'> <f c'>
<f d'> <f c'> <e bes'> <c a'>2
2 <d g> <<{\voiceOne c'4. bes8 a g a bes c2 bes} \new Voice {\voiceTwo e, c <f a>2. <e g>4}>> 
\oneVoice <c f a>4 4 <f bes> <e bes'>
<<{\voiceOne a2 bes c4 a bes c} \new Voice {\voiceTwo c,2 <f a>4 <e g> f2. e4}>> \oneVoice 
<f a>2 <d f> <c a'> <d f bes>
<<{\voiceOne a' bes a f4 e} \new Voice {\voiceTwo <c f>2 f4 e f2 bes,}>> \oneVoice 
<a f'> <f' a> <e c'> <f a>
<<{\voiceOne c' <g b>4 <g c>} \new Voice {\voiceTwo g a d, e}>> \oneVoice <d g b>2 <e g c>
<c f a> <c e g> <c f a> <c g'>
<<{\voiceOne c'2 d b4 c b2} \new Voice {\voiceTwo a4 g a f <d g> <e g> <d g>2}>> \oneVoice <e g c>1
\bar "||" \time 6/8
<c e>4. <e g> <c f c'> <c f> <d f>4 e8 f4 e8 
<<{\voiceOne f4. bes4 a8} \new Voice {\voiceTwo d,4. <d f>}>> \oneVoice <d g>4. 4.
g4 <f c'>8 <g c>4 <e c'>8 <g cis>4 <f d'>8 <g d'>4 <d g>8 <cis e>4. <a e' a>
<<{\voiceOne a'8 g f <f d>4. bes g~} \new Voice {\voiceTwo <f d>4. s es~4 d8}>> \oneVoice 
<cis g'>4 <d f>8 4 <cis e>8 <d f>4 <e a>8 <f a>4 <g cis>8 <a d>4. <f a>
<<{\voiceOne c'4. b a8 b c c4 e8} \new Voice {\voiceTwo <e, a>4 f8 <e a>4 <e gis>8 <c e>4. <e a>4 b'8}>> 
\oneVoice <a e e'>4 <f a d>8 <e a b>4 <e gis b>8 <c e a>2.
   \bar "||" \time 2/2
%P15
r2 <c f a>2 1 <c g'> r2 <g' c> <c, a'>1
<<
{\voiceOne a'2 bes4 a}
\new Voice {\voiceTwo c,2 <d f>}
>> \oneVoice <d f g>1
%P16
<c e g> <g' c g'> <g bes es>2. <f c' es>4
<<
{\voiceOne es'2 d c1 bes~<bes d,>2 <a c,> bes1}
\new Voice {\voiceTwo <f bes>1 f1 f2 es s1 f4 es4 2}
>> \oneVoice
<es f c'>2 <d f bes> <es g bes>1 <es f c'>2 <d f bes>
<<
{\voiceOne g1 <f a>2 <d f bes>~bes' a}
\new Voice {\voiceTwo bes,2 c~2 s <c f>1}
>> \oneVoice
<d f bes>
\bar "||" \time 3/4
4 4 4 <f bes d> <f a c>4 4 <f bes>4 4 4 <e bes'>4 4 4 4 <f a>4 4
<g bes,>4 4 4 <g c,>4 4 4
<<
{\voiceOne f4 bes a <bes f d>4 4 <f d'> c' bes2}
\new Voice {\voiceTwo s4 es,2 s2. f4 f e}
>> \oneVoice
<c f a>2.
\bar "||" \time 4/4
<f a c>4 4 <c g'c>4 4
%P18
<f a c>4 4 r2 <f a d>4 4 <e a>4 4 <d f a>4 4 r2
<f bes d>4 4 <f c'>4 4 <f bes d>4 4 r2
<d g bes>4 4 4 4 <c g'bes>2 <c f a> r2 4 4 
<<
{\voiceOne a'2 g~2 f c' bes~2 a~2 g~2 f}
\new Voice {\voiceTwo d1 c f e d c}
>> \oneVoice
<e g>2 <c f a> <c g'c> <c f a>
<<
{\voiceOne <c g'>1}
\new Voice {\voiceTwo f2 e}
>> \oneVoice
<c f a>1
\bar "||" \time 3/4
<<{\voiceOne <f a>4 g8 e f g} \new Voice {\voiceTwo c,4 2} >> \oneVoice <c f a>4 <e bes'> <g c>
<c, f a>4 4 4 <d f bes> <f bes> <d f bes> <d bes'> <c bes'> <e c'> <c f a>2.
<c g' c> <<{\voiceOne b'4 c8 bes a g} \new Voice {\voiceTwo <d f>4 <e g>2} >> \oneVoice
<c a'>4 <b g'> <c a'> r <d g b> <c g' c> <c f a> <b d g>2 <c e g>4 <e g c>4 4
<f a c>2 <g c>8 <f b d> <g c e>4 <e g c>4 4 <f c'> <c a'> <c g'> <d f> <d g> <f a>
<<{\voiceOne bes2.c4 a g} \new Voice {\voiceTwo e g f g c, e} >> \oneVoice
<<{\voiceOne } \new Voice {\voiceTwo} >> \oneVoice
<c a'>4 <d f> <c f> <bes f'> <d g> <f bes> <e bes'> <f bes> <g bes> <a f c>2 r4
<es bes'>4 <g bes> <es c'> <es f> <d bes'> r <f c'> <a c> <f a d>
<g e'> <g c> <f a f'> <f d'> <f g> <e g c> <<{\voiceOne a8 g a bes c a} \new Voice {\voiceTwo <f c>2.} >> 
\oneVoice <f d'> <e bes'>2 <c a'>4 <d bes'> <f a> <e g> <c f a>2.
\time 4/4 R1*21 \bar "||" R1*19 \bar "||"
R1*4
<<
{\voiceOne g'2 f4 a}
\new Voice {\voiceTwo e2 c}
>> \oneVoice
<f bes>2 2 <f a> <e c'> <c a'> <f c'>
<<
{\voiceOne a4 g}
\new Voice {\voiceTwo e2}
>> \oneVoice
<d f> e r4 <g c> <f a c>2 <f a d> <g c> <d g d'>
<e g c> <c f a> <d f bes>2. <d g bes>4
<c f c'>2 <c g'c> <c f a>2 2
<<
{\voiceOne bes'4 a bes c}
\new Voice {\voiceTwo f,2 es}
>> \oneVoice
<d f d'>4 <e bes'> <c f a>2 <f g> <e g c> <c f a>1\fermata
\fine
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
f2 e4 c f bes, c2 f4 4 c c d d a a bes f' c2 f e4 c
f2 2 g a4 b c2 r
f,4 e f c f c d2 e f4 g a2 cis, d4 cis d a
d2  d4  d4 | % 4
g2  c,2 | % 5
f2  f4  f4 | % 6
f4  e4  f4  c4 | % 7
d4  c4  d4  a4 | % 8
bes4  f'4  c2 | % 9
f2 r2 | 
f2  f4  bes,4 | % 11
c2.  f4 | % 12
c4  f4  c2
   f2  f2 | % 2
   f4  f4  c4  c4 | % 3
   d4  d4  a4  a4 | % 4
   bes4  f'4  c2 | % 5
   f2 r2 | % 6
   f2  f4  bes,4 | % 7
   c4  f4  c2 | % 8
   f2 r2 | % 9
   f8  f8 (  c8  c8 )  d8
   d8  a8  a8 | 
   bes8  bes8  f'8  f8  c2
  | % 11
  f1 | % 12
   f2  e8  c8  d8  e8
   %P4
   f4 bes, c2 f1 \bar "||" d~1 d~1
   r2 2 bes g' e f f e f r f r d r b c
   g'1 c, f2 bes2 4 a g2 a g4 e f1
   c d a d4 4 4 4 g2 c, f1
   %P6
   r4 f e c f f e c f2 r f2 4 bes, c2. 4 f2 r
   r4 f e c f c d a bes1 2. 4 f'2. 4 g2 c,
   f2. 4 c d e c c' f, g2 c, c d2. e4 f2. 4
   g2. a4 bes a g f e f c2 f1 4 4 4 c f f f a,
   %P8
   bes8 a bes c d c d e f2 r4 f bes f c2 f r4 f d bes c2 f1
   \bar "||" \time 6/8
   d4. 4 e8 f4 g8 a4. d,4 e8 f e d g a bes a g a d,4. 4 e8 f4 g8 a4.
   d,8 e f g a a, d4. d g c, f8 g a bes a g f4. r4 8 bes,4. r4 8
   c d e f4 g8 a4. b c4 f,8 g4. c,8 d e f4 g8 a4. g c, c
   d e f8 g a bes a g f4. a bes g a8 b cis d4 8 cis4. r4 a8
   d,4 g8 a4 a,8 d4 e8 f e d g4 a8 bes4 g8 a4. r4 8 f4 g8 a4. d,2. 
   \bar "||" \time 2/2
   d2. 4 cis2. 4 d2 8 e f d g a bes g a4 d, a2 d2 2. 4
   cis2. 4 d2 a bes4 a g c f2 a, bes c d e
   f4 g a f bes2 c f,4 g a bes a f a,2 bes a' g f
   f bes, c f f g a4 f g c, f2 g a4 f g c,
   f2 bes f bes, f' g f g f d c d
   e4 f g c, g'2 c, f c' f, e f4 e f d g c, g'2 c,1
   \bar "||" \time 6/8
   2. a bes4 c8 d4 c8 bes2. b c4 d8 e4 c8 a4 d8 bes4 8 a4. cis d f4 d8 g4 a8 bes4 g8 a4 d,8 a4.
   d4 cis8 d4 e8 f4. d c4 d8 e4. a, a' c,4 d8 e4. a,2.
   \bar "||" \time 2/2
   %P15
   r2 f' f1 e r2 e f1 2 d b1
   %P16
   c e g2. a4 bes4 4 4 4 2 a g1 f2 2
   g1 a2 bes es,1 a,2 bes es1 f2 bes, f'1 bes,
   \bar "||" \time 3/4
   bes2. f' g r2 g,4 d'2. es r2 4
   d c2 bes bes'4 a g2 f2.
   \bar "||" \time 4/4
   4 4 e4 4 f f r2 d4 4 cis4 4 d4 4 r2 bes4 4 a a bes4 4 r2
   g'4 4 4 f e2 f r f4 4 bes2. c8 bes a2 2 d,2. e8 d c2. d8 c
   bes2. c8 bes a2. f4 c'2 f e4 c f2 c1 f
\bar "||" \time 3/4
f4 c2 f4 g e f4. g8 a f bes4 d bes g e c f2.
e d4 c2 f2. g2 e4 f g2 c,4. d8 e c
f a g f e d c4 c' bes a f e d bes' a g e d e f c
f bes a g bes, d c d e f2 r4 g g a bes bes, r a' f d
c e d bes' c c, f2. bes,2 a4 g2 f'4 bes c c, f2.
\time 4/4 R1*21 \bar "||" R1*19 \bar "||"
R1*4 c'2 a4 f d'4. 8 4 4 c bes8 a g4 c, f8 e f g a g a bes
c g c2 b4 c2 r4 e, f8 g f e d e f d e4 d8 c b c a b c2 f
bes,8 a bes c bes4 g' a g8 f e f d e f1
g4 f g a bes g f2 c'1 f,\fermata
\fine
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
  \markup {"cel" = "tchel"}
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
  \markup {"cel" = "tchel"}
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

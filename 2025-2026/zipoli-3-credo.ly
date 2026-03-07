% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Misa a San Ignacio"}
  composer = "Dominico Zipoli (1688-1726)"
  subtitle = "3 - Credo"
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

despacio = {
\tempo "Despacio (Adagio)"
}

armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 2/2
\allegro
\key f \major
}


sop_mus = {
R1*2 c'2^"tutti" 4 4 4 4 4( b) c2 r4 4
d d d2 c4 d g,2 a1 R1*3 r2 c^"solo"
%P2
c4( bes8 a) bes4 4 4. a8 2 d4 4 4 4 c bes8 a bes4 c
a g8( f) e4. 8 f1 c'4^"tutti" 4 e e a, a c c d8( c) bes a g4. 8 a1 R1*6
%P3
R1*2 4 4 4 4 bes2 2 g4 4 4 4 a f bes2 a c
cis d d4 4 4 cis d2 r R1*5
%P4
r1 r2 c a4( g8 a) f2 r d' bes4( a8 bes) g2 c a4( g8 a)
f2 r f' d4( c8 d bes4 a8 bes g2) a4 4 g2 a4 c4 2 1\fermata
\bar "||" \time 4/4
%P5
\adagio
d2 4 4 2 2 bes1 r2 2 2 4 4 1 d1
g,2 c c bes a2. 4 bes2 g d'1~1 c
%P6
bes4( a) g2~2 f e2. 4 d1\fermata
\bar "||" \time 3/2 \despacio
r2 d'^"solo" a bes a1 g2. bes4 a g f( e) d1
d'2. 4 c bes a( g) f1 r1 c'2 d2. e4 f g e( d) c1
f4 d bes2. d4 c bes a2. g4 f2 8( a g bes a c bes d
%P7
c4) bes8( a) g2. f4 e1 c'2 4( f,) d2. c4 1.\fermata
\bar "||" \time 2/2 \allegro
\fine
}


sop_lyr  = \lyricmode {
Pa -- trem o -- mni -- po -- ten -- tem,
fa -- cto -- rem cae -- li et ter -- rae,

Et in u -- num Do -- mi -- num Je -- sum Chri -- stum,
Fi -- li -- um De -- i u -- ni -- ge -- ni -- tum.

Et ex Pa -- tre na -- tum an -- te o -- mni -- a sae -- cu -- la.

Ge -- ni -- tum, non fa -- ctum, 
con -- sub -- stan -- ti -- a -- lem Pa -- tri: 
per quem o -- mni -- a fa -- cta sunt.

de -- scen -- dit de -- scen -- dit de cae -- lis
de -- scen -- dit de cae -- lis de cae -- lis.

Et in -- car -- na -- tus est de spi -- ri -- tu San -- cto
ex Ma -- ri -- a Vir -- gi -- ne: Et ho -- mo
et ho -- mo fa -- ctus est.

Cru -- ci -- fi -- xus et -- i -- am pro no -- bis
et -- i -- am pro no -- bis: sub Pon -- ti -- o Pi -- la -- to
pas -- sus, pas -- sus, et se -- pul -- tus est et
se -- pul -- tus est et se -- pul -- tus est.
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_mus}
  \addlyrics {\sop_lyr}
>>

alt_mus = {R1*2
a'2^"tutti" g4 4 a g f2 e r4 f f e f( g)
a f f( e) f2
a4^"solo" 4 g f8 e f( e) f( g) e2 g4 a
g f8( e) d4. 8 e1
%P2
R1*6 a4^"tutti" 4 g g f f e e d8( e) f f f4 e f1 R1*6
%P3
R1*2 fis4 4 4 4 g2 d e4 4 4 4 f f f( e) f2 a
a4( g) f2 4 g8( f) e4. 8 d2 r4 a'^"solo" f2 4 4
4. 8 4 4 d c bes2 a2. bes4 c d e2
%P4
f4 g8( f) e2 f1 r2 f^"tutti" d4( c8 d) bes2 g' e4( d8 e) c2 r
a' f4( e8 f d4 c8 d) bes2 2 c2 4 f8( g) e2 f4 a g2 a1\fermata
\bar "||" \time 4/4
%P5
\adagio
f2 4 4 2 2 g1 r2 d d d4 4 g1 f
es2. 4 d2. g4 2 fis g1 r2 2 f1 2 2~
%P6
2 e4( d) cis2 d~2 cis d1\fermata
\bar "||" \time 3/2 \despacio
R1.*16
\bar "||" \time 2/2 \allegro
\fine
}


alt_lyr  = \lyricmode {
Pa -- trem o -- mni -- po -- ten -- tem,
fa -- cto -- rem cae -- li et ter -- rae,

vi -- si -- bi -- li -- um o -- mni -- um,
et in -- vi -- si -- bi -- li -- um.

Et ex Pa -- tre na -- tum an -- te o -- mni -- a sae -- cu -- la.

Ge -- ni -- tum, non fa -- ctum, 
con -- sub -- stan -- ti -- a -- lem Pa -- tri: 
per quem o -- mni -- a fa -- cta sunt.

Qui prop -- ter nos ho -- mi -- nes,
et prop -- ter no -- stram
et prop -- ter no -- stram sa -- lu -- tem

de -- scen -- dit de cae -- lis
de -- scen -- dit de -- scen -- dit de cae -- lis de cae -- lis.

Et in -- car -- na -- tus est de spi -- ri -- tu San -- cto
ex Ma -- ri -- a Vir -- gi -- ne: Et ho -- mo
et ho -- mo fa -- ctus est.
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_mus}
  \addlyrics {\alt_lyr}
>>

ten_mus = {R1*2
f'2^"tutti" e4 c f e d2 c r4 a bes c d( e)
f bes, c2 f, f'4^"solo" 4 e d8 c d4 g, 
c2 e4 f e d8( c) 4 b c1
%P2
R1*6 f4^"tutti" 4 c c d d a a bes f8 8 c'4. 8 f,2
f'~^"solo" 2 e4 d cis2 d a4( b8 cis) d4 e f4. e8 d2
bes4 a bes2 a2. d4
%P3
cis d e2 d1 4^"tutti" 4 4 4 g,2 2 c4 4 4 4 f, bes g2 f f'
f4( e) d2 bes4 g a a d,2 r R1*5
%P4
R1*2 f'2 d4( c8 d bes4 a8 bes) g2 r c a4( g8 a f4 e8 f)
d4. 8 d'4( c8 d) bes2 f' d4( c8 d e2) f4 f, c'2 f,4 f' e2 f1\fermata
\bar "||" \time 4/4
%P5
\adagio
bes,2 4 4 2 2 g1 r2 2 2 4 4 es'1 bes
c2. 4 fis,2 g d'2. 4 g,1 r2 2 bes1 a
%P6
g a2 d a2. 4 d,1\fermata
\bar "||" \time 3/2 \despacio
R1.*16
\bar "||" \time 2/2 \allegro
\fine
}


ten_lyr  = \lyricmode {
Pa -- trem o -- mni -- po -- ten -- tem,
fa -- cto -- rem cae -- li et ter -- rae,

vi -- si -- bi -- li -- um o -- mni -- um,
et in -- vi -- si -- bi -- li -- um.

Et ex Pa -- tre na -- tum an -- te o -- mni -- a sae -- cu -- la.

De -- um de De -- o, lu -- men de lu -- mi -- ne, De -- um ve -- rum 
de De -- o ve -- ro.

Ge -- ni -- tum, non fa -- ctum, 
con -- sub -- stan -- ti -- a -- lem Pa -- tri: 
per quem o -- mni -- a fa -- cta sunt.

de -- scen -- dit de -- scen -- dit de cae -- lis
de -- scen -- dit de cae -- lis de cae -- lis.

Et in -- car -- na -- tus est de spi -- ri -- tu San -- cto
ex Ma -- ri -- a Vir -- gi -- ne: Et ho -- mo
et ho -- mo fa -- ctus est.
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\ten_mus}
  \addlyrics {\ten_lyr}
>>

bass_mus = {R1*2
f4 8 8 c4 8 8 d4 8 8 a4 4 bes f d'2 f, 2 r
\fine
}


bass_lyr  = \lyricmode {
Glo -- ri -- a Glo -- ri -- a Glo -- ri -- a
in ex -- cel -- sis De -- o.  
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
  \relative c' {
f'8 g a f g e f g a4 g8 f e f d e
f8 8 8 8 g g g g a a g g f f f f
g e f g a g f e d c d e f e f g
a a f f f f e e f2 a4 4 g f8 e f e f g
e2 g4 a g f8 e d4. 8 e2 r4 c
%P2
c bes8( a) bes4 4 4. a8 2 d8 8 8 8 8 8 8 8
c4 bes8( a) bes4 c a( g8 f) g2 f1
a'8^\f g a f g f g e f a g f e g f e d4 c c d8( e)
f1 2 e4 d cis2 d a4 b8 cis d4 e f4. e8 d2 bes4 a bes2 a2. d4
%P3
cis d e2 d1 r8 a'^\f 8 8 2 g8 f g a g a g f e2 r4 4 f f g8 a f g a2 r
f4 cis d2 f4 g8 f e g f e d2 r4 a' f8 8 8 8 8 8 8 8 4. 8 2
d4 c bes2 a2. bes4 c d e2
%P4
f4 g8( f) e2 f1 
a8^\f 8 8 8 f f f f d d d d g g g g 
g g g g e e e e c2 a'4 g8( a)
f2 4 e8 f d4 c8( d) bes2 d8 e f d e f g e
c c c c g g g g f' f f f g g g g a1\fermata
\bar "||" \time 4/4
%P5
\adagio
f2 4 4 4 bes8 8 f f d d bes1 r2 d2 2 4 4 bes g'8 8 es8 8 bes8 8 d1
es8 8 8 8 8 8 8 8 c d c d bes d bes d d, g' a, g' a, fis' a, fis' g2 r
r1 r4 d d d c8 8 8 8 8 8 8 8 
%P6
bes'4( a) g2 8 8 8 8 f f f f e e e e e e e e d1\fermata
\bar "||" \time 3/2 \despacio
r2 2-- a-- bes a1 g2. bes4 a g f e d1
d'2. 4 c bes a g f f' e g f2 f, c' d2. e4 f g e d c1
f4 d bes2. d4 c bes a2. g4 f2 8 a g bes a c bes d
%P7
c4 bes8 a g2. f4 e1 c'2 4 f, d2. c4 1.\fermata
\bar "||" \time 2/2 \allegro
\fine
}
>>

viob= \new Staff \with {instrumentName="Violin 2"
  shortInstrumentName ="V.2"} <<
  \violin_style
  \armure
  \relative c' {
f'8 g a f g e f g a4 g8 f e f d e
f8 8 8 8 c c c c c c c c c c b4 c2 r4 c
bes8 a bes c d c d e f4 d g,2 a f'8 8 8 8
e4 d8 c d c d b c2 e4 f e d8 c c4 b c2 r4 e,
%P2
f2. g4 f1 bes8 8 8 8 8 8 8 8 f2 4--( e--) f2 e f1
c'8^\f 8 8 8 8 8 8 8 d f e d c e d c bes4 a g2 f1
g2. 4 a2 f cis2. a'4 d2 d, bes'4 a g--( e--) f2. 4
%P3
e4( f) d'( cis) d1 r8 fis^\f 8 8 2 d4 bes2 4 c2 r4 4 a d f e f2 r
a,4 g f2 d'4 e8 f a,4 cis d2 r d4 4 c c d8 8 8 8 c c c c
bes4 a g2 f2. g4 a bes c2
%P4
a4 bes8( a) g2 f1
a'8^\f 8 8 8 f f f f d d d d g g g g 
g g g g e e e e c2 a'4 g8( a)
f2 4 e8 f d4 c8( d) bes2 d8 e f d e f g e
f f f f e e e e a,4 c8( f) e4 4 f1\fermata
\bar "||" \time 4/4
%P5
\adagio
d2 4 4 4 bes'8 8 f f d d g,1 r2 bes2 2 4 4 g es'8 8 bes8 8 g g f1
g8 8 8 8 8 8 8 8 a a a a d, d d d d g' a, g' a, fis' a, fis' g2 r r1
r4 f, f f4 8 8 8 8 8 8 8 8
%P6
f'2 e4( d) cis8 8 8 8 d d d d d d d d cis8 8 8 8 d1\fermata
\bar "||" \time 3/2 \despacio
r2 f,-- 2-- g f1 e2 2 2 d1. bes'2. 4 a g f2. a4 g bes a2 f a f1. g
f2 f g a4 g f2. e4 f1.
%P7
g2 f d c2. d4 e2 f4 d c b4 2 c1.\fermata
\bar "||" \time 2/2 \allegro
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
<c f a>2 <c g'>4 <e g> <c a'> <d bes'> <e g>2
<c f a> <c g'c>4 <e g c>
<<
{\voiceOne c'4 c c b}
\new Voice {\voiceTwo <f a> g f2}
>> \oneVoice
<e g c>2 r4 <c f c'>
<<
{\voiceOne 
bes'1 a4 bes g2 a a4 4 c2. b4
<e, g c>2 4 <f a> g f8 e d2
}
\new Voice {\voiceTwo 
<d f>4 e f g <c, f> <d f> f e
f8 e f g f4 4 g2 f4 d s1 e4 d8 c8 4 b
}
>> \oneVoice
<c e>2 <e g c>
%P2
<<
{\voiceOne c'2 bes2 2 a4 c}
\new Voice {\voiceTwo f,2. g4 c,2. <f a>4}
>> \oneVoice
<f d'>2. <bes d>4
<<
{\voiceOne c a bes c}
\new Voice {\voiceTwo f,2. e4}
>> \oneVoice
<f a> <d bes'> <e g>2
<<
{\voiceOne f8 a g f a bes a g}
\new Voice {\voiceTwo c,2. d8 e}
>> \oneVoice
<f a c>4 4 <g c e>4 4 <d f a>4 4 <c e c'>4 4
<<
{\voiceOne bes'4 a8 bes <g c>2}
\new Voice {\voiceTwo <d f>4 <c f>2 e4}
>> \oneVoice
<f a c>2 <f a>2 2 <e g>4 <d f> <cis e>2 <d f>
<<
{\voiceOne g2. a4}
\new Voice {\voiceTwo cis,2 d4 e}
>> \oneVoice
<d f>2 <f a d>
<<
{\voiceOne bes1 a2 <a d> cis4 d2 cis4 <a d>1}
\new Voice {\voiceTwo d,2 c4 e f8 e f g f2 e4 f8 g e2 f8 d e f g e f g}
>> \oneVoice
%P3+2
< d fis a>4 4 4 4 <d g bes>2 2 <c e g>4 4 4 4
<<
{\voiceOne a' f bes2}
\new Voice {\voiceTwo <f c>4 d f e}
>> \oneVoice
<f a>2 <f a c>
<<
{\voiceOne cis'2 d d2. cis4 d c8 bes a g f e}
\new Voice {\voiceTwo a4 g f2 <f bes>4 <g bes> <e a>2 <f a> s}
>> \oneVoice
<a, d f>2 <c f> <d f> <c f>
<<
{\voiceOne d8 e f4 bes2 a2. g4 f2 e}
\new Voice {\voiceTwo s4 c d e f c f e8 d c4 d c2}
>> \oneVoice
%P4
<a c f>4 <d g> <e g>2
<<
{\voiceOne a8 g a bes c a bes c}
\new Voice {\voiceTwo <c, f>1}
>> \oneVoice
<c f a>2 <d f> <d f bes> <g bes d> <d g bes> <c e g> <c f c'> <c f a>
<d f a> <f a d> <f bes d>2 2 <d f bes> <e g> <c f a> <c e g>
<<
{\voiceOne a'8 g a bes c d c bes}
\new Voice {\voiceTwo <f c>2 <e g>}
>> \oneVoice
<c f a>1\fermata
\bar "||" \time 4/4
%P5
<f d'>1 2 2 <g bes>1 r2 <d bes'>2 1 <g bes> <f d'>
<<
{\voiceOne g2 c~2 bes a1 <bes d,>2 g d'1~1}
\new Voice {\voiceTwo es,2. 4 d2. g4 2 fis s1 r2 <g bes> <f bes>1}
>> \oneVoice
<f c'>1
%P6
<<
{\voiceOne bes4 a g2~}
\new Voice {\voiceTwo f2 e4 <d f>}
>> \oneVoice
<cis e g>2 <d f>
<<
{\voiceOne e1}
\new Voice {\voiceTwo d2 cis}
>> \oneVoice
<a d f>1\fermata
\bar "||" \time 3/2 \despacio
r2 <f' d'> <f a>
<<
{\voiceOne bes2 a1 <e g>1. f2. e4 f a bes2 2 c}
\new Voice {\voiceTwo d,1. bes2 a1 1 d2 <d f> g1}
>> \oneVoice
<a c,>2 2 <e bes'> <f c'> <c f> <c a'> <d bes'> <f d'>2 2
<e g c> <e g> <e g c> <f a> <f bes> <c bes'>
<<
{\voiceOne a'4 bes c1}
\new Voice {\voiceTwo c,4 g' <f a>2. <e g>4}
>> \oneVoice
<c a'>2 2 2
%P7
<c g'>2 <d g>2 2
<<
{\voiceOne g c1 a2 <g d>1}
\new Voice {\voiceTwo e2. f4 <c g'>2 <c f> c b}
>> \oneVoice
<c e g>1.\fermata
\bar "||" \time 2/2 \allegro
<<
{\voiceOne }
\new Voice {\voiceTwo }
>> \oneVoice
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
f2 e4 c f bes, c2 f2 e4 c f e d2 c r4 a bes c d e
f bes, c2 f1 e4 c d g c,2 4 f c f g2 c, c
%P2
d2. e4 f2. 4 bes a bes g a f g c, f bes, c2 f1 4 4 c c
d d a a bes f'c2 f1 g2. 4 a2 d, e2. cis4 d2. 4 g f e c f2 d
%P3
a'4 d, a'2 d,1 4 4 4 4 g2 2 c,4 4 4 4 f bes g2 f f
f4 e d2 bes4 g a a d2 r4 4 2 a bes a bes4 a g c f2 4 g a bes c2
%P4
f,4 bes, c2 f1 2 d bes g g' c a f d d bes bes' bes c f, c f c f1\fermata
\bar "||" \time 4/4
%P5
\adagio
bes,1 2 2 g1 r2 g'2 1 es bes
c fis2 g d1 g, r2 g' bes1 a
%P6
g1 a2 d, a1 d\fermata
\bar "||" \time 3/2 \despacio
1. g2 f e d cis2 2 d1 2 bes e1 f2 2 g a1 f2 bes1. c1 c,2 d1 e2 f4 d c1 f1.
%P7
e2 b b c2. d4 e2 f g1 c,1.\fermata
\bar "||" \time 2/2 \allegro
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
      %\bass
    >>
>>
  }
   \score {
    \unfoldRepeats
    <<
      \sop
      \alt
      \ten
      %\bass
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
      % \bass
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

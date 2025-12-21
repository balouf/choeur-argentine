% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Misa Criolla"
  subtitle = "2 - Gloria"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 15
individual_size = 20

\include "utils/macros.ly"


%%%%%%%%%%%%%%%%%
% Gloria
%%%%%%%%%%%%%%%%%

gloria = {
\compressEmptyMeasures
\time 3/4
\tempo 4 = 88
\key c \major
}

lead_music = {
R2.*2 R2.*4
\time 2/4
R2*8
\repeat volta 2 {
  \repeat volta 2 {
  r4 <c' e>16 8 <b d>16 <a c>8 <e a> r4
  r \times 2/3 {<e c'>8 <e a> <e g>} <e a>8 8 r4
  r <e e'>16 8 <d d'>16 
  <c c'>8 <a a'> \times 2/3 {<d d'> <b b'> <g g'>}
  \alternative {{<a a'>4 r} {<a a'> c'8 8 }}
  }
  d d r4
  r4 c8 c d d r4 
  r4 <c a'>8 8 <d a'>8 8 r4
  r4 <c a'>8 8 <d a'>8 8 r4
  r2 r4 \times 2/3 {c8 a g}
  a a r4 r4 <e' a>16 <d g> <b e> <d g>
  \alternative {{<e a>8 8 r4}{<e a>8 8 r4}}
}
  R2*2 \bar "||"
  R2*4
  \time 3/4
  \tempo 4 = 44
  R2.*3
  R2.*3
  r4 r r8 a, e'4. d16 c \times 2/3 {a8 8 8~}
  8 d16 c a8 4.~ 4 r r 
  r2. r r4 r r8 a16 a
  e'4. d8 \times 2/3 {c a g}
  a2 \times 2/3 {8 d c}
  a8 4. r8 <a c>16 <b d>
  <c e>16 16 16 <b d> \times 2/3 {<c e>8 <b d> <c e>} <a c> <e a>8~
  2 r8 <a c>16 <b d> \times 2/3 { <c e>8 <b d> <c e> } <a c>8 <e a>4.~
  2 r4 r2. r r \break
  r4 r r8 <a c>16 <b d>
  <c e>16 16 16 <b d> \times 2/3 {<c e>8 <b d> <c e>} <a c> <e a>8~
  2 r8 <c'e> <e a>16 <d g> <c e> <b d> \times 2/3 { <c e>8 <b d> <c e>8~ } 4~ 2 r8
  <a c>16 <b d> <c e>16 16 <b d> <c e> \times 2/3 { <a c>8 <e a>4 } r8 <b' d>16 16
  \times 2/3 { <c e>8\fermata <a e a,> <g d g,> } <a e a,>( <g d g,>)
  <a e a,>4~ 2.~ 2 r4
  \time 2/4
  \tempo 4 = 88
  R2*21 R2
  \repeat volta 2 {
  r4 <c e>16 8 <b d>16 <a c>8 <e a> r4
  r \times 2/3 { <e c'>8 <e a> <e g> } <e a>8 8 r4
  r4 <e e'>16 8 <d d'>16 <c c'>8 <a a'> \times 2/3 { <d d'> <b b'> <g g'> }
  \alternative {{<a a'>4 r} {<a a'> c'8 8}}
  }
  d4 r r c8 8 d4 r r c8 8 d4 r r <c a'>8 8 <d a'>4 r r c8 a16 g
  a8 16 e'8 d c16 a8 8 r4 r2 r \times 2/3 { e'8 d c } \times 2/3 { a a g }
  a8 8~ 4 r2 r r r r4 <a e' a>8\ff <g d' g> <a e' a>8. 16 r4
  R2*7 \fine
}

lead_lyrics = \lyricmode {
  en las al -- tu -- ras
  Paz a los hom -- bres
  Paz a los hom -- bres
  que~a -- ma~el Se -- ñor.
  ñor. 
  Te~a -- la -- ba -- mos
  Te~a -- do -- ra -- mos
  Te~a -- la -- ba -- mos
  Te~a -- do -- ra -- mos
  Te da -- mos gra -- cias
  por tu~in -- men -- sa glo -- ria glo -- ria
  
  Se -- ñor, Hi -- jo ú -- ni -- co __ Je -- su -- cris -- to __
  Se -- ñor Dios, Cor -- de -- ro de Dios, hi -- ho del Pa -- dre
  Tu que qui -- tas los pe -- ca -- dos del mun -- do __
  ten pie -- dad de nos -- so -- tros __
  Tu que qui -- tas los pe -- ca -- dos del mun -- do __
  a -- tién -- de nues -- tras sú -- pli -- cas __ 
  Tu que rei -- nas -- con -- el Pa -- dre
  ten pie -- dad de nos -- so -- tros __
  
  en las al -- tu -- ras
  Paz a los hom -- bres
  Paz a los hom -- bres
  que~a -- ma~el Se -- ñor. ñor
  Por -- que Tu so -- lo Tu
  Por -- que Tu so -- lo Tu
  Tu so -- lo~Al -- ti -- si -- mo Je -- su -- cris -- to
  con el Es -- pi -- ri -- tu San -- to
  de Dios Pa -- dre
}

lead = \new Staff \with {
  instrumentName="Lead"
  shortInstrumentName = "L."} <<
  \soprano_style
  \gloria
  \relative c' {\lead_music}
  \addlyrics {\lead_lyrics}
>>


sop_music = {
R2.*2 R2.*4
\time 2/4
R2*7
r4 a'8\pp a
\repeat volta 2 {
  \repeat volta 2 {
  a4 r r a8 8 c8. a16 r4 r e'16 8 d16
  c8 a e'4~ 4 f,(
  \alternative {{a) a8\ff 8} {a4 r }}
  }
  r g16\p 8 16
  a8 e r4 r4 g16 8 16 a8 e r4
  r4 \times 2/3 {g'8\f 8 8} a e r4
  r4 \times 2/3 {g8 8 8} a e \times 2/3 {e, e'd} c c r4
  r4 \times 2/3 {c8 a g} a a b4(
  \alternative {{a4) 8 8 }{a4 r8 g}}
}
\times 2/3 {a8 r8 8} r g a a a4\fermata
\bar "||"
\tempo "Lento"
<e' a>8 <d g>16 <b e> <e a> <d g> <c e> <a d>
<a c>8 4.~ 4 r4 r2
  \time 3/4
  \tempo 4 = 44
  R2.*3
  \times 2/3 { c4 a8~ } 8. c16 a8 c16 a g4 e2 r2. r r r
  \times 2/3 { c'4 a8~ } 8. c16 a8 c16 a g4 e2 r2. r r r r r r r
  \times 2/3 { c'4 a8~ } 8. c16 a8 c16 a g4 e2 r2. r r r r r r r r
  \times 2/3 {r8 <e' a> <d g>} <e a>( <d g>) <e a>4~ 2 r4
  \time 2/4
  \tempo 4 = 88
  R2*21 r4 a,8\pp 8
  \repeat volta 2 {
  4 r r a8 8 c8. a16 r4 r e'16 8 d16 c8 a e'4~ e f,(
  \alternative {{a) a8\ff 8} {4 r}}
  }
  r4 g16\p 8 16 a8 e r4 r4 g16 8 16 a8 e r4
  r4 \times 2/3 {g'8 8 8} a e r4 r4 \times 2/3 {g8 8 8} a e r4 r2
  r4 <a, c>8 <f a>16 <e g> <f a>8 16 <c' e>8 <b d> <a c>16 <f a>8 8 r4 r2 r 
  \times 2/3 { <c'e>8 <b d> <a c> } \times 2/3 { <f a>8 8 <e g> }
  <f a>8 8~ 4 r a8 8 e'4-> 4~-> 4 <e a>8\ff <d g> <e a>8. 16 r8
  g,\pp a4. g8 a4. g8 a2~ 4 <d g>\fff <e a>2~ 2~ 8 r r4 \fine
}


sop_lyrics = \lyricmode {
  Glo -- ria~a Dios y~en la tie -- rra
  Paz a los hom -- bres Paz __ Ah __ Glo -- ria~a ""
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te da -- mos gra -- cias
Te da -- mos gra -- cias
Ah __ Glo ria~a "_"
Se -- ñor Dios Rey ce -- les -- tial.
Dios, Pa -- dre To -- do -- po -- de -- ro -- so __

b.f. \repeat unfold 23 {""} de no -- so -- tros __
Glo -- ria~a Dios
y~en la tie -- rra
Paz a los hom  -- bres Paz __ Ah __ Glo -- ria~a "_"
So -- lo~e res san -- to Se ñor, Tu so -- lo
So -- lo~e res san -- to Se ñor, Tu so -- lo
Tu so -- lo~Al -- ti -- si -- mo Je -- su -- cris-- to
con el Es -- pi -- ri -- tu San -- to
en la Glo -- ria __ de Dios Pa -- dre
A -- men, A -- men, A -- men, __ A -- men, __
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \gloria
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
>>


alt_music = {R2.*2 R2.*4
\time 2/4
R2*7
r4 e8\pp e
\repeat volta 2 {
  \repeat volta 2 {
  e4 r r4 8 8 a8. e16 r4 r f4~ 4 fis4~ 4
  b,(
  \alternative {{e4) 8\ff 8} {4 r }}
  }
  r f16\p 8 16
  e8 c r4 r4 f16 8 16 e8 c r4
  r4 \times 2/3 {g'8\f 8 8} a a r4
  r4 \times 2/3 {g8 b8 d8} c a \times 2/3 {e c' b} a a r4
  r4 \times 2/3 {a8 f e} f f d4(
  \alternative {{c4) e8 8 }{c4 r8 d}}
}
\times 2/3 {e8 r8 8} r d e e e4\fermata
\bar "||"
a2~ 2~ 4 r4 r2
  \time 3/4
  \tempo 4 = 44
  R2.*3
  \times 2/3 { a4 e8~ } 8. a16 e8 a16 e d4 c2
  \times 2/3 { g'4 e8~ } 8. g16 e8 g16 e d4 a2 2.~ a
  \times 2/3 { a'4 e8~ } 8. a16 e8 a16 e d4 c2
  \times 2/3 { g'4 e8~ } 8. g16 e8 g16 e d4 a2~ 2.~ a~ a
  r r r
  \times 2/3 { a'4 e8~ } 8. a16 e8 a16 e d4 c2
  \times 2/3 { g'4 e8~ } 8. g16 e8 g16 e d4 a2
  r2. r r r r r r
  \times 2/3 {r8 a' g} a( g) a4~ 2 r4
  \time 2/4
  \tempo 4 = 88
  R2*21 r4 e8\pp 8
  \repeat volta 2 {
  4 r r e8 8 a8. e16 r4 r f~ f fis~ fis b,(
  \alternative {{e) e8\ff 8} {4 r}}
  }
  r4 f16\p 8 16 e8 c r4 r4 f16 8 16 e8 c r4
  r4 \times 2/3 {g'8 8 8} a a r4 r4 \times 2/3 {g8 b d} c a r4 r2
  r4 f8 d16 c d8 16 a'8 g f16 d8 8 r4 r2 r 
  \times 2/3 { a'8 g f } \times 2/3 { d8 8 c }
  d8 8~ 4 r a'8 8 4-> 4~-> 4 a8\ff g a8. 16 r8
  g\pp e4. g8 e4. a8 e2~ 4 f\fff a2~ 2~ 8 r r4 \fine
}

alt_lyrics = \lyricmode {
Glo -- ria~a Dios y~en la tie -- rra
Paz __  Paz __ Ah __ Glo -- ria~a ""
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te da -- mos gra -- cias
Te da -- mos gra -- cias
Ah __ Glo ria~a "_"
Se -- ñor Dios Rey ce -- les -- tial.
Dios __

b.f.  \repeat unfold 48 {""} de no -- so -- tros __
Glo -- ria~a Dios
y~en la tie -- rra
Paz __ Paz __ Ah __ Glo -- ria~a "_"
So -- lo~e res san -- to Se ñor, Tu so -- lo
So -- lo~e res san -- to Se ñor, Tu so -- lo
Tu so -- lo~Al -- ti -- si -- mo Je -- su -- cris-- to
con el Es -- pi -- ri -- tu San -- to
en la Glo -- ria __ de Dios Pa -- dre
A -- men, A -- men, A -- men, __ A -- men, __
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \gloria
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
>>


ten_music = {R2.*2 R2.*4
\time 2/4
R2*7
r4 c'8\pp c
\repeat volta 2 {
  \repeat volta 2 {
  c4 r r4 8 8 e8. c16 r4 r c4~ 4 4~ 4
  d,(
  \alternative {{e) c'8\ff 8} {e,4 r }}
  }
  r d'16\p 8 16
  e8 a, r4 r4 d16 8 16 e8 a, r4
  r4 \times 2/3 {f'8\f 8 8} e c r4
  r4 \times 2/3 {d8 f8 g8} g g \times 2/3 {e, e'd} c c r4
  r4 \times 2/3 {c8 a g} a a g4(
  \alternative {{e4) c'8 8 }{e,4 r8 b'}}
}
\times 2/3 {c8 r8 8} r b c c d4\fermata
\bar "||"
  R2*4
  \time 3/4
  \tempo 4 = 44
  R2.*3
  \times 2/3 { e4 c8~ } 8. e16 c8 f16 c b4 g2
  \times 2/3 { <b d>4 <g c>8~ } 8. <b d>16 <g c>8 <b d>16 <g c> <fis a>4 e2~ 2.~ e
  \times 2/3 { e'4 c8~ } 8. e16 c8 f16 c b4 g2
  \times 2/3 { <b d>4 <g c>8~ } 8. <b d>16 <g c>8 <b d>16 <g c> <fis a>4 e2~ 2.~ e~ e
  e~ e~ e
  \times 2/3 { e'4 c8~ } 8. e16 c8 f16 c b4 g2
  \times 2/3 { <b d>4 <g c>8~ } 8. <b d>16 <g c>8 <b d>16 <g c> <fis a>4 e2 2.~ e~ e~
  e~ e~ e~ e~ e~ e2 r4
  \time 2/4
  \tempo 4 = 88
  R2*21 r4 c'8\pp 8
  \repeat volta 2 {
  4 r r c8 8 e8. c16 r4 r c~ c c~ c d,(
  \alternative {{e) c'8\ff 8} {e,4 r}}
  }
  r4 d'16\p 8 16 e8 a, r4 r4 d16 8 16 e8 a, r4
  r4 \times 2/3 {f'8 8 8} e c r4 r4 \times 2/3 {d8 f g} g g r4 r2
  r2 r r r2 r 
  \times 2/3 { c,8 8 8 } \times 2/3 { 8 8 8 }
  8 8~ 4 r a8 8 fis'4-> 4~-> 4 d8\ff d e8. 16 r8
  b\pp c4. b8 c4. a8 fis2~ 4 d'\fff c2~ 2~ 8 r r4 \fine
}

ten_lyrics = \lyricmode {
  Glo -- ria~a Dios y~en la tie -- rra
Paz __  Paz __ Ah __ Glo -- ria~a ""
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te da -- mos gra -- cias
Te da -- mos gra -- cias
Ah __ Glo ria~a "_"
Se -- ñor Dios Rey ce -- les -- tial.


b.f.  \repeat unfold 49 {""} 
Glo -- ria~a Dios
y~en la tie -- rra
Paz __ Paz __ Ah __ Glo -- ria~a "_"
So -- lo~e res san -- to Se ñor, Tu so -- lo
So -- lo~e res san -- to Se ñor, Tu so -- lo
con el Es -- pi -- ri -- tu San -- to
en la Glo -- ria __ de Dios Pa -- dre
A -- men, A -- men, A -- men, __ A -- men, __}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \gloria
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
>>


bass_music = {R2.*2 R2.*4
\time 2/4
R2*7
r4 c8\pp c
\repeat volta 2 {
  \repeat volta 2 {
  a4 r r4 8 8 c8. a16 r4 r d,4~ 4 4~ 4
  g,(
  \alternative {{a) c'8\ff 8} {a,4 r }}
  }
  r b'16\p 8 16
  c8 g r4 r4 b16 8 16 c8 g r4
  r4 \times 2/3 {b8\f 8 8} c g r4
  r4 \times 2/3 {b8 d8 f8} e c \times 2/3 {e, c' b} a a r4
  r4 \times 2/3 {a8 f e} d d g,4(
  \alternative {{a4) c'8 8 }{a,4 r8 g'}}
}
\times 2/3 {a8 r8 8} r g a a a4\fermata
\bar "||"
  R2*4
  \time 3/4
  \tempo 4 = 44
  a,2.~ \repeat unfold 28 {a~} a8\fermata r4 r4. R2.*2
%  a2 4 2 r8 a8~ 2 4 2 4 2 4 2. 2 4 2 r8 8~ 2 4 2 4 2 4 2 4 2.
%  2.~ 2.~ 2. 2 4 2 r8 8~ 2 4 2. a~ a~ a~ a~ a~ a~ a~ a~ a2 r4
  \time 2/4
  \tempo 4 = 88
  R2*21 r4 c'8\pp 8
  \repeat volta 2 {
  a4 r r a8 8 c8. a16 r4 r d,~ d d~ d g,(
  \alternative {{a) c'8\ff 8} {a,4 r}}
  }
  r4 b'16\p 8 16 c8 g r4 r4 b16 8 16 c8 g r4
  r4 \times 2/3 {b8 8 8} c g r4 r4 \times 2/3 {b8 d f} e c r4 r2
  r2 r r r2 r 
  \times 2/3 { d,8 8 8 } \times 2/3 { 8 8 8 }
  8 8~ 4 r a'8 8 e'4-> 4~-> 4 d8\ff g, a8. 16 r8
  d\pp a4. d8 a4. a8 d,2~ 4 g\fff a2~ 2~ 8 r r4 \fine
}

bass_lyrics = \lyricmode {Glo -- ria~a Dios y~en la tie -- rra
Paz __  Paz __ Ah __ Glo -- ria~a ""
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te ben -- de -- ci -- mos
Glo -- ri -- fi -- ca -- mos
Te da -- mos gra -- cias
Te da -- mos gra -- cias
Ah __ Glo ria~a "_"
Se -- ñor Dios Rey ce -- les -- tial.

b.f.  \repeat unfold 29 {""} 
Glo -- ria~a Dios
y~en la tie -- rra
Paz __ Paz __ Ah __ Glo -- ria~a "_"
So -- lo~e res san -- to Se ñor, Tu so -- lo
So -- lo~e res san -- to Se ñor, Tu so -- lo
con el Es -- pi -- ri -- tu San -- to
en la Glo -- ria __ de Dios Pa -- dre
A -- men, A -- men, A -- men, __ A -- men, __}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \gloria
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
>>


\include "utils/booksmisa.ly"

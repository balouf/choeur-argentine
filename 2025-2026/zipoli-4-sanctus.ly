% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Misa a San Ignacio"}
  composer = "Dominico Zipoli (1688-1726)"
  subtitle = "4 - Sanctus"
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

despacio = {\tempo "Despacio (Adagio)"}

presto = {\tempo "Presto"}

rall = \markup {\italic "rall."}
solo = \markup {\italic [Solo]}
tutti = \markup {\italic [Tutti]}


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 4/4
\allegro
\key f \major
}


sop_mus = {
c'2^\tutti 2 2.( b4) c1 2 2 d4 8 8 4 c c( bes8 a g4.) 8 f1
c'2 4 4 d f bes,2 a a c8( d b cis) d4 e a, d8 8 4( cis) d1 r4 4 bes g
r4 c a f r bes a a f2 d' c4 4 r bes4 4 c d c bes( a) bes2
r4 4 g c c d g,2 a d4 c8( bes) c2.( bes8 a g1) a\fermata
\fine
}


sop_lyr  = \lyricmode {
San -- ctus, San -- ctus, San -- ctus Do -- mi -- nus De -- us Sa -- ba -- oth.
Ple -- ni sunt cae -- li et ter -- ra glo -- ri -- a glo -- ri -- a tu -- a.
Ho -- san -- na Ho -- san -- na Ho -- san -- na in ex -- cel -- sis
Ho -- san -- na in ex -- cel -- sis Ho -- san -- na in ex -- cel -- sis
in ex -- cel -- sis.
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_mus}
  \addlyrics {\sop_lyr}
>>

alt_mus = {
a'2^\tutti g a4( g f2) e1 f2 2 4 8 8 4 g a( g8 f e4.) 8 f1 R1*2
r2 a a4 g f e f g8 f e2 f4 g f d r bes' g e r a f d bes( es) c2
d8( c d es f es f g a4) 4 r f g f f g c,2 d
r4 f e g a f f( e) f2 4 g e2( f~f e) f1\fermata
\fine
}


alt_lyr  = \lyricmode {
San -- ctus, San -- ctus, San -- ctus Do -- mi -- nus De -- us Sa -- ba -- oth.
glo -- ri -- a tu -- a glo -- ri -- a tu -- a.
Ho -- san -- na Ho -- san -- na Ho -- san -- na in ex -- cel -- sis
Ho -- san -- na in ex -- cel -- sis Ho -- san -- na in ex -- cel -- sis
in ex -- cel -- sis.
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_mus}
  \addlyrics {\alt_lyr}
>>

ten_mus = {
f'2^\tutti e4( c) f( e d2) c1 a2 2 bes4 8 c d4 e f( bes, c4.) 8 f,1 R1*2
r2 f' f4 e d cis d g,8 8 a2 d r4 4 bes g r c 
a f r bes g es f f bes8( a bes c d c d es f4) f r d es a, bes es, f2 bes
r4 d c e f bes, c2 f, bes c4( bes a bes) c1 f,\fermata
\fine
}


ten_lyr  = \lyricmode {
San -- ctus, San -- ctus, San -- ctus Do -- mi -- nus De -- us Sa -- ba -- oth.
glo -- ri -- a tu -- a glo -- ri -- a tu -- a.
Ho -- san -- na Ho -- san -- na Ho -- san -- na in ex -- cel -- sis
Ho -- san -- na in ex -- cel -- sis Ho -- san -- na in ex -- cel -- sis
in ex -- cel -- sis.
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\ten_mus}
  \addlyrics {\ten_lyr}
>>

bass_mus = {
f'2^\tutti e4( c) f( e d2) c1 a2 2 bes4 8 c d4 e f( bes, c4.) 8 f,1 R1*2
r2 f' f4 e d cis d g,8 8 a2 d r4 4 bes g r c 
a f r bes g es f f bes8( a bes c d c d es f4) f r d es a, bes es, f2 bes
r4 d c e f bes, c2 f, bes c4( bes a bes) c1 f,\fermata
\fine
}


bass_lyr  = \lyricmode {
San -- ctus, San -- ctus, San -- ctus Do -- mi -- nus De -- us Sa -- ba -- oth.
glo -- ri -- a tu -- a glo -- ri -- a tu -- a.
Ho -- san -- na Ho -- san -- na Ho -- san -- na in ex -- cel -- sis
Ho -- san -- na in ex -- cel -- sis Ho -- san -- na in ex -- cel -- sis
in ex -- cel -- sis.
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
f'4 a g f8 g a4 g f2 e8 d e f g e f g a2 c,4 4 d8 c d e f e f g a4 f g e f1
c2 4 4 d f bes,2 a f'4 g a a a a a g8 f e2 d r4 4 2 r4 e f2 r bes,4 4 a c
d8 c d es f es f g a4 f r f g f f g c,2 bes r4 d g f8 g a4 f f e
f2 d8 e f d e2 f8 g a f g1 f\fermata
\fine
}
>>

viob= \new Staff \with {instrumentName="Violin 2"
  shortInstrumentName ="V.2"} <<
  \violin_style
  \armure
  \relative c' {
f'4 4 c e f c c b c8 b c d e c d e f2 a,4 4 bes8 a bes c d c d e f4 d c g' f1
f,2 4 4 bes f f e f2 a'4 g f e d cis d d d cis d2 r4 4 bes2 r4 c a2 r
es'4 g, f a bes8 a bes c d c d es f2 r bes,4 c d es c2 bes
r4 d e d8 e f4 d g,2 f d'8 e f d c2. bes8 a f'2 e f1\fermata
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
<<
{\voiceOne c'2 2 4 2 b4}
\new Voice {\voiceTwo <a f>2 g4 e a g f2}
>> \oneVoice <e g c>1 <f a c>
<<
{\voiceOne d'1 c4 d <c g>2}
\new Voice {\voiceTwo d,4 e f g a f e2}
>> \oneVoice <c f a>1 <f c'>2. 4
<<
{\voiceOne f2 bes a c c4 <cis a> d cis d d d cis <d a>2 r4 a}
\new Voice {\voiceTwo d, c d e f2 <f a> f4 e <d a'> <e g> <f a> <g bes> <e a>2 f4 g f <d f>}
>> \oneVoice <d g d'>2 <g bes>4 <e g c> <c f c'>2 <f a>4 <d f bes> <es bes'>2 <c a'>4 <f a>
<<
{\voiceOne bes1}
\new Voice {\voiceTwo <f d>4 es f g}
>> \oneVoice <a f c>2 <d, f bes> <es g bes>4 <es f c'> <d f bes> <c g'c>
<<
{\voiceOne bes'4 a bes f'}
\new Voice {\voiceTwo <c, f>2 d}
>> \oneVoice d'4 <bes f d> <g e> <g c>
<<
{\voiceOne c d <c g>2 a8 bes c a d4 bes c2 f4 d c8 f e d e f d e}
\new Voice {\voiceTwo <f, a>4 <f bes> f e <c f>2 f4 g <e g>2 <f c'>4 bes8 a g4 <a c> <bes c>2}
>> \oneVoice <a c f>1\fermata
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
f2 e4 c f e d2 c1 f, bes4 c d e f bes, c2 f1
a,1 bes4 a g c f,2 f' a4 g f e d g a2 d, r4 4 bes g r c
a f r bes' g es f2 bes,4 c d es f2 bes, es4 a, bes es f2 bes,
r4 4 c e f bes, c2 f bes, c4 bes a bes c1 f\fermata
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

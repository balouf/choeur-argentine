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
\fine
}


sop_lyr  = \lyricmode {
Pa -- trem o -- mni -- po -- ten -- tem,
fa -- cto -- rem cae -- li et ter -- rae,

Et
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
\fine
}


alt_lyr  = \lyricmode {
Pa -- trem o -- mni -- po -- ten -- tem,
fa -- cto -- rem cae -- li et ter -- rae,

vi -- si -- bi -- li -- um o -- mni -- um,
et in -- vi -- si -- bi -- li -- um.
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
\fine
}


ten_lyr  = \lyricmode {
Pa -- trem o -- mni -- po -- ten -- tem,
fa -- cto -- rem cae -- li et ter -- rae,

vi -- si -- bi -- li -- um o -- mni -- um,
et in -- vi -- si -- bi -- li -- um.
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

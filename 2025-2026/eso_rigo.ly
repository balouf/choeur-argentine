\version "2.24.0"

\header{
	title = \markup { \fontsize #5 \bold "Eso Rigor E'Repente"}
	composer = "Gaspar Fernández"
	opus = "Oaxaca (1585-1629)"
	tagline = ""
	footer = ""
}

\include "utils/macros.ly"
conductor_size = 17


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 6/8
\tempo 4. = 84
\key f \major
}

coupA = \lyricmode {Va -- mo ne -- gro de Gui -- ne -- a a lo pe -- se -- bri -- to so -- la
no va -- mo ne -- gro de-An -- go -- la que sa -- tu -- ru ne -- gla fe -- a
gar -- gan -- ti -- ya le gra -- na -- te ye -- ga -- mo-a lo se -- qui -- ti -- yo
man -- tey -- ya re -- _ bo -- si -- co com -- fi -- te cu -- ru --  ba -- ca -- te
}
coupB = \lyricmode {que -- re -- mo que ni -- ño ve -- a ne -- gro pu -- li -- zo-y ga -- la -- no
que co -- mo sa  no -- so-her -- ma -- no te -- ne -- mo ya fan -- ta  -- si -- a
y le  cu -- ra a te fa -- xu -- e  la guan -- te ca --  mi _ -- sa
ca -- pi -- say -- ta _  de fri -- sa ca -- nu -- ti -- yo de ta -- ba -- co
}


sop_music = \relative c'' {
	R2. |
	R2. |
	R2. |
	R2. |
%5
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%10
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%15
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%20
\repeat segno 2 {
	R2.^"Tutti" |
	R2. |
	R2. |
	R2. |
	r8 e e f4 f8 |
%25
	e e e d c4 |
	r8 c c d4 d8 |
	c c c bes c c ~ |
	c c c c c4 |
	R2. |
%30
	r4 r8 c^"cresc." d c |
	c4 d e |
	c bes c |
	c4.^\f r4 r8 |
	R2. |
%35
	r8 f f e f e ~ |
	e c c bes c4 |
	R2. |
	R2. |
	r8 d4^\mf ~ d8 c4 |
%40
	bes8 c c4 c8 c |
	f e4 r r8 |
	R2. |
	r8 d^\mf d^"cresc." c a4 |
	r8 c d e c4 |
%45
	r8 f f d e4 |
	f4. ~ f8 e e^\f |
	f2.\break 
\volta 2 \fine
\volta 1 {
\repeat volta 2 {	
	R2. |
	R2. |
%50
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%55
	R2. |
	R2. }
	f8 f f e d c |
	d a c4 a8 bes |
	c d e f4. |
%60
\repeat volta 2 {
	e r |
	R2. |
	R2. |
	R2. |
	R2. |
%65
	R2. |
	R2. |
	R2. |
	R2. } \break 
	f8 f f e d c 
%70
	d a c4 a8 bes |
	c d e f4. |
	e r \bar "|."
}}}


sops_music = \relative c'' {
	R2. |
	R2. |
	R2. |
	R2. |
%5
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%10
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%15
	R2. |
	R2. |
	R2. |
	R2. |
	c8 a bes c g4 \break
%20
\repeat segno 2 {
	R2. |
	R2. |
	r8 a a bes4 bes8 |
	a a a g f4 |
	r8 a a a a a ~ |
%25
	a a a a a4 |
	r8 a a f4 g8 |
	a a f g a g ~ |
	g a a g a4 |
	R2. |
%30
	r4 r8 a f g |
	a4 f e |
	f bes g |
	a4. r4 r8 |
	R2. |
%35
	r8 c c bes a c ~ |
	c a a bes a4 |
	R2. |
	R2. |
	r8 a4 ~ a8 a4 |
%40
	f8 a a4 a8 a |
	a a4 r8 a^\p a |
	g a f4 a8 a |
	a4. r8 a a |
	a4 a8 r a a |
%45
	g a bes4 c8 c |
	a4 c c8 c |
	c2.
\volta 2 \fine
\volta 1 {
\repeat volta 2 {	
	r8 g g a bes g ~ |
	g f4 a8 a g ~ |
%50
	g bes4 a8 g g ~ |
	g f4 g4. |
	a r8 c c ~ |
	c c4 d8 c c |
	bes bes a4 a |
%55
	g a8 f4 f8 |
	g4. a }
	R2. |
	R2. |
	R2. |
%60
\repeat volta 2 {
	r8 g g a bes g ~ |
	g f4 a8 a g ~ |
	g bes4 a8 g g ~ |
	g f4 g4. |
	a r8 c c ~ |
%65
	c c4  d8[ c] c |
	bes bes a4 a |
	g a8 f4 f8 |
	g4. a }
	R2. |
%70
	R2. |
	R2. |
	c8 a bes c g4
}}
}

alt_music = \relative c' {
	R2. |
	R2. |
	R2. |
	R2. |
%5
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%10
	R2. |
	R2. |
	f4 d8 f4 d8 |
	a'4 g8 g f4 |
	R2. |
%15
	r4 r a ~ |
	a8 g g f f bes ~ |
	bes a a g g f ~ |
	f e f g4 c,8 |
	R2. |
%20
\repeat segno 2 {
	R2. |
	r4 r8 r e e |
	f4 f8 bes, bes bes |
	f' e4 r8 d d |
	e4 e8 d c c |
%25
	c4 c8 r c c |
	c4 c8 f f d |
	e e f d f e ~ |
	e f f e f4 |
	a8^\p f^"(solo)" g a4 f8 ~ |
%30
	f e4 f e8 |
	c4 a' c |
	a g e |
	f4. r8 c'^\f c |
	bes^"(solo)" a c4 a8 a |
%35
	bes a a g a g ~ |
	g f f d f4 |
	R2. |
	R2. |
	r8 f4 ~ f8 e4 |
%40
	d8 e f4 c8 c |
	d cis4 r8 f f |
	e f d4 e8 e |
	f4. r8 f f |
	e4 f8 r f f |
%45
	e f d4 a'8 a |
	f4 a g8 g |
	a2.
\volta 2 \fine
\volta 1 {
\repeat volta 2 {		
	r8 e e e g e ~ |
	e d4 e8 e e ~ |
%50
	e g4 f8 d e ~ |
	e d f4 e |
	f4. r8 a a ~ |
	a g4 f8 a a |
	f f f4 e |
%55
	e e8 d e f ~ |
	f e4 f4. }
	R2. |
	R2. |
	R2. |
%60
\repeat volta 2 {
	r8 e e e g e ~ |
	e d4 e8 e e ~ |
	e g4 f8 d e ~ |
	e d f4 e |
	f4. r8 a a ~ |
%65
	a g4  f8[ a] a |
	f f f4 e |
	e e8 d e f ~ |
	f e4 f4. }
	R2. |
%70
	R2. |
	R2. |
	R2.
}}}



ten_music = \relative c' {
	r8 c c c a4 |
	bes8 a c4 f, |
	r8 f'4 ~ f8 e4 |
	d8 e f4 e8 e |
%5
	d c4 r8 c c |
	f f d4 e8 f |
	g e f4 e |
	d8 c bes4 a8 a |
	g f4 r8 c'4 ~ |
%10
	c8 c4 c8 c a ~ |
	a bes4 c f,8 |
	R2. |
	r4 r r8 d' |
	e f f d d bes ~ |
%15
	bes c4 d r8 |
	R2. |
	R2. |
	R2. |
	R2. \bar "||"
%20
\repeat segno 2 {
	r8 e e f4 f8 |
	e e e d c4 |
	r8 d d d d d ~ |
	d c c d4 bes8 |
	c c c a4 a8 |
%25
	r e' e f4 f8 |
	e e e d4 bes8 |
	c c c d4 c8 |
	c c c c c4 |
	R2. |
%30
	r4 r8 a a g |
	f4 f g |
	a d c |
	c4. r4 r8 |
	R2. |
%35
	r8 c a bes c c ~ |
	c c c g a4 |
	f'4.^\f ~ f8^"(solo)" e4 |
	d8 e f4 c8 c |
	d a4 r8 c c |
%40
	d c a4 c8 c |
	a a4 r8 f f |
	c' f, bes4 cis8 cis |
	d4. r8 c c |
	c a4 r8 c c |
%45
	c c d4 c8 c |
	d4 c g'8 g |
	f2.
\volta 2 \fine
\volta 1 {
\repeat volta 2 {		
	r8 c c c g c ~ |
	c d4 a8 a c ~ |
%50
	c g4 a8 b c ~ |
	c d4 c4. |
	f, r8 f' f ~ |
	f e4 d8 f f |
	bes, bes d4 a |
%55
	c a8 bes4 f8 |
	c'4. f, }
	R2. |
	R2. |
	R2. |
%60
\repeat volta 2 {
	r8 c' c c g c ~ |
	c d4 a8 a c ~ |
	c g4 a8 b c ~ |
	c d4 c4. |
	f, r8 f' f ~ |
%65
	f e4  d8[ f] f |
	bes, bes d4 a |
	c a8 bes4 f8 |
	c'4. f, }
	R2. |
%70
	R2. |
	R2. |
	R2.
}}}



bass_music = \relative c' {
	R2. |
	R2. |
	R2. |
	R2. |
%5
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%10
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%15
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%20
\repeat segno 2 {
	R2. |
	R2. |
	R2. |
	r8 a a bes4 bes8 |
	a a a d, f4 |
%25
	a8 a a f4 f8 |
	r a a bes4 bes8 |
	a a a g f c' ~ |
	c f, f c' f,4 |
	R2. |
%30
	r4 r8 f d e |
	f4 d c |
	f g c, |
	f4. r4 r8 |
	R2. |
%35
	r8 f f g f c ~ |
	c f f g f4 |
	R2. |
	R2. |
	r8 d4 ~ d8 a'4 |
%40
	bes8 a f4 a8 a |
	d, a'4 r r8 |
	R2. |
	r4. r8 f f |
	a4 d,8 r f f |
%45
	c' f, bes4 a8 a |
	d,4 f c8 c |
	f2.
\volta 2 \fine
\volta 1 {
\repeat volta 2 {	
	R2. |
	R2. |
%50
	R2. |
	R2. |
	R2. |
	R2. |
	R2. |
%55
	R2. |
	R2. }
	f8 a bes c d a |
	bes d c4 d8 d |
	a bes g a bes4 |
%60
\repeat volta 2 {
	c4. r4. |
	R2. |
	R2. |
	R2. |
	R2. |
%65
	R2. |
	R2. |
	R2. |
	R2. }
	f,8 a bes c d a |
%70
	bes d c4 d8 d |
	a bes g a bes4 |
	c4. r
}}}



sop_lyrics=\lyricmode {
sa -- ra -- ban -- da ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
ten -- ge que ten -- ge
sum -- ba -- ca -- su cu -- cum -- be cu -- cum -- be
e -- se no -- che bran -- co se -- re -- mo
O Je -- su que ri -- sa te -- ne -- mo
o que ri -- sa
o que ri -- sa
o que ri -- sa
San -- to To -- mé 
To -- ca vi -- ya -- no~y fo -- lli -- a bai -- la -- re -- mo~a le -- gre -- men -- te.
to -- ca pre -- so pe -- ro be -- ya -- co gui -- ta -- rria~a -- le -- gre -- men --  te 
}


sops_lyrics=\lyricmode {
can -- ta pa -- ren -- te
sa -- ra -- ban -- da ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
ten -- ge que ten -- ge
sum -- ba -- ca -- su cu -- cum -- be cu -- cum -- be
e -- se no -- che bran -- co se -- re -- mo
O Je -- su que ri -- sa te -- ne -- mo
o que ri -- sa San -- to To -- mé
o que ri -- sa o que ri -- sa San -- to To -- mé San -- to To -- mé
Va -- mo ne -- gro de Gui -- ne -- a a lo pe -- se -- bri -- to so -- la
no va -- mo ne -- gro de-An -- go -- la que sa -- tu -- ru ne -- gla fe -- a
gar -- gan -- ti -- ya le gra -- na -- te ye -- ga -- mo-a lo se -- qui -- ti -- yo
man -- tey -- ya re -- _ bo -- si -- co com -- fi -- te cu -- ru --  ba -- ca -- te
can -- ta pa -- ren -- te
}


alt_lyrics=\lyricmode {
ten -- le pri -- mo ten -- le cal -- je
to -- ca ne -- gri -- yo to -- ca ne -- gri -- yo tam -- bo -- ri -- ti -- yo.
sa -- ra -- ban -- da ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
que ten -- ge ten -- ge que ten -- ge
sum -- ba -- ca -- su cu -- cum -- be/sum ca  su  cu -- cum -- be cu -- cum -- be
e -- se no -- che bran -- co se -- re -- mo-e -- se no -- che bran -- co se -- re -- mo
O Je -- su que ri -- sa te -- ne -- mo
o que ri -- sa San -- to To -- mé
o que ri -- sa o que ri -- sa San -- to To -- mé San -- to To -- mé
Va -- mo ne -- gro de Gui -- ne -- a a lo pe -- se -- bri -- to so -- _ la
no va -- mo ne -- gro de-An -- go -- la que sa -- tu -- ru ne -- gla fe -- _ a
gar -- gan -- ti -- ya le gra -- na -- te ye -- ga -- mo-a lo se -- qui -- ti _ -- yo
man -- tey -- ya re -- _ bo -- si -- co com -- fi -- te cu -- ru -- _  ba -- ca -- te
}


ten_lyrics=\lyricmode {
E -- so ri -- gor e re -- pen -- te
ju -- ro-a qui se ni yo si -- qui -- to
que-aun que na -- ce po -- co bran -- qui -- to tu -- ru
so -- mo no -- so pa -- ren -- te
no te -- ne -- mo bran -- co gran -- de
hu -- si -- e hu -- si -- a pa -- ra -- cia
sa -- ra -- ban -- da ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
ten -- ge que ten -- ge
ten -- ge que ten -- ge
sum -- ba -- ca -- su cu -- cum -- be   cu -- cum -- be 
e -- se no -- che bran -- co se -- re -- mo
O Je -- su que ri -- sa ten -- ne -- mo
o Je -- su que ri -- sa te -- ne -- mo
o que ri -- sa San -- to To -- mé
o que ri -- sa o que ri -- sa San -- to To -- mé San -- to To -- mé
\coupA
}


bass_lyrics=\lyricmode { 
sa -- ra -- ban -- da ten -- ge que ten -- ge
ten -- ge que ten -- ge
sa -- ra -- ban -- da ten -- ge que ten -- ge
ten -- ge que ten -- ge
sum -- ba -- ca -- su cu -- cum -- be cu -- cum -- be
e -- se no -- che bran -- co se -- re -- mo
O Je -- su que ri -- sa te -- ne -- mo
o que ri -- sa
o que ri -- sa
San -- to To -- mé 
San -- to To -- mé
To -- ca vi -- ya -- no~y fo -- lli -- a bai -- la -- re -- mo~a le -- gre -- men -- _ te
to -- ca pre -- so pe -- ro be -- ya -- co gui -- ta -- rria~a -- le -- gre -- men -- _ te 
}

sop = \new Staff \with {instrumentName="Soprano 1"
  shortInstrumentName ="S1"} <<
  \soprano_style
  \armure
  {\sop_music}
  \addlyrics {\sop_lyrics}
>>

sops = \new Staff \with {instrumentName="Soprano 2"
  shortInstrumentName ="S2"} <<
  \soprano_style
  \armure
  {\sops_music}
  \addlyrics {\sops_lyrics}
  \addlyrics {\repeat unfold 89 "" \coupB}
>>

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \soprano_style
  \armure
  {\alt_music}
  \addlyrics {\alt_lyrics}
  \addlyrics {\repeat unfold 123 "" 
  \lyricmode {
  que -- re -- mo que ni -- ño ve -- a ne -- gro pu -- li -- zo-y ga -- la _  -- no
que co -- mo sa  no -- so-her -- ma -- no te -- ne -- mo ya fan -- ta  -- si _  -- a
y le  cu -- ra a te fa -- xu -- e  la guan -- te ca --  mi _ _  -- sa
ca -- pi -- say -- ta _  de fri -- sa ca -- nu -- ti -- yo de _  ta -- ba -- co
  }
  }
>>

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \soprano_style
  \armure
  \transpose c c'{\ten_music}
  \addlyrics {\ten_lyrics}
  \addlyrics {\repeat unfold 155 "" \coupB}
>>

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \transpose c c {\bass_music}
  \addlyrics {\bass_lyrics}
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
    \new ChoirStaff
       <<
      \sop
      \sops
      \alt
      \ten
      \bass
    >>

  }
  \score {
    \unfoldRepeats
    <<
      \sop
      \sops
      \alt
      \ten
      \bass
    >>
    \midi {}
  }
}


%{
convert-ly.py (GNU LilyPond) 2.24.4  convert-ly.py: Processing `'...
Applying conversion: 2.12.3, 2.13.0, 2.13.1, 2.13.4, 2.13.10, 2.13.16,
2.13.18, 2.13.20, 2.13.27, 2.13.29, 2.13.31, 2.13.36, 2.13.39,
2.13.40, 2.13.42, 2.13.44, 2.13.46, 2.13.48, 2.13.51, 2.14.0, 2.15.7,
2.15.9, 2.15.10, 2.15.16, 2.15.17, 2.15.18, 2.15.19, 2.15.20, 2.15.25,
2.15.32, 2.15.39, 2.15.40, 2.15.42, 2.15.43, 2.16.0, 2.17.0, 2.17.4,
2.17.5, 2.17.6, 2.17.11, 2.17.14, 2.17.15, 2.17.18, 2.17.19, 2.17.20,
2.17.25, 2.17.27, 2.17.29, 2.17.97, 2.18.0, 2.19.2, 2.19.7, 2.19.11,
2.19.16, 2.19.22, 2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.39,
2.19.40, 2.19.46, 2.19.49, 2.20.0, 2.21.0, 2.21.2, 2.22.0, 2.23.1,
2.23.2, 2.23.3, 2.23.4, 2.23.5, 2.23.6, 2.23.7, 2.23.8, 2.23.9,
2.23.10, 2.23.11, 2.23.12, 2.23.13, 2.23.14, 2.24.0
%}

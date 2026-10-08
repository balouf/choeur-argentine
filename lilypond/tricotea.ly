\version "2.26.0"

%% Source : édition Rafael Caldas (PDF), et son MusicXML pour la saisie.
%% Le MusicXML a été tiré du même PDF par PDFtoMusic : hauteurs et durées
%% coïncident, seules les paroles ont été reprises sur le papier — le
%% convertisseur y avait semé des traits d'union de trop et perdu le « De » du
%% second couplet, mesure 38.
%%
%% Au second couplet, le soprano réarticule deux notes que le premier tient
%% (mesures 40 et 45) : d'où les `\syllabeSurLiee`.
%%
%% Le PDF ne note qu'une barre de reprise, à la fin : la pièce se chante deux
%% fois en entier. Les passages à deux lignes de paroles changent de texte au
%% second passage, les autres se reprennent tels quels.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "La Tricotea" }
  composer = "Alonso"
  subsubtitle = "Cancionero de Palacio"
  arranger = "Ed. : Rafael Caldas"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 2/2
  \tempo 2 = 84
  \key d \major
}

soprano_music = {
  \repeat volta 2 {
  % 1
  b'1 | a2 a | b2.( a4) | fis1 |
  % 5
  b2 b | a a | b1 | fis |
  % 9
  b1 | a2 b | g1 | r2 g |
  % 13
  fis2 fis | fis fis | e1 | d |
  % 17
  fis4 fis fis fis | e e d d | fis fis fis fis | e e d r |
  % 21
  fis4 fis8 fis fis4 fis | e e d d | fis fis gis ais | b2 fis |
  % 25
  b2 ais4 ais | b2 fis | b4 b ais ais | b2 fis |
  % 29
  fis4 fis fis fis | e e d d | fis fis fis fis | e e d r |
  % 33
  fis4. fis8 fis4 fis | e e d r | fis fis fis fis | d fis fis fis |
  % 37
  fis4 fis e e | d r fis2 | fis gis4 ais | b2~ \syllabeSurLiee b |
  % 41
  cis1 | b4. a8 g4 fis | fis2 fis | fis4 fis gis ais |
  % 45
  b1 | cis1 | b4. a8 g4( fis) | fis2 fis |
  % 49
  fis2. e8( d) | cis4( b) cis2 | b4( b'2 ais4) | b1\fermata |
  }
}

soprano_lyrics = \lyricmode {
  La tri -- co -- te -- a San Mar -- tin la ve -- a.
  A -- bres un poc al a -- gua'y -- se -- ña -- le -- a.
  La bo -- ta sen -- bra tu -- le -- ta la se -- ña d'un cha -- pi -- re,
  ge que te gus per mun -- do spe -- sa la bo -- ti -- lha ple -- na.
  Da -- ma qui mai -- na, ce -- rra -- li la ve -- na,
  or -- li -- cer -- li trun ma -- da -- ma cer -- li -- cer ce -- rrar -- li -- ben,
  vo -- tr'a -- mí con -- tra -- ri -- ben, ni -- qui -- ni -- qui
  don for -- ma -- gi -- dón, for -- ma -- gi -- dón.
  Yo soy mo -- nar -- che -- _ a de  gran -- de no -- bre -- a
  Da -- ma por a -- mor, __ 
  da -- ma bel se -- me -- a da -- ma, yo la ve -- a.
}

soprano_lyrics_ii = \lyricmode {
  Yo'é cla -- vel -- mo __ lin y un -- tar el ba -- tán
  No me des pan nin to -- rres __ _ de to -- sín
  \*76 _
  De vos ha -- ré bi so -- ña qu'en to -- ta Bor -- go -- ña
  non trobéis ostro mí par
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
  \addlyrics {\soprano_lyrics_ii}
>>

alto_music = {
  \repeat volta 2 {
  % 1
  b1 | cis2 cis | b1 | d |
  % 5
  b2 b | cis cis | b1 | d |
  % 9
  b4.( cis8 d4 e) | fis2 b, | e2.( d8 cis | b2) e |
  % 13
  d2 cis~ | cis4 b b2~ | b ais | b r |
  % 17
  d4 d cis cis | cis cis fis fis | d d cis cis | cis cis fis r |
  % 21
  d4 d8 d cis4 cis | cis cis fis fis | d d cis cis | b2 d |
  % 25
  e2 cis4 cis | b2 d | d4 d cis cis | b2 d |
  % 29
  d4 d cis cis | cis cis b b | d d cis cis | cis cis b r |
  % 33
  d4. d8 cis4 cis | cis cis b r | d d d d | b d d d |
  % 37
  d4 cis cis cis | b r d2 | d cis4 cis | b2 d |
  % 41
  e1 | e4. e8 e4 d | d2 d | d4 d cis cis |
  % 45
  b2( d) | e1 | e | d2 d |
  % 49
  d2. cis8( b) | ais4( b2) ais4 | b( d cis2) | b1\fermata |
  }
}

alto_lyrics = \lyricmode {
  La tri -- co -- te -- a San Mar -- tin la ve -- a.
  A -- bres un poc __ al a -- gua'y -- se -- ña -- le -- a.
  La bo -- ta sen -- bra tu -- le -- ta la se -- ña d'un cha -- pi -- re,
  ge que te gus per mun -- do spe -- sa la bo -- ti -- lha ple -- na.
  Da -- ma qui mai -- na, ce -- rra -- li la ve -- na,
  or -- li -- cer -- li trun ma -- da -- ma cer -- li -- cer ce -- rrar -- li -- ben,
  vo -- tr'a -- mí con -- tra -- ri -- ben, ni -- qui -- ni -- qui
  don for -- ma -- gi -- dón, for -- ma -- gi -- dón.
  Yo soy mo -- nar -- che -- _ a de gran -- de no -- bre -- a
  Da -- ma por a -- mor, __ 
  da -- ma~bel se -- mea da -- ma, yo la ve -- a.
}

alto_lyrics_ii = \lyricmode {
  Yo'é cla -- vel -- mo lin y un -- tar el ba -- tán
  No __ me des pan __ nin to -- rres __ _ de __ to -- sín
  \*76 _
  De vos ha -- ré bi so -- ña qu'en to -- ta Bor -- go -- ña
  non trobéis ostro mí par
}

alto = \new Staff \with {instrumentName="Alto/Tenor"
  shortInstrumentName ="A./T."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
>>

basse_music = {
  \repeat volta 2 {
  % 1
  b1 | fis'2 fis | b,1 | b' |
  % 5
  g2 g | fis fis | b,1 | b' |
  % 9
  g1 | fis2 g | e1 | e |
  % 13
  b'2 a | fis d | cis1 | b |
  % 17
  b'4 b fis fis | a a b b | b b fis fis | a a b r |
  % 21
  b4 b8 b fis4 fis | a a b b | b b e, fis | b,2 b' |
  % 25
  e,2 fis4 fis | b,2 b' | b4 b fis fis | b,2 b' |
  % 29
  b4 fis fis fis | a a b b | b b fis fis | a a b r |
  % 33
  b4. b8 fis4 fis | a a b r | b b b b | g b b b |
  % 37
  fis4 fis a a | b2 b | b e,4 fis | b,2 b' |
  % 41
  a1 | g4. fis8 e4 b' | b2 b | b4 b e, fis |
  % 45
  b,2( b') | a1 | g4( e) e8( fis) g( a) | b2 b |
  % 49
  b2. a8( g) | fis4( d) e( fis) | d( b fis'2) | b,1\fermata |
  }
}

basse_lyrics = \lyricmode {
  La tri -- co -- te -- a San Mar -- tin la ve -- a.
  A -- bres un poc al a -- gua'y -- se -- ña -- le -- a.
  La bo -- ta sen -- bra tu -- le -- ta la se -- ña d'un cha -- pi -- re,
  ge que te gus per mun -- do spe -- sa la bo -- ti -- lha ple -- na.
  Da -- ma qui mai -- na, ce -- rra -- li la ve -- na,
  or -- li -- cer -- li trun ma -- da -- ma cer -- li -- cer ce -- rrar -- li -- ben,
  vo -- tr'a -- mí con -- tra -- ri -- ben, ni -- qui -- ni -- qui
  don for -- ma -- gi -- dón, for -- ma -- gi -- dón.
  Yo soy mo -- nar -- che -- _ a de gran -- de no -- bre -- a
  Da -- ma por a -- mor, __ 
  da -- ma  bel se -- me -- a da -- ma, yo la __ ve -- a.
}

basse_lyrics_ii = \lyricmode {
  Yo'é cla -- vel -- mo lin y un -- tar el ba -- tán
  No me des pan nin to -- rres __ _ de to -- sín
  \*76 _
  De vos ha -- ré bi so -- ña qu'en to -- ta Bor -- go -- ña
  non trobéis ostro mí par
}

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\basse_music}
  \addlyrics {\basse_lyrics}
  \addlyrics {\basse_lyrics_ii}
>>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveEmptyStaves
      }
      %% Les passages en noires serrent les syllabes au point que le graveur
      %% escamote les traits d'union : on leur garantit de la place.
      \context {
        \Lyrics
        \override LyricSpace.minimum-distance = #1.0
        \override LyricHyphen.minimum-distance = #1.5
      }
    }
    <<
      \new ChoirStaff <<
        \soprano
        \alto
        \basse
      >>
    >>
  }
  \score {
    \unfoldRepeats
    <<
      \new ChoirStaff <<
        \soprano
        \alto
        \basse
      >>
    >>
    \midi {
      %% Pas de paroles dans le MIDI. Une ligne de paroles qui commence au
      %% premier temps ouvre sa piste avant la portée suivante et lui prend un
      %% canal ; au-delà de seize, les canaux rebouclent et deux voix se
      %% retrouvent sur le même — or le lecteur du site range les notes par
      %% canal, et les fusionnerait.
      \context {
        \Lyrics
        \remove "Lyric_performer"
      }
    }
  }
}

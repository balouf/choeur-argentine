\version "2.26.0"

%% Source : édition Paco Mármol & Manolo Casaus (CPDL, 1999), PDF et
%% MusicXML de la même édition. Les notes du MusicXML sont celles du PDF ; ses
%% paroles n'en donnaient que deux lignes sur quatre, avec des traits d'union
%% perdus : les quatre lignes sont relevées sur le PDF.
%%
%% Forme du villancico, telle que le PDF la note (reprise et D.C.) :
%%
%%   estribillo (mes. 1-15)        ligne 1
%%   mudanza, deux fois (16-24)    lignes 1 puis 2
%%   D.C., vuelta jusqu'au Fine    ligne 2
%%
%% puis la même chose pour la seconde strophe, sur les lignes 3 et 4. Le PDF
%% n'écrit pas « Fine » : la vuelta s'arrête à la fin de l'estribillo, mesure
%% 15, et c'est là qu'on le grave.
%%
%% À la mesure 16, l'alto monte au-dessus du soprano (si-do contre sol-la)
%% puis redescend d'une septième : c'est ce qu'écrivent le PDF et le MusicXML.

#(set-default-paper-size "a4")

%% Une page. Il manquait une quinzaine de millimètres, repris sur les blancs
%% plutôt que sur la taille de portée : marges de 6 mm au lieu de 10, en-tête
%% accolé au premier système, et lignes de paroles un peu resserrées (voir le
%% contexte Lyrics du \layout). Avec moins de marge, LilyPond hésite entre une
%% et deux pages : il avertit, et sans `page-count` il en prend deux.
\paper {
  top-margin = 6\mm
  bottom-margin = 6\mm
  markup-system-spacing.padding = #0
}

\header {
  title = \markup { \fontsize #5 \bold "Levanta, Pascual" }
  composer = "Juan del Encina (c. 1468-1529)"
  subsubtitle = "Cancionero de Palacio"
  arranger = "Ed. : Paco Mármol & Manolo Casaus"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 3/4
  \tempo 4 = 144
  \key g \major
}

soprano_music = {
  \repeat segno 2 {
  % 1
  e4.( fis8) g4 | a e2 | fis4.( g8 a4) | b( c4.) b8 |
  % 5
  a2( gis4) | a2 a4 | b2( c4) | b4.( a8) g fis |
  % 9
  e4 fis2 | e e4 | r g a | b e,2 |
  % 13
  a2 gis4 | a2. | a2 r4 |
  \volta 2 \fine
  \volta 1 \repeat volta 2 {
  % 16
  g2 a4 |
  % 17
  b2 b4 | b c2 | a g4~ | g g a |
  % 21
  b4 e,2 | a gis4 | a( b2) | gis2. |
  }
  }
}

soprano_lyrics = \lyricmode {
  \set stanza = "1."
  Le -- _ van -- ta, Pas -- cual, __ le -- van -- ta,
  a -- ba -- lle -- mos __ _ a Gra -- na -- da,
  que se sue -- na qu'es to -- ma -- da.
  Le -- van -- ta tos -- te prí -- a -- do __
  to -- ma tu pe -- rro~y zu -- rrón, __ _
}

soprano_lyrics_ii = \lyricmode {
  va -- mos ver el ga -- sa -- _ ja -- do
  d'a -- que -- lla __ ci -- u -- dad nom -- bra -- da
  que se sue -- na qu'es to -- ma -- da.
  tu za -- ma -- rra~y za -- ma -- rrón __ _
  tus al -- bo -- gues y ca -- ya -- do.
}

soprano_lyrics_iii = \lyricmode {
  \set stanza = "2."
  ¡O __ qué Re -- yes tan __ ben -- _ di -- tos!
  Vá -- mo -- nos, __ vá -- _ mo -- nos yen -- do
  que ya te voy per -- cre -- yen -- do.
  Se -- gún o -- yó gran -- des gri -- tos __
  lle -- ve -- mos es -- tos ca -- bri -- tos,
}

soprano_lyrics_iv = \lyricmode {
  Le -- _ van -- ta, Pas -- cual, __ le -- van -- ta,
  a -- ba -- lle -- mos __ _ a Gra -- na -- da,
  que se sue -- na qu'es to -- ma -- da.
  por -- que~ha -- brá ven -- ta cha -- pa -- da __
  que se sue -- na qu'es to -- ma -- da.
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
  \addlyrics {\soprano_lyrics_ii}
  \addlyrics {\soprano_lyrics_iii}
  \addlyrics {\soprano_lyrics_iv}
>>

alto_music = {
  \repeat segno 2 {
  % 1
  R2. | a4.( b8) c4 | d2 d4 | d e2 |
  % 5
  a,4 b2 | a a4 | d2( e4) | d( b) c8 d |
  % 9
  e2 dis4 | e2 e4 | r b c | d c2 |
  % 13
  a4 b2 | a2. | a2 r4 |
  \volta 2 \fine
  \volta 1 \repeat volta 2 {
  % 16
  b2 c4 |
  % 17
  d2 d4 | d e2 | c4( d) e~ | e b c |
  % 21
  d4 c2 | a4 b2 | a4( e'4. b8) | e2. |
  }
  }
}

alto_lyrics = \lyricmode {
  \set stanza = "1."
  Le -- van -- ta, Pas -- cual, le -- van -- _ ta,
  a -- ba -- lle -- mos __ _ a Gra -- na -- da,
  que se sue -- na qu'es to -- ma -- da.
  Le -- van -- ta tos -- te prí -- a -- do __
  to -- ma tu pe -- rro~y zu -- rrón, __ _
}

alto_lyrics_ii = \lyricmode {
  va -- mos ver el ga -- _ sa -- ja -- do,
  d'a -- que -- lla __ ci -- u -- dad nom -- bra -- da
  que se sue -- na qu'es to -- ma -- da.
  tu za -- ma -- rra~y za -- ma -- rrón __ _
  tus al -- bo -- gues y ca -- ya -- do.
}

alto_lyrics_iii = \lyricmode {
  \set stanza = "2."
  ¡O __ qué Re -- yes tan ben -- di -- _ tos!
  Vá -- mo -- nos, __ vá -- _ mo -- nos yen -- do
  que ya te voy per -- cre -- yen -- do.
  Se -- gún o -- yó gran -- des gri -- tos __
  lle -- ve -- mos es -- tos ca -- bri -- tos,
}

alto_lyrics_iv = \lyricmode {
  Le -- van -- ta, Pas -- cual, le -- van -- _ ta,
  a -- ba -- lle -- mos __ _ a Gra -- na -- da,
  que se sue -- na qu'es to -- ma -- da.
  por -- que~ha -- brá ven -- ta cha -- pa -- da __
  que se sue -- na qu'es to -- ma -- da.
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
  \addlyrics {\alto_lyrics_iii}
  \addlyrics {\alto_lyrics_iv}
>>

basse_music = {
  \repeat segno 2 {
  % 1
  R2.*2 | d4.( e8) fis4 | g c,2 |
  % 5
  f4 e2 | a, a'4 | g2( c,4) | g'2 a8 b |
  % 9
  c4 b2 | e, e4 | r e a | g a2 |
  % 13
  f4 e2 | a,2. | a2 r4 |
  \volta 2 \fine
  \volta 1 \repeat volta 2 {
  % 16
  e'2 a4 |
  % 17
  g2 g4 | g c,2 | f e4~ | e e a |
  % 21
  g4 a2 | f4 e2 | f4( g2) | e2. |
  }
  }
}

basse_lyrics = \lyricmode {
  \set stanza = "1."
  Le -- van -- ta, le -- van -- _ ta
  a -- ba -- lle -- mos __ _ a Gra -- na -- da,
  que se sue -- na qu'es to -- ma -- da.
  Le -- van -- ta tos -- te prí -- a -- do __
  to -- ma tu pe -- rro~y zu -- rrón, __ _
}

basse_lyrics_ii = \lyricmode {
  va -- mos ga -- _ sa -- ja -- do
  d'a -- que -- lla ci -- u -- dad nom -- bra -- da
  que se sue -- na qu'es to -- ma -- da.
  tu za -- ma -- rra~y za -- ma -- rrón __ _
  tus al -- bo -- gues y ca -- ya -- do.
}

basse_lyrics_iii = \lyricmode {
  \set stanza = "2."
  ¡O __ qué Re -- yes ben -- di -- tos!
  Vá -- mo -- nos, vá -- _ mo -- nos yen -- do
  que ya te voy per -- cre -- yen -- do.
  Se -- gún o -- yó gran -- des gri -- tos __
  lle -- ve -- mos es -- tos ca -- bri -- tos,
}

basse_lyrics_iv = \lyricmode {
  Le -- van -- ta, le -- van -- _ ta
  a -- ba -- lle -- mos __ _ a Gra -- na -- da,
  que se sue -- na qu'es to -- ma -- da.
  por -- que~ha -- brá ven -- ta cha -- pa -- da __
  que se sue -- na qu'es to -- ma -- da.
}

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\basse_music}
  \addlyrics {\basse_lyrics}
  \addlyrics {\basse_lyrics_ii}
  \addlyrics {\basse_lyrics_iii}
  \addlyrics {\basse_lyrics_iv}
>>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveEmptyStaves
      }
      %% « Fine » et « D.S. » au-dessus du système : en dessous, ils se
      %% rangent après toutes les lignes de paroles de la basse et semblent
      %% appartenir au système suivant.
      \context {
        \Score
        \override JumpScript.direction = #UP
      }
      %% Les passages syllabiques serrent les paroles au point que le graveur
      %% escamote les traits d'union : on leur garantit de la place.
      %% Pour tenir en une page : interligne des paroles 2,6 au lieu de 2,8,
      %% et 1,2 au lieu de 1,5 entre la dernière ligne et la portée suivante.
      \context {
        \Lyrics
        \override LyricSpace.minimum-distance = #1.0
        \override LyricHyphen.minimum-distance = #1.5
        \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #2.6
        \override VerticalAxisGroup.nonstaff-unrelatedstaff-spacing.padding = #1.2
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

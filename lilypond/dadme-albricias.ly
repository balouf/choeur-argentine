\version "2.26.0"

%% Référence : l'édition PDF des « Villancicos de diversos autores
%% (Cancionero de Upsala) », nº 43, en 3/2. Le MusicXML disponible (CPDL,
%% 2000) est une autre édition, en 3/4 : ses hauteurs sont celles du PDF à
%% valeurs divisées par deux, et il a servi à contrôler la saisie. On garde les
%% valeurs du PDF.
%%
%% Le texte et sa répartition sont ceux du PDF — le MusicXML n'a qu'une ligne
%% de paroles, rien sous la copla, et une autre répartition au ténor. Le PDF
%% écrit « què nueva » à la basse, mesure 18 : coquille, corrigée en « qué »
%% comme aux autres voix.
%%
%% Forme : estribillo (mes. 1-25, Fine), copla reprise (26-33), D.C. Au retour,
%% les mesures 1 à 12 se chantent sur la seconde ligne (« y su nacer nos
%% releva… »). Les liaisons en pointillé des mesures 29 et 33 ne valent que
%% pour une des deux lignes : l'autre réarticule.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Dadme albricias, hijos d'Eva" }
  composer = "Anónimo"
  subsubtitle = "Villancicos de diversos autores (Cancionero de Upsala, Venecia 1556), nº 43"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 3/2
  \tempo 2 = 104
  \key f \major
}

soprano_music = {
  \repeat segno 2 {
  % 1
  c'1 c2 | c1 f,2 | a2 g1 | f1 f2 |
  % 5
  R1.*4 |
  % 9
  c'1 c2 | f1 e2 | f2 d1 | c1. |
  % 13
  R1.*3 | f2 f e |
  % 17
  d1 c2 | c1 \ficta b2 | c1. | R1.*2 |
  % 22
  c2 c bes | a1 g2 | f1 e2 | f1.\fermata |
  \volta 2 \fine
  \volta 1 \repeat volta 2 {
  % 26
  c'1 c2 | f1 e2 | f2 d1 | \tieDashed c1~ \syllabeSurLiee c2 \tieSolid |
  % 30
  f,1 f2 | bes1 a2 | bes2 g1 | \tieDashed f1~ \syllabeSurLiee f2 \tieSolid |
  }
  }
}

soprano_lyrics = \lyricmode {
  Dad -- me~al -- bri -- cias, hi -- jos d'E -- va,
  qu'es nas -- ci -- do~el nue -- vo~A -- dam.
  O hi de Dios, y qué nue -- va!
  O hi de Dios, y qué nue -- va!
  Dád -- me -- las y~ha -- ved pla -- cer, __ _
  pues es -- ta no -- che~es nas -- ci -- do
}

soprano_lyrics_ii = \lyricmode {
  y su na -- cer nos re -- le -- va
  qu'es nas -- ci -- do~el nue -- vo~A -- dam.
  \*16 _
  el Me -- xi -- as pro -- me -- ti -- do,
  Dios y hom -- bre, de mu -- jer, __ _
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
  \repeat segno 2 {
  % 1
  R1.*4 |
  % 5
  c1 c2 | d1 c2 | f1 e2 | f1. |
  % 9
  R1.*6 |
  % 15
  f2 f e | d1 c2 | d4( e f g a2) | a2 g1 |
  % 19
  g2 g f | e1 d2 | c4( d e f g e) | f1 d2 |
  % 23
  f1 e2 | a,2( c1) | c1.\fermata |
  \volta 2 \fine
  \volta 1 \repeat volta 2 {
  % 26
  R1.*4 |
  % 30
  d1 d2 | d1 f2 | d2 e1 | \tieDashed f1~ \syllabeSurLiee f2 \tieSolid |
  }
  }
}

alto_lyrics = \lyricmode {
  Di de qué dár -- te -- las han.
  O hi de Dios, y qué __ nue -- va!
  O hi de Dios, y qué __ nue -- va, y qué nue -- va!
  pues es -- ta no -- che~es nas -- ci -- do
}

alto_lyrics_ii = \lyricmode {
  del pe -- ca -- do~y de su~a -- fán.
  \*20 _
  Dios y hom -- bre, de mu -- jer, __ _
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
>>

tenor_music = {
  \repeat segno 2 {
  % 1
  R1.*4 |
  % 5
  a'1 a2 | bes1 a2 | f2 g1 | f1. |
  % 9
  R1.*4 |
  % 13
  c'2 c bes | a1 g2 | f4( g a bes c2) | a2.( bes4 c2) |
  % 17
  g2 d' f | f2( d1) | c1 r2 | c2 c bes |
  % 21
  a1 g2 | f1( g2) | a4( g a bes c2 | f,2 g1) | f1.\fermata |
  \volta 2 \fine
  \volta 1 \repeat volta 2 {
  % 26
  a1 a2 | d1 c2 | d2 bes4( c d e) | \tieDashed f1~ \syllabeSurLiee f2 \tieSolid |
  % 30
  a,1 a2 | bes1 c2 | bes2 c1 | \tieDashed c1~ \syllabeSurLiee c2 \tieSolid |
  }
  }
}

tenor_lyrics = \lyricmode {
  Di de qué dár -- te -- las han.
  O hi de Dios, y qué __ nue -- va, y qué nue -- va!
  O hi de Dios, y qué __ nue -- va!
  Dád -- me -- las y~ha -- ved pla -- cer, __ _
  pues es -- ta no -- che~es nas -- ci -- do
}

tenor_lyrics_ii = \lyricmode {
  del pe -- ca -- do~y de su~a -- fán.
  \*20 _
  el Me -- xi -- as pro -- me -- ti -- do,
  Dios y hom -- bre, de mu -- jer, __ _
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
  \addlyrics {\tenor_lyrics_ii}
>>

basse_music = {
  \repeat segno 2 {
  % 1
  R1.*4 |
  % 5
  f1 f2 | bes,1 f'2 | d2 c1 | f1. |
  % 9
  R1.*5 | f2 f e |
  % 15
  d1 c2 | d4( e f g a2) | bes1 a2 | f2 g1 |
  % 19
  c,1 r2 | R1. | c'2 c bes | a1 g2 |
  % 23
  f1 c2( | d2 c1) | f1.\fermata |
  \volta 2 \fine
  \volta 1 \repeat volta 2 {
  % 26
  R1.*4 |
  % 30
  d1 d2 | g1 f2 | g2 c,1 | \tieDashed f1~ \syllabeSurLiee f2 \tieSolid |
  }
  }
}

basse_lyrics = \lyricmode {
  Di de qué dár -- te -- las han.
  O hi de Dios, y qué __ nue -- va, qué nue -- va!
  O hi de Dios, y qué nue -- va!
  pues es -- ta no -- che~es nas -- ci -- do
}

basse_lyrics_ii = \lyricmode {
  del pe -- ca -- do~y de su~a -- fán.
  \*19 _
  Dios y hom -- bre, de mu -- jer, __ _
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
      %% « Fine » et « D.C. » au-dessus du système : en dessous, ils se
      %% rangent après toutes les lignes de paroles de la basse et semblent
      %% appartenir au système suivant.
      \context {
        \Score
        \override JumpScript.direction = #UP
      }
      %% Les passages syllabiques serrent les paroles au point que le graveur
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
        \tenor
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
        \tenor
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

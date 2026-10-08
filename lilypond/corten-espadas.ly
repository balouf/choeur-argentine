\version "2.26.0"

%% Référence : l'édition Ars Musica (1999), PDF. Notes reprises du MIDI de la
%% même édition, durées remises sur la grille (le MIDI les raccourcit pour
%% l'articulation), puis confrontées au PDF tête par tête : nom de note et
%% type de tête. Paroles relevées sur le PDF.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Corten espadas afiladas" }
  composer = "Anónimo"
  subsubtitle = "Cancionero de Medinaceli (s. XVI)"
  arranger = "Ed. : Ars Musica"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 2/2
  \tempo 2 = 72
  \key g \major
}

soprano_music = {
  % 1
  d'2 b4 g | c4. b8 a4 a | b2 g | a4 a fis2 |
  % 5
  g2 r | r4 d' b8 g c4 | a b g a | fis g8 e fis4 d |
  % 9
  g4 e fis d8 g~ | g e fis4 g2 | b4. a8 c4 b | g a b b |
  % 13
  R1 | r2 g4. g8 | a4 d c b | a g8 g4 fis8 fis4 |
  % 17
  d4 g e fis | g d' b8 g c4 | a b g a | fis g8 e fis4 d |
  % 21
  g4 e fis d8 g~ | g e fis4 g b~ | b b b b | b2 a |
  % 25
  g2 r4 b | b a b4. a8 | b4 c4. b8 b4~ | b a b2 |
  % 29
  R1 | r4 b b b~ | b g a2 | b c |
  % 33
  b4 a4. g8 g4 | fis2 r4 g | e fis d8 g4 e8 | fis4 g b4. a8 |
  % 37
  c4 b g a | b b r2 | R1 | g4. g8 a4 d8 d |
  % 41
  c4 b a g8 g~ | g fis fis4 d g | e fis g b | b b b b |
  % 45
  b4 a g4. a8 | b4 c4. b8 b4~ | b a b2 | r4 b2 b4 |
  % 49
  b4 b b g | a2 b | c b4 a~ | a8 g g2 fis4 |
  % 53
  r4 g e fis | d8 g4 e8 fis4 g8 d' | b g c4 a b8 b | g4 a d b8 g |
  % 57
  c4 a b g | a fis g8 e fis4 | d g e fis | d8 g4 e8 fis d g e |
  % 61
  fis4 d r g~ | g e fis2 | g1 \fine
}

soprano_lyrics = \lyricmode {
  Cor -- ten es -- pa -- das a -- fi -- la -- das len -- guas ma -- las, cor
  -- ten es -- pa -- das a -- fi -- la -- das, a -- fi -- la -- das len --
  guas ma -- las, len -- guas ma -- las. Ma -- ña -- na de San Fran -- cis
  -- co le -- van -- ta -- do me~an un di -- cho, le -- van -- ta -- do
  me~an un di -- cho. Cor -- ten es -- pa -- das a -- fi -- la -- das, a --
  fi -- la -- das len -- guas ma -- las, len -- guas ma -- las. Li -- be --
  ra -- me, Do -- mi -- ne, a -- la -- bi -- is __ _ yn -- _ _ i -- _ quis
  et a lin -- _ gua do -- _ _ _ _ lo -- sa. Len -- guas ma -- las, len --
  guas ma -- las le -- van -- ta -- do me~an un di -- cho: que dor -- mi con
  la ni -- ña vir -- go. Len -- guas ma -- las, len -- guas ma -- las. Be --
  a -- tus vir qui ti -- met Do -- _ _ _ _ mi -- _ num: yn man -- da -- tis
  e -- ius vo -- let ni -- _ _ _ _ mis. Len -- guas ma -- las, len -- guas
  ma -- las, cor -- ten es -- pa -- das a -- fi -- la -- das, cor -- ten es
  -- pa -- das a -- fi -- la -- das len -- guas ma -- las, len -- guas ma --
  las, len -- guas ma -- las, len -- guas ma -- las, len -- guas ma -- las.
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
>>

alto_music = {
  % 1
  r2 g' | e4 c f4. e8 | d4 d e2 | c d4 d |
  % 5
  b2 c | r g'4 e8 c | f4 d e c | d8 d b e d4 b |
  % 9
  d4 e d b8 d~ | d e d4 b2 | g'4. fis8 e4 d | e d b b |
  % 13
  R1 | d4. d8 e4 g | fis4. fis8 e4 d | d e8 c d2 |
  % 17
  b4 d e d | d2 g4 e8 c | f4 d e c | d8 d b e d4 b |
  % 21
  d4 e d b8 d~ | d e d4 b g'~ | g g g g | g2 e |
  % 25
  e2 r4 g | g fis g4. fis8 | g4 e g2 | e4 fis d g~ |
  % 29
  g4 fis8 e fis2 | r4 g g g~ | g d e fis | g2 g |
  % 33
  g4 e fis d | d2 r4 d | e d b8 d4 e8 | d4 b g'4. fis8 |
  % 37
  e4 d e d | b b r2 | r d4. d8 | e4 g8 g fis4 fis |
  % 41
  e4 d d e8 c | d2 b4 d | e d b g' | g g g g |
  % 45
  g4 e e2 | fis4 g2 g4 | e1 | r4 g2 g4 |
  % 49
  g4 g g d | e fis g2 | g fis | e d |
  % 53
  r4 d e d | b8 d4 e8 d4 d | g e8 c f4 d | e8 e c4 d g |
  % 57
  e8 c f4 d e | c d8 d b e d4 | b d e d | b8 d4 e8 d b d e |
  % 61
  d4 b r d | e2 d | b1 \fine
}

alto_lyrics = \lyricmode {
  Cor -- ten es -- pa -- das a -- fi -- la -- das len -- guas ma -- las, cor
  -- ten es -- pa -- das a -- fi -- la -- das, a -- fi -- la -- das len --
  guas ma -- las, len -- guas ma -- las. Ma -- ña -- na de San Fran -- cis
  -- co le -- van -- ta -- do me~an un di -- cho, le -- van -- _ ta -- do
  me~an un di -- cho. Cor -- ten es -- pa -- das a -- fi -- la -- das, a --
  fi -- la -- das len -- guas ma -- las, len -- guas ma -- las. Li -- be --
  ra -- me, Do -- mi -- ne, a -- la -- bi -- is yn -- i -- quis et a lin --
  gua do -- lo -- _ sa et a lin -- _ gua do -- lo -- sa, do -- _ lo -- _ sa.
  Len -- guas ma -- las, len -- guas ma -- las le -- van -- ta -- do me~an
  un di -- cho: que dor -- mi con la ni -- ña vir -- _ go. Len -- guas ma --
  las, len -- guas ma -- las. Be -- a -- tus vir qui ti -- met Do -- _ _ mi
  -- num: yn man -- da -- tis e -- ius vo -- _ let ni -- _ _ mis. Len --
  guas ma -- las, len -- guas ma -- las, cor -- ten es -- pa -- das a -- fi
  -- la -- das, cor -- ten es -- pa -- das a -- fi -- la -- das len -- guas
  ma -- las, len -- guas ma -- las, len -- guas ma -- las, len -- guas ma --
  las, len -- guas ma -- las.
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
>>

tenor_music = {
  % 1
  R1 | r2 d' | b4 g c4. b8 | a4 a b2 |
  % 5
  g2 a4 a | fis2 g | d'4 b8 g c4 a | b4. c8 a4 g |
  % 9
  b4 c a g8 b~ | b c a4 g2 | R1 | r2 b4. a8 |
  % 13
  c4 b g a | b b r2 | r g4. g8 | a4 c b8 b a4 |
  % 17
  g4 b c a | g2 r | d'4 b8 g c4 a | b g a g |
  % 21
  b4 c a g8 b~ | b c a4 g d'~ | d d d d | d2 c |
  % 25
  b2 r4 d | d2 d4 d | d e2 d4 | c2 b |
  % 29
  R1 | r4 d d d~ | d b c2 | d e |
  % 33
  d4 c2 b4 | a2 r4 b | c a g8 b4 c8 | a4 g r2 |
  % 37
  R1 | b4. a8 c4 b | g a b b | R1 |
  % 41
  g4. g8 a4 c8 c | b b a4 g b | c a g d' | d d d d |
  % 45
  d4 c b4. c8 | d4 e d b | c2 b | r4 d2 d4 |
  % 49
  d4 d d b | c2 d | e d | b4 c a2 |
  % 53
  r4 b c a | a8 b4 c8 a4 g | r2 d'4 b8 g | c4 a b8 b g4 |
  % 57
  a4 d b8 g c4 | a b4. c8 a4 | g b c a | g8 b4 c8 a g b c |
  % 61
  a4 g r b | c2 a | g1 \fine
}

tenor_lyrics = \lyricmode {
  Cor -- ten es -- pa -- das a -- fi -- la -- das len -- guas ma -- las, cor
  -- ten es -- pa -- das a -- fi -- la -- das len -- guas ma -- las, len --
  guas ma -- las. Ma -- ña -- na de San Fran -- cis -- co le -- van -- ta --
  do me~an un di -- cho, me~an un di -- cho. Cor -- ten es -- pa -- das a --
  fi -- la -- das len -- guas ma -- las, len -- guas ma -- las. Li -- be --
  ra -- me, Do -- mi -- ne, a -- la -- bi -- is yn -- i -- _ _ quis et a lin
  -- _ gua do -- _ lo -- _ _ sa. Len -- guas ma -- las, len -- guas ma --
  las le -- van -- ta -- do me~an un di -- cho que dor -- mi con la ni -- ña
  vir -- go. Len -- guas ma -- las. Be -- a -- tus vir qui ti -- met Do -- _
  _ _ _ _ mi -- num: yn man -- da -- tis e -- ius vo -- let ni -- _ _ _ mis.
  Len -- guas ma -- las, len -- guas ma -- las, cor -- ten es -- pa -- das a
  -- fi -- la -- das, cor -- ten es -- pa -- das a -- fi -- la -- das, len
  -- guas ma -- las, len -- guas ma -- las, len -- guas ma -- las, len --
  guas ma -- las.
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
>>

basse_music = {
  % 1
  R1*2 | g'2 e4 c | f4. e8 d4 d |
  % 5
  e2 c | d4 d e c | r g' e8 c f4 | d e8 c d4 g, |
  % 9
  g'4 c, d g,8 g'~ | g c, d4 g,2 | R1 | r2 g'4. fis8 |
  % 13
  e4 d e d | b b r2 | d4. d8 e4 g | fis e d2 |
  % 17
  g,4 g' c, d | g,2 r | r4 g' e8 c f4 | d e8 c d4 g, |
  % 21
  g'4 c, d g,8 g'~ | g c, d4 g, g'~ | g g g g | g2 a |
  % 25
  e2 r4 g | g d g4. d8 | g4 c,2 g'4 | a fis g e~ |
  % 29
  e4 d8 c b2 | r4 g' g g~ | g b a2 | g c, |
  % 33
  g'4 a fis g | d2 r4 g | c, d g,8 g'4 c,8 | d4 g, r2 |
  % 37
  R1 | g'4. fis8 e4 d | e d b b | r2 d4. d8 |
  % 41
  e4 g8 g fis4 e | d2 g,4 g' | c, d g, g' | g g g g |
  % 45
  g4 a e2 | d4 c g'2 | a g | r4 g2 g4 |
  % 49
  g4 g g b | a2 g | c, d | e4 c d2 |
  % 53
  r4 g c, d | g,8 g'4 c,8 d4 g, | r2. g'4 | e8 c f4 d e8 e |
  % 57
  c4 d g e8 c | f4 d e8 c d4 | g, g' c, d | g,8 g'4 c,8 d g, g' c, |
  % 61
  d4 g, r g' | c,2 d | g,1 \fine
}

basse_lyrics = \lyricmode {
  Cor -- ten es -- pa -- das a -- fi -- la -- das len -- guas ma -- las, cor
  -- ten es -- pa -- das a -- fi -- la -- das len -- guas ma -- las, len --
  guas ma -- las. Ma -- ña -- na de San Fran -- cis -- co le -- van -- ta --
  do me~an un di -- cho, me~an un di -- cho. Cor -- ten es -- pa -- das a --
  fi -- la -- das len -- guas ma -- las, len -- guas ma -- las. Li -- be --
  ra -- me, Do -- mi -- ne, a -- la -- bi -- is yn -- i -- quis et a lin --
  gua do -- lo -- _ sa et a lin -- _ gua do -- _ lo -- _ _ _ sa. Len -- guas
  ma -- las, len -- guas ma -- las le -- van -- ta -- do me~an un di -- cho
  que dor -- mi con la ni -- ña vir -- go. Len -- guas ma -- las. Be -- a --
  tus vir qui ti -- met Do -- _ _ _ mi -- num: yn man -- da -- tis e -- ius
  vo -- let ni -- _ _ _ mis. Len -- guas ma -- las, len -- guas ma -- las,
  cor -- ten es -- pa -- das a -- fi -- la -- das, cor -- ten es -- pa --
  das a -- fi -- la -- das, len -- guas ma -- las, len -- guas ma -- las,
  len -- guas ma -- las, len -- guas ma -- las.
}

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\basse_music}
  \addlyrics {\basse_lyrics}
>>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveEmptyStaves
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

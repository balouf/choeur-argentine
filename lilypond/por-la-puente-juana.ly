\version "2.26.0"

%% Référence : la partition en si mineur à 6/4 (soprano, alto, baryton en clé
%% de fa). L'édition « Solo Voces » (part_sv580, en ré mineur, barrée à C avec
%% une levée de trois noires) n'a servi qu'à contrôler la saisie : c'est une
%% autre édition, et là où les deux divergent la référence tranche —
%%
%%   - mes. 4, alto : ré noire, ré blanche, do dièse noire (Solo Voces lie les
%%     deux ré et allonge le do dièse) ;
%%   - mes. 6, soprano : « -te » sur si (la chez Solo Voces) ;
%%   - mes. 10-11, « Agora que el » : valeurs plus longues, neuf noires au lieu
%%     de six, et l'alto reste sur ré ;
%%   - mes. 18 : le soprano finit sur si, à l'unisson de l'alto (tierce majeure
%%     chez Solo Voces) ;
%%   - texte : « de jazmín » (« del » chez Solo Voces), et la référence ne note
%%     ni « Fim » ni « D.C. ».
%%
%% Écarts à la référence :
%%
%%   - la reprise de la copla est écrite avec une alternative. La référence ne
%%     grave qu'une mesure 18, « Y » compris, sous un crochet sans numéro : le
%%     « Y » relance le second couplet (« Y da a tus cabellos… ») et ne se
%%     chante donc que la première fois. La seconde fois s'arrête sur la blanche
%%     pointée ;
%%   - mes. 17, alto : la référence écrit « tu __ ra » et « bios __ na », un
%%     trait de prolongation à la place de « ca- » et de « gra- ». Coquille,
%%     corrigée d'après les deux autres voix ;
%%   - les mélismes portent une liaison, que la référence ne grave pas.
%%
%% Le tempo n'est donné par aucune des deux sources.

#(set-default-paper-size "a4")

%% Quatre systèmes, comme la référence : laissé à lui-même, LilyPond en fait
%% trois et tasse toute la copla sur le dernier. Le `\break` du soprano fait
%% commencer la copla, donc la reprise, en début de système.
\paper {
  system-count = #4
}

\header {
  title = \markup { \fontsize #5 \bold "Por la puente, Juana" }
  composer = "Anónimo"
  subsubtitle = "Cancionero de Turín"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 6/4
  \tempo 2. = 56
  \key b \minor
}

soprano_music = {
  % 1
  r2. r4 fis g | a2 fis4 b2.~ | b4 fis fis g fis e | d4.( e8 fis2 e) |
  % 5
  fis2. r4 a a | b2 b4 a2.~ | a4 a2 r4 fis2 | a2. r4 g2 |
  % 9
  fis4 b b ais2. | b2. r4 fis2 | \break
  \repeat volta 2 {
    % 11
    fis2. g4 g2 | a2 a4 r a a | a4 d,2 e2. | fis2. r4 e fis |
    % 15
    g4 g2 fis2. | e2. r4 fis2 | d4 e4. d8 cis2. |
    \alternative {
      \volta 1 { b2. r4 fis'2 | }
      \volta 2 { b,2. r2. | }
    }
  }
  \fine
}

soprano_lyrics = \lyricmode {
  Por la puen -- te Jua -- na, que no por el a -- gua.
  Por la puen -- te Jua -- na que no, que no por el a -- gua.
  A -- go -- ra que~el tiem -- po con las ma -- nos fran -- cas,
  de jaz -- mín y ro -- sa com -- po -- ne tu ca -- ra. Y
}

soprano_lyrics_ii = \lyricmode {
  \*27 _
  da~a tus ca -- be -- llos el o -- ro de~A -- ra -- bia,
  a tus dien -- tes per -- las y~a tus la -- bios gra -- _ _ na.
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
  % 1
  r4 b cis d2 b4 | fis'2. d4 r b | d4 cis d e d cis | b4 d d d2( cis4) |
  % 5
  d2. r4 d e | fis2 fis4 fis2.~ | fis4 e2 r4 d2 | cis2. r4 e2 |
  % 9
  d4. cis8 b4 cis2. | b2. r4 d2 |
  \repeat volta 2 {
    % 11
    d2. e2 d4 | cis2 cis4 r fis fis | e4 d d2( cis) | d2. r4 cis d |
    % 15
    e4 e2 d2. | cis2. r4 d2 | b4 cis4. b8 ais2. |
    \alternative {
      \volta 1 { b2. r4 d2 | }
      \volta 2 { b2. r2. | }
    }
  }
  \fine
}

alto_lyrics = \lyricmode {
  Por la puen -- te Jua -- na que no por el a -- gua, que no por el a -- gua.
  Por la puen -- te Jua -- na que no, que no por el a -- gua.
  A -- go -- ra que~el tiem -- po con las ma -- nos fran -- cas,
  de jaz -- mín y ro -- sa com -- po -- ne tu ca -- ra. Y
}

alto_lyrics_ii = \lyricmode {
  \*33 _
  da~a tus ca -- be -- llos el o -- ro de~A -- ra -- bia,
  a tus dien -- tes per -- las y~a tus la -- bios gra -- _ _ na.
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
>>

baryton_music = {
  % 1
  R1. | r4 fis fis g2 e4 | b'2. e,4 r e | g4 fis4. g8 a2. |
  % 5
  d,2. r4 d' cis | b2 b4 d2.~ | d4 a2 r4 b2 | fis2. r4 e2 |
  % 9
  b'4. a8 g4 fis2. | b,2. r4 b'2 |
  \repeat volta 2 {
    % 11
    b2. e,4 e2 | fis2 fis4 r d' d | a4 b2 a2. | d,2. r4 a' a |
    % 15
    e4 e2 fis4( gis2) | a2. r4 d,2 | g4 e e fis2. |
    \alternative {
      \volta 1 { b,2. r4 b'2 | }
      \volta 2 { b,2. r2. | }
    }
  }
  \fine
}

baryton_lyrics = \lyricmode {
  Por la puen -- te Jua -- na, que no por el a -- gua.
  Por la puen -- te Jua -- na que no, que no por el a -- gua.
  A -- go -- ra que~el tiem -- po con las ma -- nos fran -- cas,
  de jaz -- mín y ro -- sa com -- po -- ne tu ca -- ra. Y
}

baryton_lyrics_ii = \lyricmode {
  \*27 _
  da~a tus ca -- be -- llos el o -- ro de~A -- ra -- bia,
  a tus dien -- tes per -- las y~a tus la -- bios gra -- _ _ na.
}

baryton = \new Staff \with {instrumentName="Baryton"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\baryton_music}
  \addlyrics {\baryton_lyrics}
  \addlyrics {\baryton_lyrics_ii}
>>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
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
        \baryton
      >>
    >>
  }
  \score {
    \unfoldRepeats
    <<
      \new ChoirStaff <<
        \soprano
        \alto
        \baryton
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

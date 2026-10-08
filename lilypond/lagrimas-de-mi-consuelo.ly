\version "2.26.0"

%% Référence : l'édition du Grupo Vocal « Solo Voces » (Lugo), d'après la
%% transcription de Higinio Anglés. Saisie reprise de l'édition de Nancho
%% Alvarez (tomasluisdevictoria.org, nº 18 du recueil), confrontée note à note
%% au PDF. Les paroles sont celles du PDF, dans sa graphie ancienne
%% (« Qu'aveys », « mexillas », « soleys »), et non celles de Nancho Alvarez,
%% modernisées.
%%
%% Hauteurs et *musica ficta* sont celles du PDF, qui s'écarte de Nancho
%% Alvarez en trois endroits :
%%   - Quinta parte, mesure 43 : do, comme l'original (renvoi 1 du PDF) ;
%%     Anglés, et Nancho Alvarez après lui, écrivent la.
%%   - Alto, mesure 43 : do naturel (renvoi 2 : Anglés suggère do dièse).
%%   - Alto, mesure 26 : do naturel, sans ficta.
%%
%% Les crochets `\[ \]` sont ceux des ligatures de la source ; la brève finale
%% est gravée dans une mesure de 2/2, comme au PDF.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Lágrimas de mi consuelo" }
  composer = "Juan Vásquez (c. 1500-c. 1560)"
  poet = "Garci Sánchez de Badajoz (1460-1526)"
  subsubtitle = "Recopilación de sonetos y villancicos a quatro y a cinco (Sevilla, 1560)"
  arranger = "Transcr. : Higinio Anglés"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 2/2
  \tempo 2 = 60
  \key f \major
}

soprano_music = {
  R1*4 | d4 d f2 ~ | f4 f f2 ~ | f2 e |
  f2. e4 | c2 d ~ | d r | d4 e f g |
  a2 a ~ | a4 g e2 ~ | e g | d1 |
  e | d | c2 e | d2 c |
  d1 | c2 c' | c4 c c2 | d2. bes4 |
  bes2 g | a1 ~ | a | f2 g |
  a2 g4 f | e d c2 | c1 | R1 |
  d2. d4 | d2 d | d d | g1 |
  f2 d ~ | d4 c c2 | d2 bes | c1 |
  r2 f ~ | f e ~ | e4 d d2 | r2 a'2 ~ |
  a g ~ | g4 f f2 | g2 e ~ | e4 d d2 ~ |
  d \ficta cis | d1 ~ | d ~ | d ~ |
  d ~ | d\breve*1/2 \fine
}

soprano_lyrics = \lyricmode {
  Lá -- gri -- mas __ de mi __ con -- sue -- _ _ lo, __ Qu'a -- veys he --
  cho ma -- ra -- _ vi -- _ llas, y ha -- zeys, y ha -- _ _ zeys, Sa -- lid,
  sa -- lid sin re -- ce -- _ lo, __ sin __ _ re -- _ _ ce -- _ _ lo y re --
  gad es -- tas me -- xi -- llas Que __ _ so -- leys, __ _ _ que __ so -- _
  leys, que __ _ _ so -- _ _ _ leys, __
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
>>

alto_music = {
  R1*3 | r2 g4 g | bes2. bes4 | bes2 a |
  bes2( c | d2. c4 | a bes2 a4) | bes2 g4 a |
  bes c d2 ~ | d c | c2. d4 | e2 d ~ |
  d4 e f f, | g2. a4 | bes c d2 | R1*3 |
  e2 e4 e | e2 f ~ | f4 d d2 | e2. d4 |
  c bes d2 ~ | d c | d1 | e2. d4 |
  c2. bes4 | a2 f | bes1 | a |
  bes | bes2. bes4 | bes2 bes | d bes |
  c2 e | d f ~ | f e | f bes, |
  c1 | c2 a4 bes | c d2 \ficta cis4 | d1 ~ |
  d | \[e2 c\] | R1 | e2 e |
  f2. e4 | d c bes2 ~ | bes1 | a1 ~ |
  a\breve*1/2 \fine
}

alto_lyrics = \lyricmode {
  Lá -- gri -- mas de mi con -- sue -- lo Qu'a -- veys he -- cho
  ma -- ra -- vi -- _ llas, y __ _ _ ha -- zeys, __ _ _ _ _ Sa -- lid, sa --
  lid sin __ _ re -- ce -- _ _ _ _ _ lo, sa -- _ lid __ _ sin re -- ce -- _
  lo y re -- gad es -- tas me -- xi -- _ llas Que __ _ so -- _ leys, que
  so -- _ _ _ _ leys, __ _ _ que so -- leys. __
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \tenor_style
  \armure
  \relative c'' {\alto_music}
  \addlyrics {\alto_lyrics}
>>

quinta_music = {
  R1*6 | r2 c4 c | f2. f4 | f2 f ~ |
  f e | f1 | r2 f4 g | a4 bes c2 |
  g4 a bes c | d2 a | c1 | bes2 a4 g |
  a2 g | r2 a ~ | a g | a2 a |
  a4 a a2 | bes2. g4 | g2. f4 | e d f2 |
  e1 | r2 d ~ | d4 c e f | g2 a ~ |
  a4 f a2 ~ | a4 g g2 ~ | g \ficta fis | g2 g ~ |
  g4 g g2 | g bes ~ | bes4 a f g | a2 g ~ |
  g4 f8 e d2 | c1 | d | r2 c |
  e f4 g | a bes c2 | bes1 | a2. g8 f |
  e1 | f2 g | a1 | f2 a ~ |
  a4 g f e | f2 g ~ | g \ficta fis4 e | fis\breve*1/2 \fine
}

quinta_lyrics = \lyricmode {
  Lá -- gri -- mas de mi con -- sue -- lo, Qu'a -- veys he -- _ cho ma -- _
  ra -- _ vi -- llas, y ha -- _ _ _ zeys, y __ ha -- zeys, Sa -- lid, sa --
  lid sin re -- ce -- _ _ _ _ lo, sa -- lid, sa -- _ lid sin __ _ re -- _
  ce -- _ lo y __ re -- gad es -- tas __ me -- xi -- _ llas Que __ _ _ _
  so -- leys, que so -- _ _ _ _ _ _ _ _ _ _ _ _ _ leys, que __ _ _ _ so -- _
  _ _ leys.
}

quinta = \new Staff \with {instrumentName="Quinta parte"
  shortInstrumentName ="Q."} <<
  \tenor_style
  \armure
  \relative c' {\quinta_music}
  \addlyrics {\quinta_lyrics}
>>

tenor_music = {
  r2 d4 d | f2. f4 | f2 f ~ | f e |
  f1 ~ | f | R1*4 | r2 d4 e |
  f g a2 ~ | a2 a | g1 | f |
  e2 g ~  | g4 f d e | f2 e | f1 |
  d | e1 | R1*6 | e2 e4 e |
  e2 e4 e | f2. e4 | d1 ~ | d ~ |
  d | r2 d2 ~ | d4 d d2 | d2 f ~ |
  f2 e | f1 | g | f2. g4 |
  a1 | g2 f | e1 | d |
  R1*2 | d1 | e | d ~ |
  d ~ | d ~ | d ~ | d\breve*1/2 \fine
}

tenor_lyrics = \lyricmode {
  Lá -- gri -- mas de mi con -- sue -- lo __ Qu'a -- veys he -- cho ma --
  ra -- vi -- llas, y __ _ _ _ _ ha -- _ _ _ zeys, Sa -- lid, sa -- lid sin
  re -- ce -- _ lo __ y __ re -- gad es -- tas __ me -- xi -- _ llas __ _
  Que so -- _ _ leys, que so -- leys. __
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \hommes_style
  \armure
  \relative c {\tenor_music}
  \addlyrics {\tenor_lyrics}
>>

basse_music = {
  g4 g bes2 ~ | bes4 bes bes2 ~ | bes2 a | bes c |
  bes2. a8 g | f1 | R1 | d'4 d f2 ~ |
  f4 e d c | bes2 c | bes2. a8 g | f2 r |
  f4 g a bes | c2 g4 a | bes c d2 | c1 |
  d2 f ~ | f4 e c2 | bes a | bes1 |
  a1 ~ | a | R1*2 | a2 a4 a |
  a1 | bes | a2 c ~ | c4 bes a g |
  f1 | g | R1 | g2. g4 |
  g2 g | g4 g g2 | bes1 | a2 c |
  bes1 | R1 | bes1 | a2. bes4 |
  c2 d | a1 | bes2 g | d'1 |
  c | bes | a | r2 f' ~ |
  f4 e d c | bes a g2 | d'1 ~ | d\breve*1/2 \fine
}

basse_lyrics = \lyricmode {
  Lá -- gri -- mas __ de mi __ con -- sue -- _ _ _ _ lo, lá -- gri -- mas __
  _ de __ _ mi con -- sue -- _ _ lo Qu'a -- veys he -- cho ma -- ra -- _
  vi -- _ _ llas, y ha -- _ _ _ _ _ zeys, __ Sa -- lid, sa -- lid sin re --
  ce -- _ _ _ _ lo, y re -- gad es -- tas me -- xi -- llas Que so -- leys,
  que so -- _ _ _ _ leys, que so -- _ _ leys, que __ _ _ _ so -- _ _
  leys. __
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
        \quinta
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
        \quinta
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

\version "2.26.0"

%% SQUELETTE — les hauteurs et les rythmes restent à saisir.
%%
%% Le manuscrit (Vivian Tabbush, VI/85) échappe au pipeline de `tools/` : il
%% n'a pas de couche vectorielle, seulement une image. Ce fichier porte donc
%% ce qui se lit sans risque sur le fac-similé — structure, repères, accords,
%% paroles, récitatif — et laisse les notes à la saisie.
%%
%% Les mesures sont écrites en silences `s2` (invisibles) ou `R2` (pause de
%% mesure) système par système, avec en commentaire la page et le système du
%% manuscrit. **Les nombres de mesures sont relevés à l'œil sur le fac-similé
%% et restent à confirmer** : c'est la seule chose ici qui ne soit pas sûre.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Cuando tenga la tierra" }
  composer = "Ariel Petrocelli — Daniel Toro"
  arranger = "Arreglo : Vivian Tabbush (VI/85)"
  subtitle = "Coro mixto y percusión — Edición especial para Festival B.A.C. '85"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"
\include "utils/AccordsJazzDefs.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 2/4
  \key d \minor
}

%% ------------------------------------------------------------------
%% Accords, relevés sur le manuscrit. Ils commandent le découpage : une
%% durée d'accord vaut une mesure tant qu'on n'écrit rien d'autre.
%% ------------------------------------------------------------------

accords = \chords {
  %% p1 sys1-2 — introduction des basses seules
  d2:m s s s s4 c d2:m s4 c d2:m s4 c d2:m s s
  %% p1 sys3-4 — repère A, « instr. tacet » puis « instr. toca »
  s2*8
  g2
  %% p2 sys1
  f2 c d:m a:m d:m
  %% p2 sys2 — soprano et alto à l'unisson
  s2*2 g2 d:m c d:m
  %% p2 sys3 — repère B
  c2 d:m s2*4
  %% p3 sys1 — ténor et basse à l'unisson
  s2*2 g2 d:m c d:m
  %% p3 sys2 — repère C
  c2 d:m s2*3 f2
  %% p3 sys3
  s2 g2 s2 f2 s2
  %% p4 sys1
  s2*3 g2
  %% p4 sys2 — segno, « tacet »
  s2 a2:7/g s2*2 d:m
  %% p4 sys3 — à reprendre deux fois, puis al segno
  s2 c2 s2 d:m g2/d d:m
  %% p5 — de la reprise à la fin
  d2:m s2 c2 s2 d:m g2/d d:m d:m
}

%% ------------------------------------------------------------------
%% Les quatre voix. Chaque ligne est un système du manuscrit ; remplacer
%% les `s2` / `R2` par les notes, en gardant les repères et les barres.
%% ------------------------------------------------------------------

soprano_music = \relative c' {
  %% p1 sys1-2 — les basses seules
  R2*12
  %% p1 sys3 — repère A : le soprano se tait
  %% « cresc. poco a poco », « instr. tacet »
  \mark \markup { \box "A" }
  R2*4 |
  %% p1 sys4 — « instr. toca »
  R2*4 |
  %% p2 sys1 — « ...sino, campesino, campesino. » puis 1re/2e fois
  s2*3 | s2*2 |
  %% p2 sys2 — soprano et alto à l'unisson
  s2*5 |
  %% p2 sys3 — repère B
  \mark \markup { \box "B" }
  s2*6 |
  %% p3 sys1 — ténor et basse seuls
  R2*5 |
  %% p3 sys2 — repère C
  \mark \markup { \box "C" }
  s2*6 |
  %% p3 sys3
  s2*4 |
  %% p4 sys1
  s2*4 |
  %% p4 sys2 — segno
  s2*5 |
  %% p4 sys3 — deux fois, puis al segno
  s2*5 |
  %% p5 — jusqu'à Fin
  s2*7 |
}

%% Paroles relevées sur le manuscrit. Les deux couplets alternent : le
%% premier est écrit au-dessus, le second en dessous, sur les passages à
%% l'unisson. Décommenter les `\addlyrics` une fois les notes saisies.

soprano_lyrics = \lyricmode {
  Cuan -- do ten -- ga la tie -- rra, cam -- pe -- si -- no, cam -- pe --
  si -- no, cam -- pe -- si -- no. Cuan -- do ten -- ga la tie -- rra,
  te lo ju -- ro se -- mi -- lla, que la vi -- da se -- rá un dul -- ce
  ra -- ci -- mo y~en el mar de las u -- vas nues -- tro vi -- no
  can -- ta -- ré, can -- ta -- ré, can -- ta -- ré.
}

alto_music = \relative c' {
  %% p1 sys1-2 — les basses seules
  R2*12
  %% p1 sys3 — « Cuando tenga la tierra, cuando tenga la tierra »
  s2*4 |
  %% p1 sys4
  s2*4 |
  s2*3 | s2*2 |
  s2*5 |
  s2*6 |
  R2*5 |
  s2*6 |
  s2*4 |
  s2*4 |
  s2*5 |
  s2*5 |
  s2*7 |
}

alto_lyrics = \lyricmode {
  Cuan -- do ten -- ga la tie -- rra, cuan -- do ten -- ga la tie -- rra,
  cam -- pe -- si -- no, cam -- pe -- si -- no, cam -- pe -- si -- no.
  %% soprano et alto à l'unisson, p2 sys2-3 — deux couplets :
  %%   1. Sem -- bra -- ré las pa -- la -- bras que mi pa -- dre
  %%      Mar -- tín Fie -- rro pu -- so~al vien -- to
  %%   2. Le da -- ré~a las es -- tre -- llas as -- tro -- nau -- tas
  %%      de tri -- ga -- les, lu -- na nue -- va
  can -- ta -- ré, can -- ta -- ré, can -- ta -- ré.
}

tenor_music = \relative c' {
  %% p1 sys1-2 — les basses seules
  R2*12
  s2*4 |
  s2*4 |
  s2*3 | s2*2 |
  R2*5 |
  s2*6 |
  %% p3 sys1 — ténor et basse à l'unisson
  s2*5 |
  s2*6 |
  s2*4 |
  s2*4 |
  s2*5 |
  s2*5 |
  s2*7 |
}

tenor_lyrics = \lyricmode {
  Cuan -- do ten -- ga la tie -- rra, cuan -- do ten -- ga la tie -- rra,
  cam -- pe -- si -- no, cam -- pe -- si -- no, cam -- pe -- si -- no.
  %% ténor et basse à l'unisson, p3 sys1-2 — deux couplets :
  %%   1. La ten -- drán los que lu -- chan, los ma -- es -- tros,
  %%      los ha -- che -- ros, los o -- bre -- ros
  %%   2. For -- ma -- ré con los gri -- llos u -- na~or -- ques -- ta
  %%      don -- de can -- ten los que pien -- san
  can -- ta -- ré, can -- ta -- ré, can -- ta -- ré.
}

basse_music = \relative c {
  %% p1 sys1-2 — introduction des basses seules
  %% « Cuando tenga la tierra, sembraré las palabras
  %%   que mi padre Martín Fierro puso al viento »
   s8 d16 e f8 16 e f8 8~4 r8 d16 e f f8 e16 f8 8~4 |
   r4 g8. e16 f8 8~4 r4 e8. c16 d8 8~4 r c8. e16 d8 8~4 R2*2|
   \break
   % A
  s2*4 |
  s2*4 |
  s2*3 | s2*2 |
  R2*5 |
  s2*6 |
  s2*5 |
  s2*6 |
  s2*4 |
  s2*4 |
  s2*5 |
  s2*5 |
  s2*7 |
}

basse_lyrics = \lyricmode {
  %% p1 sys1-2, les basses seules
  Cuan -- do ten -- ga la tie -- rra, sem -- bra -- ré las pa -- la -- bras
  que mi pa -- dre Mar -- tín Fie -- rro pu -- so~al vien -- to.
  %% à partir du repère A
  Cuan -- do, cuan -- do ten -- ga la tie -- rra, cuan -- do ten -- ga la
  tie -- rra, cam -- pe -- si -- no, cam -- pe -- si -- no, cam -- pe --
  si -- no. can -- ta -- ré, can -- ta -- ré, can -- ta -- ré.
}

%% ------------------------------------------------------------------
%% « Base rítmica » — la percussion, notée sur une ligne dans le
%% manuscrit (p1, entre l'introduction et le repère A). Motif à saisir.
%% ------------------------------------------------------------------

percussion_music = {
  %% motif d'ostinato à saisir, puis à répéter jusqu'au repère A
  \%12 {a8 16 16 8 16 16 |}
}

percussion = \new RhythmicStaff \with {instrumentName="Base rítmica"
  shortInstrumentName ="Perc."} {
  \time 2/4
  \percussion_music
}

%% ------------------------------------------------------------------

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \soprano_music
  %% \addlyrics {\soprano_lyrics}
>>

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \alto_music
  %% \addlyrics {\alto_lyrics}
>>

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \tenor_music
  %% \addlyrics {\tenor_lyrics}
>>

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \basse_music
  \addlyrics {\basse_lyrics}
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
    <<
      \new ChordNames \accords
      \new ChoirStaff
      <<
        \soprano
        \alto
        \tenor
        \basse
      >>
      \percussion
    >>
  }
  \markup { \vspace #2 }
  \markup {
    \column {
      \line { \bold \underline "Recitado" }
      \vspace #0.5
      \line { "Campesino, cuando tenga la tierra" }
      \line { "sucederá en el mundo el corazón de mi mundo" }
      \line { "desde atrás de todo el olvido" }
      \line { "secaré con mis lágrimas todo el horror de la lástima" }
      \line { "y por fin te veré, campesino," }
      \line { "campesino, campesino, campesino." }
      \line { "Dueño de mirar la noche" }
      \line { "en que nos acostamos para hacer los hijos" }
      \line { "campesino, cuando tenga la tierra" }
      \line { "le pondré la luna en el bolsillo," }
      \line { "y saldré a pasear con los árboles" }
      \line { "y el silencio y los hombres" }
      \line { "y las mujeres conmigo." }
      \vspace #0.5
      \line { "Cantaré, cantaré..." }
      \vspace #1
      \line { \italic "La segunda repetición puede tararearse como fondo (pp)" }
      \line { \italic "al recitado. El mismo deberá terminar al mismo tiempo" }
      \line { \italic "que la melodía llega al segno." }
    }
  }
  \score {
    \unfoldRepeats
    <<
      \soprano
      \alto
      \tenor
      \basse
    >>
    \midi {}
  }
}


%{
convert-ly.py (GNU LilyPond) 2.26.0  convert-ly.py: Processing `'...
Applying conversion: 2.23.1, 2.23.2, 2.23.3, 2.23.4, 2.23.5, 2.23.6,
2.23.7, 2.23.8, 2.23.9, 2.23.10, 2.23.11, 2.23.12, 2.23.13, 2.23.14,
2.24.0, 2.25.0, 2.25.1, 2.25.2, 2.25.3, 2.25.4, 2.25.5, 2.25.6,
2.25.8, 2.25.9, 2.25.11, 2.25.12, 2.25.13, 2.25.18, 2.25.22, 2.25.23,
2.25.24, 2.25.25, 2.25.26, 2.25.28, 2.25.30, 2.25.31, 2.25.32,
2.25.33, 2.25.34, 2.25.35, 2.25.80, 2.26.0
%}

\version "2.26.0"

%% Saisi à la main. Le manuscrit (Vivian Tabbush, VI/85) échappe au pipeline
%% de `tools/` : il n'a pas de couche vectorielle, seulement une image.
%%
%% Structure du fac-similé, telle qu'elle est traduite ici :
%%
%%   p1          intro des basses seules, puis repère A      m1-25
%%   p2 à p4     le corps, à partir du segno                 m26-66
%%   fin de p4   « cantaré », 1re et 2e fois                 1re alternative
%%   p5          « cantaré » jusqu'à FIN, 3e fois            2e alternative
%%
%% Le manuscrit écrit « AL (segno) · 2 VECES · Y (coda) » : deux renvois, donc
%% **trois** passages. Les deux premiers portent les deux couplets écrits ; le
%% troisième se chante bouche fermée sous le récitatif — c'est ce que dit la
%% note de bas de page, reproduite en fin de partition.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Cuando tenga la tierra" }
  composer = "Ariel Petrocelli — Daniel Toro"
  arranger = "Arreglo : Vivian Tabbush (VI/85)"
  subsubtitle = "Coro mixto y percusión — Edición especial para Festival B.A.C. '85"
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
  \tempo 4=72
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
  s2*7 s4
  f g c d:m a:m d2:m s2*2
  %% Segno — « 2 veces al segno y coda » sur le manuscrit, soit trois
  %% passages : couplet 1, couplet 2, puis bouche fermée sous le récitatif.
  \repeat segno 3 {
    s2*4 s4 g d2:m \* 2 {s4 c d2:m} s2*2
    % B sign
    s2*4 s4 g d2:m \* 2 {s4 c d2:m} s2*2
    % C sign
    f2 s s g s f \*5 s g s a:7/g s s s
    \alternative {
      %% 1re et 2e fois : la reprise « cantaré » de la p4, puis retour au segno
      { \repeat volta 2 {s d:m s c s d:m g/d d:m s s} }
      %% 3e fois : la coda de la p5
      { s \repeat volta 2 {d:m s c s d:m g/d d:m \alternative {{s}{d:m}}} }
    }
  }
}

%% ------------------------------------------------------------------
%% Les quatre voix. Chaque ligne correspond à un système du manuscrit, et
%% les commentaires `p<n> sys<m>` renvoient à sa page et à son système.
%% ------------------------------------------------------------------

soprano_music = \relative c' {
  %% p1 sys1-2 — les basses seules
  R2*12
  %% p1 sys3 — repère A : le soprano se tait
  %% « cresc. poco a poco », « instr. tacet »
  \mark \markup { \box "A" }
  R2*4 | \break
  %% p1 sys4 — « instr. toca »
  r8^\mf^\< e16 f g8 16 f | g8 8~4 |
  r8^\f^\< f16 g a8 16 g | a8 8 \breathe b8.->\ff g16|
  a8 8 g8.^\> e16 | f8 8 e8. c16 | d8 8~4\! | R2*2 \break
  %% Segno. Corps chanté trois fois, cf. `accords`.
  \repeat segno 3 {
  r8^\p^"with Alti" f16 g a8 16 g | a8 8~4 | r8 f16 g a16 8 g16 | a8 8~4|
  r4 b8. g16 a8 8~4 | r4 g8. e16 f8 8~4 |
  \break
  r4 e8. c16 | d8^\> 8~4~2~2~ \mark \markup { \box "B" } 4 r4\!|
  r2*11 | 
  \mark \markup { \box "C" }
  r8 a'16 bes c8 16 d c2 | 8 f,16 g a8 b16 c b8 8~4 |
  r4 b8 8 | c2 | a~| a |
  r8 a16 bes c8 16 d c8 8~4~8\breathe f,16 g a8 b16 c b8 8~4 |
  r4 b8 8 cis2^\ff 2~2~4 r4
  \alternative {
    % 1re et 2e fois
    { \repeat volta 2 {
      d4-- e-- f2~2 \breathe e2~4. c8 d2~2~4 r r2*2} }
    % 3e fois
    { \break d4-- e--
      \repeat volta 2 {f2~2\breathe e2~4. c8 d2~2~2\laissezVibrer
      \alternative {{d4-- e--}{d2~\repeatTie \fermata}}}
      %% `\fine` est de niveau `Score` : un par voix produirait trois rejets
      %% d'événement. Mais sa barre finale, elle, ne vaut que pour **sa**
      %% portée — c'est pour ça que tes cinq `\fine` donnaient bien cinq
      %% barres de fin. `\bar` n'a pas ce défaut : posé une fois, il vaut
      %% pour toutes les portées de la `\score`. D'où le couple.
      \fine \bar "|." }
  }
  }
}

%% Paroles relevées sur le manuscrit. Les deux couplets alternent : le
%% premier est écrit au-dessus, le second en dessous, sur les passages à
%% l'unisson. Les `*_lyrics_ii` sautent d'abord le nombre de syllabes du
%% premier couplet (`\*N _`) pour se caler là où le second commence.
%%
%% Elles ne se déplient pas sous le renvoi : chaque ligne suit la musique
%% **écrite**, une seule fois. C'est assumé — le MIDI ignore les paroles et
%% aucune version dépliée n'est gravée.

soprano_lyrics = \lyricmode {
  Cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  cam -- pe -- si -- no, cam -- pe -- si -- no, cam -- pe -- si -- no. __ 
  Cuan -- do ten -- ga la tie -- rra, __
  sem -- bra -- ré las pa -- la -- bras
  que mi pa -- dre Mar -- tin Fie -- rro __
  pu -- so~al vien -- to __
  
  Cuan -- do ten -- ga la tie -- rra,
  te lo ju -- ro se -- mi -- lla, __
  que la vi -- da __ se -- rá~un dul -- ce  ra -- ci -- mo __ 
  y~en el mar de las u -- vas __  
  nues -- tro vi -- no __
  can -- ta -- ré, __ can -- ta -- ré. __
  can -- ta -- ré, __ can -- ta -- ré. __ can -- ta- "_"
}

soprano_lyrics_ii = \lyricmode { 
  \*33 _ le da -- ré~a las es -- tre -- llas
  as -- tro -- nau -- tas de tri -- ga -- les lu -- na nue -- va __
}

alto_music = \relative c' {
  %% p1 sys1-2 — les basses seules
  R2*12
  r8^\pp^\< a16 b c8 16 b | c8 8~4 |
  r8^\p^\< c16 d e8 16 d | e8 8~4 |
  r8^\mf^\< c16 d e8 16 d | e8 8~4 |
  r8^\f^\< d16 e f8 16 e | f8 8 \breathe g8.->\ff d16|
  f8 8 e8.^\> 16| d8 8 c8. 16 | d8 8~4\! | R2*2
  %% Segno. Corps chanté trois fois, cf. `accords`.
  \repeat segno 3 {
  %% l'alto se tait jusqu'au « puso al viento »
  R2*8 |
  r4 e8. c16 | a8 8~4 | r8 a16 b c8 16 b a8 8 ~4 ~ 4 r|
  r2*11 | f'2-> | 8 \breathe f16 g a8 16 bes | a8 f~4 |
  r8 d16 e f8 16 g | f8 8~4 | r4 a8 8 | f2 2 \breathe |
  f2 8 \breathe f16 g a8 16 bes a8 f~4 |
  r8 d16 e f8 16 g16 f8 8 \breathe g g a2^\ff 2~2~4 r
  \alternative {
    % 1re et 2e fois
    { \repeat volta 2 {r2 a4-- 4-- 4 f8 8 g2 \breathe 4 4 f4 8 8 g2( f4) r r2*2} }
    % 3e fois
    { r2 \repeat volta 2 {r4 a8 8 4 8 8 g4 8 8 4 8 8 f4 8 8 g4 8 8 f2\laissezVibrer
      \alternative {{r2}{2\repeatTie\fermata}}} }
  }
  }
}

alto_lyrics = \lyricmode {
  Cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  cam -- pe -- si -- no, cam -- pe -- si -- no, cam -- pe -- si -- no. __
  
  pu -- so~al vien -- to __ cuan -- do ten -- gua la tie -- rra __
  
  cuan -- do  cuan -- do ten -- ga la tie -- rra, __
  te lo ju -- ro se -- mi -- lla, __
  que la vi -- da se -- ra  se -- rá~un dul -- ce  ra -- ci -- mo __ 
  y~en el mar de las u -- vas __  
  nues -- tro vi -- no __

  
  can -- ta -- ré, can -- ta -- ré, can -- ta -- ré, can -- ta -- ré. __
  can -- ta -- ré, can -- ta -- ré, can -- ta -- ré,
  can -- ta -- ré, can -- ta -- ré, can -- ta -- ré. __ "_"
}

alto_lyrics_ii = \lyricmode { 
  \*40 _ lu -- na nue -- va __
}


tenor_music = \relative c' {
  %% p1 sys1-2 — les basses seules
  R2*12
  r8^\pp^\< f16 g a8 16 g | a8 8~4 |
  r8^\p^\< a16 b c8 16 b | c8 8~4 |
  r8^\mf^\< a16 bes c8 16 bes | c8 8~4 |
  r8^\f^\< bes16 c d8 16 c | d8 8 \breathe 8.->\ff b16|
  c8 8 8.^\> 16 | a8 8 8. 16 | 8 8~4\! | r2*2 |
  %% Segno. Corps chanté trois fois, cf. `accords`.
  \repeat segno 3 {
  r2*12 | r8^\mf^"with Bass" f16 g a8 16 g a8 8~4 | \break
  r8 f16 g a8 16 g a8 8~4 | r4 b8. g16 a8 8~4 | r4 g8. e16 f8 8~4 |
  r4 e8. c16 d8 8~4 | r8^\p d16 e f8 16 g a8 8~4~ | 8 r r4 |
  r8 a16 bes c8 16 d | c8 8 ~4 | r8 b16 c d8 16 e | d8 8~4|
  r4 c8 8 2 4 \breathe 8 8 c2 8 \breathe a16 bes c8 16 d c8 8~4 |
  r8 b16 c d8 16 e | d8 8 \breathe 8 8 e2^\ff 2~2~4 r
  \alternative {
    % 1re et 2e fois
    { \repeat volta 2 {r2 d8-- 8-- 4--~2 r4 e8 d c4 8 e d4 8 c b2( a4) r r2*2} }
    % 3e fois
    { r2 \repeat volta 2 {r4 d8 8 2 r4 c8 8 2 r4 d8 c b4 8 8 a4\breathe 8 8
      \alternative {{4 r}{2\fermata}}} }
  }
  }
}

tenor_lyrics = \lyricmode {
  Cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  cam -- pe -- si -- no, cam -- pe -- si -- no, cam -- pe -- si -- no. __
  
  cuan -- do ten -- ga la tie -- rra, __
  La ten -- drán los que lu -- chan, los ma -- es -- tros,
  los ha -- che -- ros, los o -- bre -- ros
  cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __
  te lo ju -- ro se -- mi -- lla, __
  que la vi -- da que la vi -- da se -- rá~un dul -- ce  ra -- ci -- mo __ 
  y~en el mar de las u -- vas __  
  nues -- tro vi -- no __

can -- ta -- ré, __ can -- ta -- ré, can -- ta -- ré, can -- ta -- ré. __
can -- ta -- ré, can -- ta -- ré, can -- ta -- ré,
can -- ta -- ré, can -- ta -- ré, -ré. __
}

tenor_lyrics_ii = \lyricmode { \*47 _
For -- ma -- ré con los gri -- llos u -- na~or -- ques -- ta
don -- de can -- ten los que pien -- san
}


basse_music = \relative c {
  %% p1 sys1-2 — introduction des basses seules
  %% « Cuando tenga la tierra, sembraré las palabras
  %%   que mi padre Martín Fierro puso al viento »
   r8 d16 e f8 16 e f8 8~4 r8 d16 e f f8 e16 f8 8~4 |
   r4 g8. e16 f8 8~4 r4 e8. c16 d8 8~4 r c8. e16 d8 8~4 R2*2|
   \break
   % A
  d4->^\mf 4 | r8^\pp^\< 16 16 8 16 16 | 8\p^\< 8~4 | r8 16 16 8 16 16 |
  8\mf^\< 8~4 | r8^\f^\< 16 16 8 16 16 | 8 8~8 r16 16 | 8 8 \breathe g8.->\ff  16 |
  f8 8 c8.^\> 16 | d8 8 a8. 16 | d8 8~4\! | r2*2 |
  %% Segno. Corps chanté trois fois, cf. `accords`.
  \repeat segno 3 {
  r2*20 | r4 e8. c16 d8 8 ~4~2~2 |
  % C
  r8 f16 g a8 16 bes a8 f~4 | r8 c'16 bes a8 g16 f g8 8~4 |
  r4 g8 8 f2 4 \breathe c8 8 f2
  8 \breathe 16 g a8 16 bes a8 f~4 | r8 c'16 bes a8 g16 f g8 8~4 |
  r4 8 8 2^\ff 2~2~4 r
  % reprises / coda
  \alternative {
    % 1re et 2e fois
    { \repeat volta 2 {r2 r4 f8-- e-- d2\breathe c c d~2~4 r r2*2} }
    % 3e fois
    { r2 \repeat volta 2 { r4 8 8 2 r4 e8 8 2 r4 d8 8 4 8 8 4\breathe 8 8
                           \alternative {{4 r}{2\fermata}} } }
  }
  }
  
}

basse_lyrics = \lyricmode {
  %% p1 sys1-2, les basses seules
  Cuan -- do ten -- ga la tie -- rra, sem -- bra -- ré las pa -- la -- bras
  que mi pa -- dre Mar -- tín Fie -- rro pu -- so~al vien -- to.
  %% à partir du repère A
  Cuan -- do, cuan -- do ten -- ga la tie -- rra, __ 
  cuan -- do ten -- ga la tie -- rra, __
  cuan -- do ten -- ga la tie -- rra, __ la tie -- rra
  cam -- pe -- si -- no, cam -- pe -- si -- no, cam -- pe --
  si -- no. __
  los o -- bre -- ros __
  cuan -- do ten -- ga la tie -- rra, __
  te lo ju -- ro se -- mi -- lla, __
  que la vi -- da que la vi -- da se -- rá~un dul -- ce  ra -- ci -- mo __ 
  y~en el mar de las u -- vas __  
  nues -- tro vi -- no __

  
  can -- ta -- ré, can -- ta -- ré. __
  can -- ta -- ré, can -- ta -- ré, can -- ta -- ré,
  can -- ta -- ré, can -- ta -- ré, -ré. __
}

basse_lyrics_ii = \lyricmode { \*64 _
los que pien -- san __
}


%% ------------------------------------------------------------------

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \soprano_music
  \addlyrics {\soprano_lyrics}
  \addlyrics {\soprano_lyrics_ii}
>>

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \alto_music
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
>>

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \tenor_music
  \addlyrics {\tenor_lyrics}
  \addlyrics {\tenor_lyrics_ii}
>>

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \basse_music
  \addlyrics {\basse_lyrics}
  \addlyrics {\basse_lyrics_ii}
>>

%% ------------------------------------------------------------------
%% Les accords, mais joués. La partition grave les chiffrages seuls, en
%% `ChordNames`, qui ne sonnent pas ; les mêmes accords posés sur une
%% portée deviennent des notes. Cette portée-là ne sert qu'au MIDI : elle
%% n'entre que dans la seconde `\score`, celle qui n'a pas de `\layout`.
%% ------------------------------------------------------------------

accompagnement = \new Staff \with {
  instrumentName="Piano"
  shortInstrumentName ="Pno."
  midiInstrument = "acoustic grand"
} \accords

%% ------------------------------------------------------------------
%% « Base rítmica » — la percussion. Le manuscrit ne la donne qu'en
%% **légende** : une seule mesure de motif sur un bout de portée, posée p1
%% entre l'introduction et le repère A, sans dire où elle joue. Elle tourne
%% donc ici sous l'introduction des basses et s'arrête au repère A, qui
%% porte « instr. tacet ». Reste ouvert : le « instr. toca » de la m20 ne
%% la relance pas.
%%
%% Déclarée **après** les autres, et c'est voulu : `deploy.py` relève les
%% `instrumentName` dans l'ordre du fichier et le lecteur du site les
%% apparie aux pistes MIDI **par rang**. Les cinq premiers noms doivent
%% donc être ceux des cinq pistes, dans le même ordre. La percussion ne
%% sonne pas — elle aide à lire la partition, rien de plus — donc son nom
%% vient en sixième position, où personne ne le lira.
%% ------------------------------------------------------------------

percussion_music = {
  %% l'ostinato, répété jusqu'au repère A
  \%12 {a8 16 16 8 16 16 |}
}

percussion = \new RhythmicStaff \with {instrumentName="Base rítmica"
  shortInstrumentName ="Perc."} {
  \time 2/4
  \percussion_music
}

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveAllEmptyStaves
      }
      \context {
        \Score
        %% `\repeat segno` pose deux marques de coda : la n°1 au départ (un
        %% signe simple, là où on quitte) et la n°2 sur la section elle-même
        %% (signe double). On nomme la seconde, pour qu'elle se lise « Coda »
        %% et pas seulement comme un signe à retrouver à l'œil.
        codaMarkFormatter =
          #(lambda (n ctx)
             (if (= n 2)
                 (make-line-markup
                   (list (format-coda-mark 1 ctx) (make-bold-markup "Coda")))
                 (format-coda-mark n ctx)))
        %% `CodaMark` est livré en `begin-of-line-invisible` : visible au bout
        %% de la ligne précédente, masqué en tête de la suivante. Pour une
        %% marque de départ c'est juste, pour la section d'arrivée c'est
        %% l'inverse de ce qu'on cherche du regard.
        \override CodaMark.break-visibility = #end-of-line-invisible
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
      %% Le manuscrit écrit ici le signe de coda, pas celui du segno : le
      %% récitatif s'arrête en **entrant** dans la coda, à la fin du 3e passage.
      \line { \italic "que la melodía llega a la coda." }
    }
  }
  \score {
    \unfoldRepeats
    <<
      \soprano
      \alto
      \tenor
      \basse
      \accompagnement
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

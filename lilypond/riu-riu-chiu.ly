\version "2.26.0"

%% Référence : l'édition PDF des « Villancicos de diversos autores
%% (Cancionero de Upsala) », nº 46. Saisie reprise du MusicXML de James Gibb,
%% d'une autre édition : mêmes hauteurs, même rythme, mais une autre barre.
%%
%% Ce qui vient du MusicXML : la barre en 4/4 continu. Le PDF intercale des
%% mesures à 2/4 et fait chevaucher les blanches par-dessus la barre ; le
%% MusicXML écrit la même chose en liaisons de tenue, plus lisible.
%%
%% Ce qui vient du PDF, contre le MusicXML :
%%   - les silences de l'introduction de la basse : deux temps entre deux
%%     phrases, et non six ; l'introduction compte 13 mesures et non 15 ;
%%   - l'alto à la fin de « ribera » (mesure 17) : do naturel, sans le do
%%     dièse de ficta que met le MusicXML ;
%%   - tout le texte, refrain et sept couplets, et sa répartition sous les
%%     notes ;
%%   - les liaisons de tenue en pointillé des couplets : chacune ne vaut que
%%     pour certains d'entre eux, les autres réarticulent la note.
%%
%% L'alto est en clé de sol octaviée dans le PDF et sonne à la même hauteur
%% que dans le MusicXML : on le garde en clé de sol, à sa hauteur réelle.
%%
%% Forme : introduction de la basse seule, refrain à quatre voix (segno),
%% couplet de la basse seule, D.S. al Fine. Le PDF donne sept couplets ; le
%% MIDI n'en joue qu'un passage, la musique étant la même.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Riu, riu, chiu" }
  composer = "Anónimo (atr. Mateo Flecha el Viejo, 1481-1553)"
  subsubtitle = "Villancicos de diversos autores (Cancionero de Upsala, Venecia 1556), nº 46"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 4/4
  \tempo 4 = 132
  \key c \major
}

soprano_music = {
  R1*13 |
  \repeat segno 2 {
  % 14
  a'4 a g a | f2 e4 d~ | d e f g | a2 a |
  % 18
  R1 | r2 a4 a | g a f2 | e4 f2 f4 |
  % 22
  e e d2 | d2 r | R1 | a'4 a g a |
  % 26
  f2 e4 d~ | d4 d c c | d2 d |
  \volta 2 \fine
  \volta 1 {
  % 29
  R1*16 |
  }
  }
}

soprano_lyrics = \lyricmode {
  Ri -- u, ri -- u, chi -- u, la __ guar -- da ri -- be -- ra,
  Dios guar -- dó del lo -- bo a nues -- tra cor -- de -- ra,
  Dios guar -- dó del lo -- bo a __ nues -- tra cor -- de -- ra.
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
>>

alto_music = {
  R1*13 |
  \repeat segno 2 {
  % 14
  f4 f e c | d2 e4 f~ | f e d d | \ficta cis2 cis |
  % 18
  R1 | e4 e d c | e c d2 | c4 d2 d4 |
  % 22
  c c d2 | d2 r | r e4 e | d c e c |
  % 26
  d2 c4 a~ | a4 a a a | a2 a |
  \volta 2 \fine
  \volta 1 {
  % 29
  R1*16 |
  }
  }
}

alto_lyrics = \lyricmode {
  Ri -- u, ri -- u, chi -- u, la __ guar -- da ri -- be -- ra,
  Dios guar -- dó del lo -- bo, del lo -- bo~a nues -- tra cor -- de -- ra,
  Dios guar -- dó del lo -- bo, del lo -- bo~a __ nues -- tra cor -- de -- ra.
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
>>

tenor_music = {
  R1*13 |
  \repeat segno 2 {
  % 14
  c'4 c c a | a2 a4 a~ | a a d, d | e2 e |
  % 18
  r2 c'4 c | b c a2 | b4 a a2 | a4 a2 a4 |
  % 22
  a a a2 | a2 r | c4 c b c | a2 b4 a |
  % 26
  a2 a4 f~ | f4 f e e | d2 d |
  \volta 2 \fine
  \volta 1 {
  % 29
  R1*16 |
  }
  }
}

tenor_lyrics = \lyricmode {
  Ri -- u, ri -- u, chi -- u, la __ guar -- da ri -- be -- ra,
  Dios guar -- dó del lo -- bo, del lo -- bo a nues -- tra cor -- de -- ra,
  Dios guar -- dó del lo -- bo, del lo -- bo a __ nues -- tra cor -- de -- ra.
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
>>

%% Les liaisons en pointillé ne valent que pour une partie des couplets :
%% `\syllabeSurLiee` rend la note liée disponible pour une syllabe, et les
%% couplets qui tiennent y écrivent `_`.
basse_music = {
  % 1 — introduction, la basse seule
  a'4 a g a | f2 e4 d~ | d e f g | a2 a |
  % 5
  r2 a4 a | g a f2 | e4 g2 g4 | e4 f d2 |
  % 9
  d2 r | a'4 a g a | f2 e4 g~ | g g e f |
  % 13
  d2 d | \break
  \repeat segno 2 {
  % 14 — refrain
  f4 f c f | d2 a4 d~ | d c bes bes | a2 a |
  % 18
  r2 a'4 a | g a f2 | e4 f d2 | a4 d2 d4 |
  % 22
  a a d2 | d2 r | a'4 a g a | f2 e4 f |
  % 26
  d2 a4 d~ | d4 d a a | d2 d |
  \volta 2 \fine \break
  \volta 1 {
  % 29 — couplets
  a'4 a g a | f2 e4 g~ | g4 g e f | \tieDashed d2~ \syllabeSurLiee d \tieSolid |
  % 33
  a'4 a g a | f2 f4 e | \tieDashed g4~ \syllabeSurLiee g \tieSolid e f |
  \tieDashed d2~ \syllabeSurLiee d \tieSolid |
  % 37
  a'4 a g a | \tieDashed f2~ \syllabeSurLiee f4 \tieSolid e |
  d4 e f g | \tieDashed a2~ \syllabeSurLiee a \tieSolid |
  % 41
  a4 a g a | \tieDashed f2~ \syllabeSurLiee f4 \tieSolid e |
  \tieDashed g4~ \syllabeSurLiee g \tieSolid e f | d2 d |
  }
  }
}

basse_lyrics = \lyricmode {
  Ri -- u, ri -- u, chi -- u, la __ guar -- da ri -- be -- ra,
  Dios guar -- dó del lo -- bo a nues -- tra cor -- de -- ra,
  Dios guar -- dó del lo -- bo a __ nues -- tra cor -- de -- ra.
  Ri -- u, ri -- u, chi -- u, la __ guar -- da ri -- be -- ra,
  Dios guar -- dó del lo -- bo, del lo -- bo a nues -- tra cor -- de -- ra,
  Dios guar -- dó del lo -- bo, del lo -- bo a __ nues -- tra cor -- de -- ra.
  \set stanza = "1."
  El lo -- bo ra -- bio -- so la qui -- so mor -- der, __ _
  más Dios po -- de -- ro -- so la su -- po de -- fen -- der, __ _
  qui -- so -- la ha -- cer que no pu -- die -- se pe -- car, __ _
  ni~aun o -- ri -- gi -- nal es -- ta vir -- gen no tu -- vie -- ra.
}

basse_lyrics_ii = \lyricmode {
  \*78 _
  \set stanza = "2."
  Es -- te que~es na -- ci -- do es el gran mo -- nar -- ca,
  Chri -- sto pa -- tri -- ar -- ca de car -- _ ne ves -- ti -- do,
  ha nos re -- di -- mi -- do con se ha -- cer chi -- qui -- to,
  aun -- que~e -- ra~in -- fi -- ni -- to, fi -- ni -- to se hi -- cie -- ra.
}

basse_lyrics_iii = \lyricmode {
  \*78 _
  \set stanza = "3."
  Mu -- chas pro -- fe -- cí -- as lo~han pro -- fe -- ti -- za -- do,
  y~aun en nues -- tras dí -- as lo he -- mos al -- can -- ça -- do,
  a Dios hu -- ma -- na -- _ do ve -- mos en el sue -- lo,
  y~al hom -- bre~en el cie -- lo por -- que El lo qui -- sie -- ra.
}

basse_lyrics_iv = \lyricmode {
  \*78 _
  \set stanza = "4."
  Yo vi mil gar -- ço -- nes que~an -- da -- ban can -- tan -- do,
  por a -- qui vo -- lan -- do ha -- cien -- _ do mil so -- nes,
  di -- cien -- do~a gas -- co -- nes: Glo -- ria se -- a~en el cie -- lo
  y paz en el sue -- lo, pues Je -- _ sús na -- çie -- ra.
}

basse_lyrics_v = \lyricmode {
  \*78 _
  \set stanza = "5."
  Es -- te vie -- ne a dar a los muer -- tos vi -- da
  y vie -- ne~a re -- pa -- rar de to -- dos la ca -- í -- da,
  es la luz del dí -- _ a a -- ques -- te mo -- çue -- lo,
  es -- te~es el cor -- de -- ro, que San Ju -- an di -- xe -- ra.
}

basse_lyrics_vi = \lyricmode {
  \*78 _
  \set stanza = "6."
  Mi -- ra bien que~os cua -- dre que~an -- si -- na lo~o -- ye -- ra,
  que Dios no pu -- die -- ra ha -- cer -- la más que ma -- dre,
  el que~e -- ra su pa -- dre hoy de~el -- la nas -- çi -- ó, __ _
  y~el que la cri -- ó __ _ su hi -- jo se di -- xe -- ra.
}

basse_lyrics_vii = \lyricmode {
  \*78 _
  \set stanza = "7."
  Pues que ya te -- ne -- mos lo que de -- se -- a -- mos,
  to -- dos jun -- tos va -- mos, pre -- sen -- _ tes lle -- va -- mos,
  to -- dos le da -- re -- _ mos nues -- tra vo -- lun -- tad, __ _
  pues a se~i -- gua -- lar con el hom -- _ bre vi -- nie -- ra.
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
  \addlyrics {\basse_lyrics_v}
  \addlyrics {\basse_lyrics_vi}
  \addlyrics {\basse_lyrics_vii}
>>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveAllEmptyStaves
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

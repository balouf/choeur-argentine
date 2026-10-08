\version "2.26.0"

%% Source : édition du Coro Gaudeamus (PDF), et un MusicXML de la même
%% gravure pour la saisie.
%%
%% Trois lignes de paroles, comme sur le PDF : le texte profane en deux
%% couplets, puis le contrafactum sacré *Pan divino, gracioso* en italique.
%% Le second couplet s'arrête mesure 26 : la fin, à partir de « que, si
%% conmigo es dura », se reprend sur le texte du premier.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Prado verde y florido" }
  subtitle = "Pan divino, gracioso"
  composer = "Francisco Guerrero (1528-1599)"
  arranger = "Ed. : Coro Gaudeamus"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 4/4
  \tempo 2 = 66
  \key ees \major
}

soprano_music = {
  \repeat volta 2 {
  % 1
  g'2. g4 | bes2 aes4 g | aes2 g | r4 bes2 bes4 |
  % 5
  g2 f4 ees | f2 bes | r4 g2 ees4 | f2 g |
  % 9
  r4 g bes4. bes8 | c4 d ees2 | d4 ees2 bes4 | c2 d |
  % 13
  r4 bes c2~ | c4 c c c | bes2 g | aes g |
  % 17
  bes2 bes | r4 f g g | aes g bes2 | bes r |
  % 21
  f2 g4 g | aes g bes2 | c r4 c | c bes2 a4 |
  % 25
  bes1 | R1 | r4 ees, g bes~ | bes8 bes a4 bes2 |
  % 29
  g2 r4 ees | ees'4. d8 c4 bes | aes g aes c | bes( g2 f8 ees |
  % 33
  f2) g | r4 g aes2~ | aes4 aes aes g | f2 g |
  % 37
  bes2 aes | bes1 | bes |
  }
}

soprano_lyrics = \lyricmode {
  Pra -- do ver -- de~y flo -- ri -- do, pra -- do ver -- de~y flo -- ri --
  do, fuen -- te cla -- ra, a -- le -- gres ar -- bo -- le -- das y som --
  brí -- as; pues veis __ las pe -- nas mí -- as ca -- da ho -- ra, con --
  tad -- las blan -- da -- men -- te, con -- tad -- las blan -- da -- men --
  te a mi pas -- to -- ra; que, si con -- mi -- go~es du -- ra, qui -- zá
  la~a -- blan -- da -- rá vues -- tra fres -- cu -- ra, qui -- zá __ la~a --
  blan -- da -- rá vues -- tra fres -- cu -- ra.
}

soprano_lyrics_ii = \lyricmode {
  El fres -- co~y man -- so vien -- to el fres -- co~y man -- so vien -- to
  que~os a -- le -- gra es -- tá de mis sus -- pi -- ros in -- fla -- ma --
  do, y pues __ os ha da -- ña -- do has -- ta~a -- go -- ra, pe -- did vues --
  tro re -- me -- dio, pe -- did vues -- tro re -- me -- dio a mi pas --
  to -- ra;
}

soprano_lyrics_iii = \lyricmode {
  \emph
  Pan di -- vi -- no, gra -- cio -- so, pan di -- vi -- no, gra -- cio --
  so, sa -- cro -- san -- to, man -- jar que da sus -- ten -- to~al al -- ma
  mí -- a; di -- cho -- so fue~a -- quel dí -- a, pun -- to~y ho -- ra, que~en
  ta -- les dos es -- pe -- cies, que~en ta -- les dos es -- pe -- cies
  Cris -- to mo -- _ ra; que, si~el al -- ma~es -- tá du -- ra, a -- quí se~a --
  blan -- da -- rá con tal dul -- zu -- ra, a -- quí __ se~a -- blan -- da --
  rá con tal dul -- zu -- ra.
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
  \addlyrics {\soprano_lyrics_ii}
  \addlyrics {\soprano_lyrics_iii}
>>

alto_music = {
  \repeat volta 2 {
  % 1
  ees2. ees4 | ees2 aes,4 bes | c( d) ees2 | g2. g4 |
  % 5
  bes2 aes4 g | aes2 g | r4 ees2 ees4 | d2 ees |
  % 9
  r4 ees g4. g8 | aes4 bes a2 | bes4 g2 g4 | a2 bes |
  % 13
  r4 g aes2~ | aes4 aes aes4. g8 | f2 ees | ees2. ees4 |
  % 17
  f2 f | R1 | r2 f | g4 g aes g |
  % 21
  bes2 bes4 bes | ees, ees f g | aes2 aes4 aes | aes g f2 |
  % 25
  f1 | r4 ees g bes~ | bes8 bes a4 bes2 | ees, r |
  % 29
  r4 bes' ees4. d8 | c4 bes aes g | ees ees ees4.( f8) | g4 bes bes a |
  % 33
  bes2 bes | r4 ees, ees2~ | ees4 f f ees | c2 ees |
  % 37
  g2 ees | f1 | g |
  }
}

alto_lyrics = \lyricmode {
  Pra -- do ver -- de~y flo -- ri -- do, pra -- do ver -- de~y flo -- ri --
  do, fuen -- te cla -- ra, a -- le -- gres ar -- bo -- le -- das y som --
  brí -- as; pues veis __ las pe -- nas mí -- as ca -- da ho -- ra, con --
  tad -- las blan -- da -- men -- te, con -- tad -- las blan -- da -- men --
  te a mi pas -- to -- ra; que, si con -- mi -- go~es du -- ra, qui -- zá
  la~a -- blan -- da -- rá vues -- tra fres -- cu -- ra, vues -- tra fres --
  cu -- ra, qui -- zá __ la~a -- blan -- da -- rá vues -- tra fres -- cu -- ra.
}

alto_lyrics_ii = \lyricmode {
  El fres -- co~y man -- so vien -- to el fres -- co~y man -- so vien -- to
  que~os a -- le -- gra es -- tá de mis sus -- pi -- ros in -- fla -- ma --
  do, y pues __ os ha da -- ña -- do has -- ta~a -- go -- ra, pe -- did vues --
  tro re -- me -- dio, pe -- did vues -- tro re -- me -- dio a mi pas --
  to -- ra;
}

alto_lyrics_iii = \lyricmode {
  \emph
  Pan di -- vi -- no, gra -- cio -- so, pan di -- vi -- no, gra -- cio --
  so, sa -- cro -- san -- to, man -- jar que da sus -- ten -- to~al al -- ma
  mí -- a; di -- cho -- so fue~a -- quel dí -- a, pun -- to~y ho -- ra, que~en
  ta -- les dos es -- pe -- cies, que~en ta -- les dos es -- pe -- cies
  Cris -- _ to mo -- ra; que, si~el al -- ma~es -- tá du -- ra, a -- quí se~a --
  blan -- da -- rá con tal dul -- zu -- ra, con tal dul -- zu -- ra, a --
  quí __ se~a -- blan -- da -- rá con tal dul -- zu -- ra.
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
  \addlyrics {\alto_lyrics_iii}
>>

tenor_music = {
  \repeat volta 2 {
  % 1
  R1*3 | ees'2. ees4 |
  % 5
  ees2 aes,4 bes | c( d) ees2 | r4 bes2 c4 | aes2 bes |
  % 9
  r4 bes ees4. d8 | c4 bes ees2 | f4 ees2 d4 | ees2 f |
  % 13
  r4 ees ees2~ | ees4 f ees c | d2 bes | c c4 ees~( |
  % 17
  ees4 d8 c) d2 | bes ees4 ees | c c d2 | ees r |
  % 21
  bes2 ees4 ees | c c d2 | ees f4 ees | ees4. d8 c2 |
  % 25
  d2 r4 bes | c ees4. ees8 d4 | c2 bes | r r4 bes |
  % 29
  ees4. d8 c4 bes | aes g aes ees | aes ees r ees'~ | ees bes d ees~( |
  % 33
  ees4 d) ees2 | r4 bes c2~ | c4 des des bes~( | bes a) bes ees~ |
  % 37
  ees4 bes c ees~( | ees d8 c d2) | ees1 |
  }
}

tenor_lyrics = \lyricmode {
  Pra -- do ver -- de~y flo -- ri -- do, fuen -- te cla -- ra, a -- le --
  gres ar -- bo -- le -- das y som -- brí -- as; pues veis __ las pe -- nas
  mí -- as ca -- da ho -- ra, con -- tad -- las blan -- da -- men -- te,
  con -- tad -- las blan -- da -- men -- te a mi __ _ pas -- to -- ra; que,
  si con -- mi -- go~es du -- ra, qui -- zá la~a -- blan -- da -- rá vues --
  tra fres -- cu -- ra, vues -- tra fres -- cu -- ra, qui -- zá __ la~a --
  blan -- da -- rá vues -- tra fres -- cu -- ra.
}

tenor_lyrics_ii = \lyricmode {
  El fres -- co~y man -- so vien -- to que~os a -- le -- gra es -- tá de mis
  sus -- pi -- ros in -- fla -- ma -- do, y pues __ os ha da -- ña -- do
  has -- ta~a -- go -- ra, pe -- did vues -- tro re -- me -- dio, pe -- did
  vues -- tro re -- me -- dio a mi __ _ pas -- to -- ra;
}

tenor_lyrics_iii = \lyricmode {
  \emph
  Pan di -- vi -- no, gra -- cio -- so, sa -- cro -- san -- to, man -- jar
  que da sus -- ten -- to~al al -- ma mí -- a; di -- cho -- so fue~a -- quel
  dí -- a, pun -- to~y ho -- ra, que~en ta -- les dos es -- pe -- cies,
  que~en ta -- les dos es -- pe -- cies Cris -- to mo -- _ _ ra; que, si~el
  al -- ma~es -- tá du -- ra, a -- quí se~a -- blan -- da -- rá con tal dul --
  zu -- ra, con __ tal dul -- zu -- ra, a -- quí __ se~a -- blan -- da -- rá
  con __ tal dul -- zu -- ra.
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
  \addlyrics {\tenor_lyrics_ii}
  \addlyrics {\tenor_lyrics_iii}
>>

basse_music = {
  \repeat volta 2 {
  % 1
  R1*3 | r4 ees2 ees4 |
  % 5
  ees2 f4 g | f2 ees | r4 ees2 aes4 | f2 ees |
  % 9
  r4 ees ees ees | ees' d c2 | bes4 c2 g4 | c2 bes |
  % 13
  r4 ees, aes2~ | aes4 f aes aes | bes2 ees, | aes c |
  % 17
  bes2 bes | R1 | r2 bes | ees4 ees c c |
  % 21
  d2 ees4 ees, | aes c bes bes | aes2 f4 aes | aes ees f2 |
  % 25
  bes,1 | r2 r4 bes' | c ees4. ees8 d4 | c2 bes |
  % 29
  R1 | r4 ees, ees'4. d8 | c4 bes aes2 | ees bes'4 c |
  % 33
  bes2 ees, | r4 ees aes2~ | aes4 des, des ees | f2 ees |
  % 37
  ees2 aes, | bes1 | ees |
  }
}

basse_lyrics = \lyricmode {
  Pra -- do ver -- de~y flo -- ri -- do, fuen -- te cla -- ra, a -- le --
  gres ar -- bo -- le -- das y som -- brí -- as; pues veis __ las pe -- nas
  mí -- as ca -- da ho -- ra, con -- tad -- las blan -- da -- men -- te,
  con -- tad -- las blan -- da -- men -- te a mi pas -- to -- ra; que, si
  con -- mi -- go~es du -- ra, qui -- zá la~a -- blan -- da -- rá vues -- tra
  fres -- cu -- ra, qui -- zá __ la~a -- blan -- da -- rá vues -- tra fres --
  cu -- ra.
}

basse_lyrics_ii = \lyricmode {
  El fres -- co~y man -- so vien -- to que~os a -- le -- gra es -- tá de mis
  sus -- pi -- ros in -- fla -- ma -- do, y pues __ os ha da -- ña -- do
  has -- ta~a -- go -- ra, pe -- did vues -- tro re -- me -- dio, pe -- did
  vues -- tro re -- me -- dio a mi pas -- to -- ra;
}

basse_lyrics_iii = \lyricmode {
  \emph
  Pan di -- vi -- no, gra -- cio -- so, sa -- cro -- san -- to, man -- jar
  que da sus -- ten -- to~al al -- ma mí -- a; di -- cho -- so fue~a -- quel
  dí -- a, pun -- to~y ho -- ra, que~en ta -- les dos es -- pe -- cies,
  que~en ta -- les dos es -- pe -- cies Cris -- _ to mo -- ra; que, si~el
  al -- ma~es -- tá du -- ra, a -- quí se~a -- blan -- da -- rá con tal dul --
  zu -- ra, a -- quí __ se~a -- blan -- da -- rá con tal dul -- zu -- ra.
}

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\basse_music}
  \addlyrics {\basse_lyrics}
  \addlyrics {\basse_lyrics_ii}
  \addlyrics {\basse_lyrics_iii}
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

\version "2.26.0"

%% Référence : l'édition du Grupo Vocal « Solo Voces » (copie Fernando G.
%% Jácome), en fa. La saisie vient d'un MusicXML d'une autre édition, en sol :
%% transposé d'un ton vers le bas, il donne les mêmes notes et les mêmes
%% durées que le PDF. Ses points d'orgue de fin de phrase, que le PDF n'a pas,
%% ont été retirés.
%%
%% Quatre couplets sur la même musique, d'où la reprise.

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Por unos puertos arriba" }
  composer = "Antonio de Ribera"
  subsubtitle = "Cancionero de Palacio, nº 81"
  arranger = "Ed. : Grupo Vocal « Solo Voces »"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 2/2
  \tempo 2 = 66
  \key f \major
}

soprano_music = {
  \repeat volta 2 {
  % 1
  f4 f g2 | a bes | a4( f) g2 | f c'4 c |
  % 5
  d2 c | a4 a bes( a~ | a g) a2 | c4 c a2 |
  % 9
  f4 g2 f8( e) | d2 c | c'4 c d2 | c a4 bes |
  % 13
  g2 f |
  }
}

soprano_lyrics = \lyricmode {
  Por u -- nos puer -- tos a -- rri -- ba de mon -- ta -- ña muy es -- cu --
  ra, ca -- mi -- na -- ba~el ca -- ba -- lle -- ro las -- ti -- ma -- do de
  tris -- tu -- ra.
}

soprano_lyrics_ii = \lyricmode {
  El ca -- ba -- llo de -- ja __ muer -- to, y~el a pie por su ven -- tu --
  ra, an -- dan -- do de sie -- rra~en __ sie -- rra, de ca -- mi -- no no
  se cu -- ra.
}

soprano_lyrics_iii = \lyricmode {
  Hu -- yen -- do de las flo -- res -- tas, hu -- yen -- do de la fres --
  cu -- ra, mé -- te -- se de ma -- ta~en __ ma -- ta por la ma -- yor es --
  pe -- su -- ra.
}

soprano_lyrics_iv = \lyricmode {
  En sus lá -- gri -- mas ba -- ña -- do, más que mor -- tal su fi -- gu --
  ra su be -- ber y su co -- mer __ _ es de llo -- ro y~a -- mar -- gu --
  ra.
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
  \repeat volta 2 {
  % 1
  f4 f e2 | f f | f4 f2( e4) | f2 f4 f |
  % 5
  f2 f | f4 f f2( | d) d | f4 f f2 |
  % 9
  d4 d c c~( | c b) c2 | f4 f f2 | f f4 f |
  % 13
  f4( e) f2 |
  }
}

alto_lyrics = \lyricmode {
  Por u -- nos puer -- tos a -- rri -- ba de mon -- ta -- ña muy es -- cu --
  ra, ca -- mi -- na -- ba~el ca -- ba -- lle -- ro las -- ti -- ma -- do de
  tris -- tu -- ra.
}

alto_lyrics_ii = \lyricmode {
  El ca -- ba -- llo de -- ja muer -- to, y~el a pie por su ven -- tu -- ra,
  an -- dan -- do de sie -- rra~en sie -- rra, de ca -- mi -- no no se cu --
  ra.
}

alto_lyrics_iii = \lyricmode {
  Hu -- yen -- do de las flo -- res -- tas, hu -- yen -- do de la fres --
  cu -- ra, mé -- te -- se de ma -- ta~en ma -- ta por la ma -- yor es --
  pe -- su -- ra.
}

alto_lyrics_iv = \lyricmode {
  En sus lá -- gri -- mas ba -- ña -- do, más que mor -- tal su fi -- gu --
  ra su be -- ber y su co -- mer __ _ es de llo -- ro y~a -- mar -- gu --
  ra.
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

tenor_music = {
  \repeat volta 2 {
  % 1
  c'4 c c2 | c d | c c | c a4 a |
  % 5
  bes2 a | c4 c d( a | bes2) a | r c4 c |
  % 9
  bes4 bes g g | g2 g | a4 a bes2 | a c4 d |
  % 13
  c2 f, |
  }
}

tenor_lyrics = \lyricmode {
  Por u -- nos puer -- tos a -- rri -- ba de mon -- ta -- ña muy es -- cu --
  ra, ca -- mi -- na -- ba~el ca -- ba -- lle -- ro las -- ti -- ma -- do de
  tris -- tu -- ra.
}

tenor_lyrics_ii = \lyricmode {
  El ca -- ba -- llo de -- ja muer -- to, y~el a pie por su ven -- tu -- ra,
  an -- dan -- do de sie -- rra~en sie -- rra, de ca -- mi -- no no se cu --
  ra.
}

tenor_lyrics_iii = \lyricmode {
  Hu -- yen -- do de las flo -- res -- tas, hu -- yen -- do de la fres --
  cu -- ra, mé -- te -- se de ma -- ta~en ma -- ta por la ma -- yor es --
  pe -- su -- ra.
}

tenor_lyrics_iv = \lyricmode {
  En sus lá -- gri -- mas ba -- ña -- do, más que mor -- tal su fi -- gu --
  ra su be -- ber y su co -- mer __ _ es de llo -- ro y~a -- mar -- gu --
  ra.
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
  \addlyrics {\tenor_lyrics_ii}
  \addlyrics {\tenor_lyrics_iii}
  \addlyrics {\tenor_lyrics_iv}
>>

basse_music = {
  \repeat volta 2 {
  % 1
  f4 f c2 | f bes, | f' c | f f4 f |
  % 5
  bes,2 f' | f4 f bes,( f' | g2) d | f4 f f2 |
  % 9
  bes,2 c4 c | g'2 c, | f4 f bes,2 | f' f4 bes, |
  % 13
  c2 f |
  }
}

basse_lyrics = \lyricmode {
  Por u -- nos puer -- tos a -- rri -- ba de mon -- ta -- ña muy es -- cu --
  ra, ca -- mi -- na -- ba~el ca -- ba -- lle -- ro las -- ti -- ma -- do de
  tris -- tu -- ra.
}

basse_lyrics_ii = \lyricmode {
  El ca -- ba -- llo de -- ja muer -- to, y~el a pie por su ven -- tu -- ra,
  an -- dan -- do de sie -- rra~en sie -- rra, de ca -- mi -- no no se cu --
  ra.
}

basse_lyrics_iii = \lyricmode {
  Hu -- yen -- do de las flo -- res -- tas, hu -- yen -- do de la fres --
  cu -- ra, mé -- te -- se de ma -- ta~en ma -- ta por la ma -- yor es --
  pe -- su -- ra.
}

basse_lyrics_iv = \lyricmode {
  En sus lá -- gri -- mas ba -- ña -- do, más que mor -- tal su fi -- gu --
  ra su be -- ber y su co -- mer __ _ es de llo -- ro y~a -- mar -- gu --
  ra.
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

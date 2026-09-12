\version "2.22.0"

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Balderrama" }
  composer = "Gustavo Leguizamón (1917-2000)"
  poet = "Manuel J. Castilla (1918-1980)"
  arranger = "Versión coral : Alejandro Bregant"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 6/8
  \tempo 4. = 50
  \key b \minor
}

soprano_music = {
  r2 d'8 d8 | b4. r8 d8 d8 | b4. r8 d16 cis16 d16 dis16 | e8. d16 cis8 b8 a8 g8 |

  fis4. r8 a8 a8 | fis4. r8 a8 a8 | gis4. r8 a16 g16 a16 ais16 |

  b8. fis16 eis8 fis4 e8 | d4. r8 d'8 cis8 | b4 ais8 cis4 b8 | a4. a8 r8 a,8 |

  a8. cis16 e8 b'8 ais8 b8 | b8. fis16 fis8 fis4 r8 | fis8 b16 a16 g8 fis16 e16 d4 |

  cis2 r4 | R2. | R2. |

  d8. d8 e16 fis8. a8 gis16 | gis8. fis16 fis8 r8 g8 fis8 | gis8 b8 fis8 e8 fis4 |

  d4. r4. | R2. | r8. g16 g8 g8 g4 | r8. g16 g8 g8 g4 |

  r8. fis16 fis8 fis8 fis4 | fis8. b8 a16 g8. fis8 e16 | d8. cis16 cis8 r8 cis8 b8 |

  a8 fis'8 e8 d8 cis4 | d4. d4 r8 | d8. d8 e16 fis8. a8 gis16 |

  gis8. fis16 fis8 r8 gis8 fis8 | gis8 b8 fis8 e8 fis4 | d4. d8 r8 d'8 |

  d4 b4 r8 b8 | e4 b2 | a4 gis8 a8 b4 | fis2. |

  fis8. b8 a16 g8. fis8 e16 | d4 cis4 cis8 b8 | ais8 fis'8 e8 d8 cis4 |

  d4. d4 r8 | d8. d8 e16 fis8. a8 gis16 | gis8. fis16 fis8 r8 g8 fis8 |

  gis8 b8 fis8 e8 fis4 | d4. r8 d'8 d8 | gis,8 b8 fis8 fis8 d'4 | b2. |
}

soprano_lyrics = \lyricmode {
  Tra la la Tra la la la ra la ra lai la ra la ra la
  la Tra la la Tra la la la ra la ra
  lai la ra la la la A~o -- ri -- lli -- tas del ca -- nal _ cuan
  co -- che -- ro lo~a -- com -- pa -- _ ña, _ _ y~en ca -- da va -- so de vi --
  che,
  sa -- le can -- tan -- do la no -- che _ des -- de lo de Bal -- de -- rra --
  ma. Bal -- de -- rra -- ma. Bal -- de -- rra -- ma.
  Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que -- man -- do, _ de -- le
  chis -- pear, la gui -- ta -- rra. _ Y se~al -- bo -- ro -- ta que
  man -- do, _ de -- le chis -- pear, la gui -- ta -- rra. _ Lu --
  ce -- ro so -- li -- to, bro -- te del al -- ba,
  _ de~i -- re -- mos a pa -- rar _ si se~a -- pa -- ga Bal -- de -- rra --
  ma? _ ¿dón -- de~i -- re -- mos a pa -- rar _ _ si se~a --
  pa -- ga Bal -- de -- rra -- ma? Si~u -- no pa -- ga Bal -- de -- rra -- ma?
}

soprano = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
>>

contralto_music = {
  r2 b'8 b8 | fis4. r8 b8 b8 | g4. r8 b16 ais16 b16 bis16 | cis8. b16 a8 g8 fis8 e8 |

  d4. r8 fis8 fis8 | d4. r8 fis8 fis8 | e4. r8 fis16 eis16 fis16 e16 |

  d8. d16 cis8 d4 ais8 | b4. r4. | R2. | r4. r4 a8 |

  a8. cis16 e8 eis8 e8 fis8 | fis8. cis16 cis8 cis4 r8 | R2. |

  r2 cis8 b8 | ais8 fis'8 e8 d8 cis4 | b2. |

  b8. b8 cis16 d8. d8 d16 | d8. d16 d8 r8 e8 d8 | e8 e8 cis8 b8 ais4 |

  b4. r4. | R2. | r8. cis16 cis8 cis8 cis4 | r8. cis16 cis8 cis8 cis4 |

  r8. d16 d8 d8 d4 | fis8. b8 a16 g8. fis8 e16 | d8. cis16 cis8 r8 cis8 b8 |

  a8 fis'8 e8 d8 cis4 | b4. b4 r8 | d8. d8 cis16 d8. fis8 e16 |

  e8. d16 d8 r8 e8 d8 | e8 gis8 d8 cis8 cis4 | d4. d8 r4 |

  r4 a'8 a8 fis8 fis8 | gis4 g2 | e4 eis8 e8 eis4 | d2. |

  fis8. b8 a16 g8. fis8 e16 | d4 cis4 cis8 b8 | ais8 fis'8 e8 d8 cis4 |

  b4. b4 r8 | d8. d8 cis16 d8. fis8 e16 | e8. d16 d8 r8 e8 d8 |

  e8 gis8 d8 cis8 cis4 | d4. r8 b'8 b8 | e,8 gis8 d8 d8 e4 | d2. |
}

contralto_lyrics = \lyricmode {
  Tra la la Tra la la la ra la ra lai la ra la ra la
  la Tra la la Tra la la la ra la ra
  lai la ra la la la cuan
  co -- che -- ro lo~a -- com -- pa -- _ ña, _ _
  des -- de lo de Bal -- de -- rra -- ma.
  _ le can -- tan -- do la no -- che _ des -- de lo de Bal -- de -- rra --
  ma. Bal -- de -- rra -- ma. Bal -- de -- rra -- ma.
  Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que -- man -- do, _ de -- le
  chis -- pear, la gui -- ta -- rra. _ Y se~al -- bo -- ro -- ta que
  no -- che, _ llo -- ra por la ma -- dru -- ga -- da. _
  Lu -- ce -- ro so -- li -- to, bro -- te del al -- ba,
  _ de~i -- re -- mos a pa -- rar _ si se~a -- pa -- ga Bal -- de -- rra --
  ma? _ ¿dón -- de~i -- re -- mos a pa -- rar _ _ si se~a --
  pa -- ga Bal -- de -- rra -- ma? Si~u -- no pa -- ga Bal -- de -- rra -- ma?
}

contralto = \new Staff \with {instrumentName="Contralto"
  shortInstrumentName ="C."} <<
  \soprano_style
  \armure
  \relative c' {\contralto_music}
  \addlyrics {\contralto_lyrics}
>>

tenor_music = {
  r2. | r8 cis'16 d16 cis16 d16 b4. | r8 cis16 d16 cis16 d16 g,4. | r8 a16 b16 cis16 d16 e4 cis8 |

  d4. r4. | r8 cis16 d16 cis16 d16 a4. | r8 dis16 e16 d16 e16 b4. |

  b16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 | fis4. r8 fis'8 e8 | d4 cis8 e4 d8 | cis4. cis8 r4 |

  R2. | R2. | d8 d16 cis16 b8 d16 cis16 b4 |

  g2 r4 | fis8 d'8 cis8 b4 ais8 | b8 fis16 e16 d8 d16 cis16 d4 |

  b'8. b8 b16 b8. b8 b16 | b8. b16 b8 r4. | r4 fis8 fis8 d'4 |

  b4. r8 d8 cis8 | b4 ais8 cis4 b8 | a4. a8 r4 | R2. |

  r8. cis16 cis8 cis8 cis4 | b,8. b8 cis16 d8. e8 eis16 | fis8. fis16 fis8 r4. |

  R2. | fis8. a16 gis8 a8 a8 r8 | a8. a8 a16 a8. a8 a16 |

  a8. a16 a8 r8 b8 b8 | b8 b8 cis8 b8 ais4 | a4. a8 r4 |

  r4 fis'8 fis8 fis8 fis8 | e4 e2 | cis4 cis8 cis8 cis4 | cis4 b4 ais4 |

  d8. d8 cis16 b8. b8 b16 | b4 ais4 r4 | R2. |

  fis8. a16 gis8 a8 a8 r8 | a8. a8 a16 a8. a8 a16 | a4. r8 b8 b8 |

  b8 b8 cis8 b8 ais4 | a4. r8 r4 | b8 b8 cis8 b8 ais4 | a2. |
}

tenor_lyrics = \lyricmode {
  Pa ba da badam _ pa ba da badam _ la ra la ra lai la
  ra Pa ba da badam _ pa ba da badam _
  pa ba da ba da ba da ba da ba da ba dam A~o -- ri -- lli -- tas del ca -- nal _
  y~en ca -- da va -- so de vi --
  che la ra la la la la la ra lai la ra lai
  sa -- le can -- tan -- do la no -- che _ Bal -- de -- rra --
  ma. A -- den -- tro pu -- ro tem -- blor. _
  Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que -- man -- do, _
  ay, Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que
  no -- che, _ llo -- ra por la ma -- dru -- ga -- da. _
  Lu -- ce -- ro so -- li -- to, bro -- te del al -- ba, _ _
  _ de~i -- re -- mos a pa -- rar, _
  ay, Bal -- de -- rra -- ma, dón -- de~i -- re -- mos a pa -- rar si se~a --
  pa -- ga Bal -- de -- rra -- ma? pa -- ga Bal -- de -- rra -- ma?
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
>>

bajo_music = {
  r2. | b4 d4 fis4 | g4 b4 d4 | cis4 a4 cis,4 |

  d4 fis4 a4 | d,4 fis4 a4 | e4 gis4 b4 |

  b4 fis4 ais,4 | b4. r4. | R2. | a8. cis16 e8 g8 b8 a8 |

  a4. a,4. | d4 a8 d8. d16 cis8 | b4 d4 fis4 |

  e8. e16 fis8 g4 b8 | ais8 fis8 ais,8 b8 cis8 e8 | d4 b2 |

  b8. b8 cis16 d8. fis8 e16 | e8. d16 d8 r4. | b'8 gis8 fis8 fis8 e8 e8 |

  b4 b4 fis'8 e8 | d4 cis8 e4 d8 | cis4. cis8 r8 a8 | a8. cis16 e8 b'8 ais8 b8 |

  b4 fis2 | b,8. b8 cis16 d8. e8 eis16 | fis8. fis16 fis8 r4. |

  fis8 fis8 fis8 fis8 fis4 | b,4. b4 r8 | b8. b8 cis16 d8. fis8 e16 |

  e8. d16 d8 r8 e8 e8 | e8 e8 fis8 fis8 fis4 | b,4. b8 r4 |

  r4 b'8 b8 b8 b8 | e,4 e4 e8 e8 | a2 a,4 | d2. |

  b8. b8 cis16 d8. e8 eis16 | fis2 r4 | fis8 fis16 fis16 fis8 fis16 fis16 fis4 |

  b,4. b4 r8 | b8. b8 cis16 d8. fis8 e16 | e8. d16 d8 r8 e8 e8 |

  e8 e8 fis8 fis8 fis4 | b,4. r8 r4 | e8 e8 fis8 fis8 fis4 | b,2. |
}

bajo_lyrics = \lyricmode {
  Bom bom bom bom bom bom bom bom bom
  bom bom bom bom bom bom bom bom bom
  bom bom bom bom cuan -- do lle -- ga la ma
  ña -- na la la la la ra la la la
  sa -- le can -- tan -- do des -- de lo de Bal -- de -- rra -- ma,
  _ le can -- tan -- do la no -- che _ des -- de lo de Bal -- de --
  rra -- ma. A -- den -- tro pu -- ro tem -- blor. _ El bom -- bo con la ba -- gua --
  _ la. Y se~al -- bo -- ro -- ta que -- man -- do, _
  chis -- pear la gui -- ta -- rra. _ Y se~al -- bo -- ro -- ta que
  no -- che, _ llo -- ra por la ma -- dru -- ga -- da. _
  Lu -- ce -- ro so -- li -- to, bro -- te del al -- ba,
  _ de~i -- re -- mos a pa -- rar si se~a -- pa -- ga Bal -- de -- rra --
  ma? _ ¿dón -- de~i -- re -- mos a pa -- rar _ _ si se~a --
  pa -- ga Bal -- de -- rra -- ma? pa -- ga Bal -- de -- rra -- ma?
}

bajo = \new Staff \with {instrumentName="Bajo"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\bajo_music}
  \addlyrics {\bajo_lyrics}
>>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveEmptyStaves
      }
    }
    \new ChoirStaff
    <<
      \soprano
      \contralto
      \tenor
      \bajo
    >>
  }
  \score {
    \unfoldRepeats
    <<
      \soprano
      \contralto
      \tenor
      \bajo
    >>
    \midi {}
  }
}

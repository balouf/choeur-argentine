\version "2.26.0"

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
  \tempo 4. = 72
  \key b \minor
}

soprano_music = {
  r2 d'8 d8 | \bar "||" b4. r8 d8 d8 | b4. r8 d16 cis16 d16 dis16 | e8. d16 cis8 b8 a8 g8 |

  fis4. r8 a8 a8 | fis4. r8 a8 a8 | gis4. r8 a16 gis16 a16 ais16 |

  b8. fis16 eis8 fis4 e8 | d4. r8 d'8 cis8 | 
  \repeat volta 2 { b4 ais8 cis4 b8 | a4.~ a8 r8 a,8 |

  a8. cis16 e8 b'8 ais8 b8~ | b8. fis16~ fis8~ fis4 r8 | fis8[ b16 a16] g8[ fis16 e16] d4 |

  cis2 r4 | R2. | R2. |

  d8. d8 e16 fis8. a8 gis16 | gis8. fis16~ fis8 r8 gis8 fis8 | gis8 b8 fis8 e8 fis4 |

  d4. r4. | R2. | r8. g16 g8 g8 g4 | r8. g16 g8 g8 g4 |

  r8. fis16 fis8 fis8 fis4 | fis8. b8 a16 g8. fis8 e16 | d8. cis16~ cis8 r8 cis8 b8 |

  ais8 fis'8 e8 d8 cis4 | d4.~ d4 r8 | d8. d8 e16 fis8. a8 gis16 |

  gis8. fis16~ fis8 r8 gis8 fis8 | gis8 b8 fis8 e8 fis4 | d4.~ d8 r8 d'8 |

  d4 b4 r8 b8 | e4 b2 | a4 gis8 a8 b4 | fis2. |

  fis8. b8 a16 g8. fis8 e16 | d4( cis4) cis8 b8 | ais8 fis'8 e8 d8 cis4 |

  d4.~ d4 r8 | d8. d8 e16 fis8. a8 gis16 | gis8.( fis16~) fis8 r8 gis8 fis8 |

  
  \alternative {
    { gis8[ b8] fis8[ e8] fis4 | d4. r8 d'8 d8 | } 
    { gis,8[ b8] fis8[ fis8] d'4 | b2. | } 
  }
  } \fine
}

soprano_lyrics = \lyricmode {
  Tra la la Tra la la la ra la ra lai la ra la ra la
  la Tra la la Tra la la la ra la ra
  lai la ra la la la A~o -- ri -- lli -- tas del ca -- nal __ cuan
  do lle -- ga la ma -- ña -- na, __ sa -- le can -- tan -- do la no --
  che,
  sa -- le can -- tan -- do la no -- che __ des -- de lo de Bal -- de -- rra --
  ma. Bal -- de -- rra -- ma. Bal -- de -- rra -- ma.
  Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que -- man -- do, __ de -- le
  chis -- pear, la gui -- ta -- rra. __ Y se~al -- bo -- ro -- ta que
  man -- do, __ de -- le chis -- pear, la gui -- ta -- rra. __ Lu --
  ce -- ro so -- li -- to, bro -- te del al -- ba,
  ¿dón -- de~i -- re -- mos a pa -- rar __ si se~a -- pa -- ga Bal -- de -- rra --
  ma? __ ¿dón -- de~i -- re -- mos a pa -- rar __ si se~a --
  pa -- ga Bal -- de -- rra -- ma? Si~u -- no pa -- ga Bal -- de -- rra -- ma?
}

soprano_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ se po -- ne~a can -- tar, __ un
  co -- che -- ro lo~a -- com -- pa -- ña, __ y~en ca -- da va -- so de vi --
  no,
  y~en ca -- da va -- so de vi -- no __ tiem -- bla~el lu -- ce -- ro del al --
  ba. _ _ _ _ _ _ _ _
  _ _ _ _ Can -- ta por la me -- dia -- no -- che, __ llo -- ra
  por la ma -- dru -- ga -- da. __ Can -- ta por la me -- dia
  no -- che, __ llo -- ra por la ma -- dru -- ga -- da. __
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
  r2 b'8 b8 | \bar "||" fis4. r8 b8 b8 | g4. r8 b16 ais16 b16 bis16 | cis8. b16 a8 g8 fis8 e8 |

  d4. r8 fis8 fis8 | d4. r8 fis8 fis8 | e4. r8 fis16 eis16 fis16 e16 |

  d8. d16 cis8 d4 ais8 | b4. r4. | 
  \repeat volta 2 { R2. | r4. r4 a8 |

  a8. cis16 e8 eis8 eis8 fis8~ | fis8. cis16~ cis8~ cis4 r8 | R2. |

  r2 cis8 b8 | ais8 fis'8 e8[ d8] cis4 | b2. |

  b8. b8 cis16 d8. d8 d16 | d8. d16~ d8 r8 e8 d8 | e8 e8 cis8 b8 ais4 |

  b4. r4. | R2. | r8. cis16 cis8 cis8 cis4 | r8. cis16 cis8 cis8 cis4 |

  r8. d16 d8 d8 d4 | fis8. b8 a16 g8. fis8 e16 | d8. cis16~ cis8 r8 cis8 b8 |

  ais8 fis'8 e8 d8 cis4 | b4.~ b4 r8 | d8. d8 cis16 d8. fis8 e16 |

  e8. d16~ d8 r8 e8 d8 | e8 gis8 d8 cis8 cis4 | d4.~ d8 r4 |

  r4 a'8 a8 fis8 fis8 | gis4 gis2 | e4 eis8 e8 eis4 | d2. |

  fis8. b8 a16 g8. fis8 e16 | d4( cis4) cis8 b8 | ais8 fis'8 e8 d8 cis4 |

  b4.~ b4 r8 | d8. d8 cis16 d8. fis8 e16 | e8.( d16~) d8 r8 e8 d8 |

  
  \alternative {
    { e8[ gis8] d8[ cis8] cis4 | d4. r8 b'8 b8 | } 
    { e,8[ gis8] d8[ d8] e4 | d2. | } 
  }
  } \fine
}

alto_lyrics = \lyricmode {
  Tra la la Tra la la la ra la ra lai la ra la ra la
  la Tra la la Tra la la la ra la ra
  lai la ra la la la cuan
  do lle -- ga la ma -- ña -- na, __
  des -- de lo de Bal -- de -- rra -- ma.
  Sa -- le can -- tan -- do la no -- che __ des -- de lo de Bal -- de -- rra --
  ma. Bal -- de -- rra -- ma. Bal -- de -- rra -- ma.
  Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que -- man -- do, __ de -- le
  chis -- pear, la gui -- ta -- rra. __ Y se~al -- bo -- ro -- ta que
  man -- do, __ de -- le chis -- pear, la gui -- ta -- rra. __
  Lu -- ce -- ro so -- li -- to, bro -- te del al -- ba,
  ¿dón -- de~i -- re -- mos a pa -- rar __ si se~a -- pa -- ga Bal -- de -- rra --
  ma? __ ¿dón -- de~i -- re -- mos a pa -- rar __ si se~a --
  pa -- ga Bal -- de -- rra -- ma? Si~u -- no pa -- ga Bal -- de -- rra -- ma?
}

alto_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ un
  co -- che -- ro lo~a -- com -- pa -- ña, __
  tiem -- bla~el lu -- ce -- ro del al -- ba.
  Y~en ca -- da va -- so de vi -- no __ tiem -- bla~el lu -- ce -- ro del al --
  ba. _ _ _ _ _ _ _ _
  _ _ _ _ Can -- ta por la me -- dia -- no -- che, __ llo -- ra
  por la ma -- dru -- ga -- da. __ Can -- ta por la me -- dia
  no -- che, __ llo -- ra por la ma -- dru -- ga -- da. __
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \soprano_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
>>

tenor_music = {
  r2. | \bar "||" r8 cis'16 d16 cis16 d16 b4. | r8 cis16 d16 cis16 d16 g,4. | r8 a16 b16 cis16 d16 e4 cis8 |

  d4. r4. | r8 cis16 d16 cis16 d16 a4. | r8 dis16 e16 dis16 e16 b4. |

  b16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 fis16 | fis4. r8 fis'8 e8 | 
  \repeat volta 2 { d4 cis8 e4 d8 | cis4.~ cis8 r4 |

  R2. | R2. | d8[ d16 cis16] b8[ d16 cis16] b4 |

  g2 r4 | fis8 d'8 cis8 b4 ais8 | b8 fis16 e16 d8 d16 cis16 d4 |

  b'8. b8 b16 b8. b8 b16 | b8. b16~ b8 r4. | r4 fis8 fis8 d'4 |

  b4. r8 d8 cis8 | b4 ais8 cis4 b8 | a4.~ a8 r4 | R2. |

  r8. cis16 cis8 cis8 cis4 | b,8. b8 cis16 d8. e8 eis16 | fis8. fis16~ fis8 r4. |

  R2. | fis8. a16 gis8 a8 a8 r8 | a8. a8 a16 a8. a8 a16 |

  a8. a16~ a8 r8 b8 b8 | b8 b8 cis8 b8 ais4 | a4.~ a8 r4 |

  r4 fis'8 fis8 fis8 fis8 | e4 e2 | cis4 cis8 cis8 cis4 | cis4( b4 ais4) |

  d8. d8 cis16 b8. b8 b16 | b4( ais4) r4 | R2. |

  fis8. a16 gis8 a8 a8 r8 | a8. a8 a16 a8. a8 a16 | a4. r8 b8 b8 |

  
  \alternative {
    { b8[ b8] cis8[ b8] ais4 | a4. r8 r4 | } 
    { b8[ b8] cis8[ b8] ais4 | a2. | } 
  }
  }\fine
}

tenor_lyrics = \lyricmode {
  Pa ba da badam _ pa ba da badam _ la ra la ra lai la
  ra Pa ba da badam _ pa ba da badam _
  pa ba da ba da ba da ba da ba da ba dam A~o -- ri -- lli -- tas del ca -- nal __
  sa -- le can -- tan -- do la no --
  che la ra la la la la la ra lai la ra lai
  sa -- le can -- tan -- do la no -- che __ Bal -- de -- rra --
  ma. A -- den -- tro pu -- ro tem -- blor. __
  Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que -- man -- do, __
  ay, Bal -- de -- rra -- ma. Y se~al -- bo -- ro -- ta que
  man -- do, __ de -- le chis -- pear, la gui -- ta -- rra. __
  Lu -- ce -- ro so -- li -- to, bro -- te del al -- ba, __
  ¿dón -- de~i -- re -- mos a pa -- rar, __
  ay, Bal -- de -- rra -- ma, dón -- de~i -- re -- mos a pa -- rar si se~a --
  pa -- ga Bal -- de -- rra -- ma? pa -- ga Bal -- de -- rra -- ma?
}

tenor_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ se po -- ne~a can -- tar, __
  y~en ca -- da va -- so de vi --
  no, _ _ _ _ _ _ _ _ _ _ _ _
  y~en ca -- da va -- so de vi -- no __ ""  del al --
  ba. Zam -- ba del a -- ma -- ne -- cer. __
  "" _ _ _ Can -- ta por la me -- dia -- no -- che, __
  "" _ _ _ _ can -- ta por la me -- dia
  no -- che, __ llo -- ra por la ma -- dru -- ga -- da. __
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
  r2. | \bar "||" b4 d4 fis4 | g4 b4 d4 | cis4 a4 cis,4 |

  d4 fis4 a4 | d,4 fis4 a4 | e4 gis4 b4 |

  b4 fis4 ais,4 | b4. r4. | 
  \repeat volta 2 { R2. | a8. cis16 e8 g8 b8 a8 |

  a4. a,4. | d4 a8 d8. d16 cis8 | b4 d4 fis4 |

  e8. e16 fis8 g4 b8 | ais8[ fis8] ais,8[ b8] cis8 e8 | d4 b2 |

  b8. b8 cis16 d8. fis8 e16 | e8. d16~ d8 r4. | b'8 gis8 fis8 fis8 e8 e8 |

  b4 b4 fis'8 e8 | d4 cis8 e4 d8 | cis4.~ cis8 r8 a8 | a8. cis16 e8 b'8 ais8 b8~ |

  b4 fis2 | b,8. b8 cis16 d8. e8 eis16 | fis8. fis16~ fis8 r4. |

  fis8 fis8 fis8 fis8 fis4 | b,4.~ b4 r8 | b8. b8 cis16 d8. fis8 e16 |

  e8. d16~ d8 r8 e8 e8 | e8 e8 fis8 fis8 fis4 | b,4.~ b8 r4 |

  r4 b'8 b8 b8 b8 | e,4 e4 e8 e8 | a2 a,4 | d2. |

  b8. b8 cis16 d8. e8 eis16 | fis2 r4 | fis8 fis16 fis16 fis8 fis16 fis16 fis4 |

  b,4.~ b4 r8 | b8. b8 cis16 d8. fis8 e16 | e8.( d16)~ d8 r8 e8 e8 |

  
  \alternative {
    { e8[ e8] fis8[ fis8] fis4 | b,4. r8 r4 | } 
    { e8[ e8] fis8[ fis8] fis4 | b,2. | } 
  }
  }\fine
}

basse_lyrics = \lyricmode {
  Bom bom bom bom bom bom bom bom bom
  bom bom bom bom bom bom bom bom bom
  bom bom bom bom cuan -- do lle -- ga la ma
  ña -- na la la la la ra la la la
  sa -- le can -- tan -- do des -- de lo de Bal -- de -- rra -- ma,
  sa -- le can -- tan -- do la no -- che __ des -- de lo de Bal -- de --
  rra -- ma. A -- den -- tro pu -- ro tem -- blor. __ El bom -- bo con la ba -- gua --
  la. Y se~al -- bo -- ro -- ta que -- man -- do, __
  chis -- pear la gui -- ta -- rra. __ Y se~al -- bo -- ro -- ta que
  man -- do, __ de -- le chis -- pear, la gui -- ta -- rra. __
  Lu -- ce -- ro so -- li -- to, bro -- te del al -- ba,
  ¿dón -- de~i -- re -- mos a pa -- rar si se~a -- pa -- ga Bal -- de -- rra --
  ma? __ ¿dón -- de~i -- re -- mos a pa -- rar __ si se~a --
  pa -- ga Bal -- de -- rra -- ma? pa -- ga Bal -- de -- rra -- ma?
}

basse_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _
  _ _ _ _ un co -- che -- ro lo~a -- com
  pa -- ña _ _ _ _ _ _ _ _
  y~en ca -- da va -- so tiem -- bla~el lu -- ce -- ro del al -- ba.
  Y~en ca -- da va -- so de vi -- no __ tiem -- bla~el lu -- ce -- ro del
  al -- ba. Zam -- ba del a -- ma -- ne -- cer. __ A -- rru -- llo de Bal -- de -- rra --
  ma. Can -- ta por la me -- dia -- no -- che, __
  por la ma -- dru -- ga -- da. __ Can -- ta por la me -- dia
  no -- che, __ llo -- ra por la ma -- dru -- ga -- da. __
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
    \midi {}
  }
}

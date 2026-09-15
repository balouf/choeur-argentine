\version "2.26.0"

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Canción del jangadero" }
  composer = "Jaime Dávalos"
  arranger = "Harm. : D. Ubach"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 3/4
  \tempo "adagio"
  \key g \major
}

soprano_music = {
  r4 d8 e8 d4 | r4 e8 g8 e4 | r4 d8 e8 d4 | r4 e8 g8 e4 | r4 d8 e8 d4 | g2.\fermata^\dim |

  \break
  \repeat volta 2 {
    bes2.~\p\< | bes2. | b2.~ | b2.\f |}
    r4 d8 b8 d4 | r4 d8 b8 d4\fermata \bar "||" 

  r2 d,8 d8 | d'2.~ | d2. | b2. | r4 r4 g8^\mp g8 | bes2.~ |

  bes2. | g2. | r4 r4 g8 g8 | a4. a8 a8 a8 | a4. b8 a8 g8 | b2. |

  r4 r4 d8 d8 | e4. e8 d8 d8 | c4. c8 b8 b8 | a2 a4 | r4 r4 d,8 d8 | d'4. d8 c8 c8 |

  b4. b8 a8 a8 | g2 r4 | R2. |
  
  \repeat volta 2 {
  r2^\mp d'8 b8 | d8 d8~ d4 b8 g8 | b8 b8~ b4 g8 e8 |

  g8 g8~ g2 | r4 r4 e8 e8 | d4. d8 d8 d8 | d'4. d8 e8 e8 | b2. | r4 r4 d8 d8 |

  e4. e8 d8 d8 | c4. c8 b8 b8 | a2. | a4 r4 d,8 d8 | d'4. d8 c8 c8 | b4. b8 a8 a8 |

  g2. | R2. | R2. 
  }
  
  | r2 d8 d8 | d'2.~^\mp | d2. | b2. |

  b2 g8 g8 | bes2.~ | bes2. | g2. | e2.^\mp | fis2.\fermata | a2. | g2. | \duo { b2. \fermata} { g2. } \fine
}

soprano_lyrics = \lyricmode {
  Pa ra na Pa ra na Pa ra na Pa ra na Pa ra na Ah!
  Ah __ Ah __ Pa ra na Pa ra na
  Jan ga de __ ro jan ga de
  __ ro mi des -- ti -- no so -- re~el ri --  o~es de -- ri -- var
  des -- de~el fon -- do -- del o -- bra -- je ma -- de -- re -- ro con el a -- nhe -- lo del
  a -- gua que se va 
  Ri -- o~a -- ba -- jo __ voy lle van do __ la jan
  ga da __ ri -- o~a -- ba -- jo por el al -- to Pa -- ra -- na es el
  pe -- so de la som -- bra de -- rrum -- ba da que bus -- can -- do~el ho -- ri -- zon -- te ba -- ja --
  ra Jan ga de __ ro
  _ jan ga de __ ro na na Pa -- ra -- na!
}

soprano_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ Ri -- o~a -- ba -- jo __ ri -- o~a -- ba -- jo __ ri o~a
  ba -- jo __ a flor de~a -- gua va san -- gran -- do mi can -- ción es el
  sue -- ño de la vi -- da~y el tra -- ba -- jo que me vuel -- ve ca -- ma -- lo -- te~el co ra
  zón
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
  r4 d8 bes8 d4 | r4 e8 bes8 e4 | r4 d8 bes8 d4 | r4 e8 bes8 e4 | r4 d8 bes8 d4 | g2.\fermata^\dim |

  \repeat volta 2 {
  bes2.~\p\< | bes2. | g2.~ | g2.\f |} r4 b8 g8 b4 | r4 b8 g8 b4 \fermata \bar "||" \break

  r2 d,8 d8 | g2.~ | g2. | g2. | r4 r4 es8^\mp es8 | g2.~ |

  g2. | d2. | r4 r4 g8 g8 | e4. e8 e8 e8 | es4. es8 es8 es8 | d2. |

  r4 r4 d8 d8 | e4. e8 f8 e8 | gis4. f8 e8 d8 | c4 c4( d4 | e2) d8 d8 | fis4. g8 fis8 e8 |

  d4. e8 d8 c8 | b2 r4 | R2. | 
  
  \repeat volta 2 {
  r2^\mp b8 c8 | d8 d8~ d4 e8 d8 | e8 e8~ e4 g8 e8 |

  c8 c8~ c2 | r4 r4 e8 e8 | d4. d8 c8 d8 | d4. d8 e8 bes'8 | g2. | r4 r4 f8 f8 |

  e4. e8 f8 e8 | gis4. f8 e8 d8 | c2. | c4 r4 d8 d8 | fis4. g8 fis8 e8 | d4. e8 d8 c8 |

  b2. | R2. | R2. |
  }
  
  r2 d8 d8 | g2.~ | g2. | g2. |

  g2 es8 es8 | g2.~ | g2. | d2. | e2.^\mp | d2.\fermata | es2. | d2. | e2.\fermata \fine
}

alto_lyrics = \lyricmode {
  Pa -- ra -- na Pa -- ra -- na Pa -- ra -- na Pa -- ra -- na Pa -- ra -- na Ah!
  Ah __ Ah __ Pa -- ra -- na Pa -- ra -- na
  Jan -- ga -- de __ ro jan -- ga -- de
  __ ro mi des -- ti -- no so -- re~el ri -- o~es de -- ri -- var
  des -- de~el fon -- do -- del o -- bra -- je ma -- de -- re -- ro __ con el a -- nhe -- lo del
  a -- gua que se va 
  Ri -- o~a -- ba -- jo __ voy lle -- van do __ la jan
  ga da __ ri -- o~a -- ba -- jo por el al -- to Pa -- ra -- na es el
  pe -- so de la som -- bra de -- rrum -- ba -- da que bus -- can -- do~el ho -- ri zon -- te ba -- ja
  ra Jan -- ga de __ ro
  _ jan -- ga de __ ro na na Pa -- ra -- na!
}

alto_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ 
  Ri -- o~a -- ba -- jo __ ri -- o~a -- ba -- jo __ ri -- o~a
  ba -- jo __ a flor de~a -- gua va san -- gran -- do mi can -- ción es el
  sue -- ño de la vi -- da y~el tra -- ba -- jo que me vuel -- ve ca -- ma -- lo -- te~el co ra
  zón
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
  R2. | R2. | R2. | R2. | fis4 e4 d4 | f2.\fermata^\dim |

  \repeat volta 2 {
  g4\p-.   8-. 8-. 4-. | \*3 {g4-. 8-. 8-. 4-. |}}
  g2. | b2. |

  g2.-- | r4 d'8 b8 d4~ | d4 d8 b8 d4~ | d4 e8 b8 e4~ | e4 e8 b8 e4( | c4) c8 g8 c4~ |

  c4 c8 g8 c4 | d,4 g8 d8 g4 | d4 e8 d8 e4 | b'4 b4 b4 | a4 a4 a4 | g4 g8 d8 g4( |

  e2) r4 | b'4. b8 b8 c8 | d4. c8 b8 d8 | c4 a4( b4 | c4 b4 a4) | fis4. fis8 fis8 g8 |

  a4. g8 fis8 a8 | g4 b8 c8 b4( | g4) b8 c8 b4(\fermata |
  
  \repeat volta 2 {
  g2) r4 | g4 b4 g4 | e4 g4 e4 |

  c2 d4 | e4 fis4 g4 | a2 g4 | bes2 bes4 | b2.~ | b2. |

  gis2 f4 | e4 e4 d4 | c4 c4 e4 | a4 a4 g4 | fis2 e4 | d2 fis4 |

  g4 d'8 e8 d4( | b4) d8 e8 d4~ | d2. |
  }
  
  b2. | R2. | R2. | R2. |

  R2. | R2. | R2. | R2. |
  e,4\( <e g>\)\( <e g b>\) 2.\fermata <es g b> <d g b> g\fermata \fine
  
%  e,2. r4 g2 r4 b4 %{ À RELIRE mesure 60 : somme fausse %} | \duo { <b g>2. } { e,2. } | \duo { <b' g>2. } { e,2. } | \duo { <b' g>2. } { d,2. } | g2. |
}

tenor_lyrics = \lyricmode {
  Pa -- ra -- na Ah!
  Pam Pa ra na pam Pa ra na pam Pa ra na pam Pa ra na Pa ra
  na Pa -- ra -- na Pa -- ra -- na Pa ra na Pa ra -- na Pa -- ra -- na
  Pa ra na pam Pa -- ra -- na pam Pa -- ra -- na mi des -- ti -- no~es de -- ri -- var Pa -- ra -- na
  __ fon -- do -- del o -- bra -- je ma -- de -- re -- ro __ a -- nhe -- lo del
  a -- gua que se va que se va que se va __ Ri -- o a -- ba -- jo ri --
  o a -- ba -- jo el al -- to Pa -- ra -- na
  Pe -- so de la som -- bra de -- rrum -- ba -- da bus -- can -- do ba -- ja --
  ra ba -- ja -- rá __ ba -- ja -- rá Ah!
  na Pa -- ra -- na Pa -- ra -- na!
}

tenor_lyrics_ii = \lyricmode {
  _ _ _ _ 
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ 
  Ri -- o a -- ba -- jo ri --
  o a -- ba -- jo san -- gran -- do mi can -- ción
  Sue -- ño de la vi -- da y~el tra -- ba -- jo me vuel -- ve~el co -- ra --
  zón co -- ra -- zón __ co -- ra -- zón
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
  g2. | bes2. | g2. | bes2. | g2. | bes2.\fermata^\dim |

\repeat volta 2 {
  g4\p-. 8-. 8-. 4-. | 4-. 8-. 8-. 4-. \*2 {d'4-. 8-. 8-. 4-.}}
g,2. | g2. |

  d'2.-- | r4 b'8 g8 b4~ | b4 b8 g8 b4~ | b4 b8 g8 b4~ | b4 b8 g8 es4~ | es4 es8 c8 es4~ |

  es4 es8 c8 c4 | g4 d'8 b8 d4 | g,4 d'8 b8 d4 | e4 e4 e4 | es4 es4 es4 | d4 d8 b8 d4( |

  g,2.) | b4 e4 f4 | e4 e4 d4 | c4 c4 d4 | e4( fis4 g4) | fis2 e4 |

  d4 d4 c4 | b4 d8 e8 d4( | b4) d8 e8 d4(\fermata |
  
  \repeat volta 2 {
  g,2) r4 | g2. | b2. |

  a2 b4 | c4 d4 e4 | d2 d4 | c2 c4 | b4 g'4 e4 | d4 b4 a4 |

  gis2 b4 | d4 c4 b4 | a4 a4 b4 | c4 d4 e4 | d2 c4 | b2 a4 |

  g4 b8 c8 b4( | g4) b8 c8 b4~ | b2. | 
  }
  
  g2. | R2. | R2. | R2. |

  R2. | R2. | R2. | g4\( <g b>\)\( <g b d>\)~2. 2.\fermata 2. 2. g\fermata\fine
}

basse_lyrics = \lyricmode {
  Pa -- ra -- Pa -- ra -- Pa Ah!
  Pam Pa ra na pam Pa ra na Pam Pa ra na pam Pa ra na Pa ra
  na Pa -- ra -- na Pa -- ra -- na Pa ra na Pa ra -- na Pa -- ra -- na
  Pa -- ra -- na pam Pa -- ra -- na pam Pa -- ra -- na mi des -- ti -- no~es de -- ri -- var Pa -- ra -- na
  __ fon -- do -- del o -- bra -- je ma -- de -- re -- ro __ a -- nhe
  lo que se va que se va que se va __ Ri -- o~a
  ba -- jo~a -- ba -- jo el al -- to Pa -- ra -- na Pa -- ra -- na Es el
  pe -- so de la som -- bra de -- rrum -- ba -- da bus can -- do ba -- ja --
  rá ba -- ja -- rá __ ba -- ja -- rá Ah!
  Ah! Pa -- ra -- na Pa -- ra -- na!
}

basse_lyrics_ii = \lyricmode {
  _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ 
  Ri -- o~a
  ba -- jo~a -- ba -- jo san -- gran -- do mi can -- ción mi can  -- ción Es el
  sue -- ño de la vi -- da y~el tra -- ba -- jo me vuel -- ve~el co -- ra --
  zon co -- ra -- zón __ co -- ra -- zón
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

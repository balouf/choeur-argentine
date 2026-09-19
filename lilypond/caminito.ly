\version "2.26.0"

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Caminito del indio" }
  subtitle = "Canción andina a cuatro voces mixtas"
  composer = "Atahualpa Yupanqui"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 3/4
  \tempo "Moderato" 4 = 70
  \key e \major
}

soprano_music = \repeat segno 2 {
  gis'8^\p-> gis4 gis8 gis8 fis8 | gis8-> gis4 gis8 cis8 e8 | b4 b8 b8 cis8 b8 | gis2 r4 | r4 r8 b8( cis8 b8 | gis4. cis8 e8 cis8 |

  b8 gis8 fis8 e8 cis8 b8 | cis4.) r8 r4 | R2. | R2. | R2. | R2. |

  R2. | gis'4\(^\markup \nuance pp legato gis8 gis8 gis8 fis8 | gis4 gis8 gis8 gis8 gis8 | cis4 cis8 cis8 cis8 cis8 | b4 b2\) | b4 b8\( bis8 bis8 bis8\) |

  cis4 gis8\( gis8 gis8 gis8 | gis4 fis8 fis8 fis8 fis8 | gis4\) gis4 r4 | b4 b8 bis8 bis8 bis8 | cis4 gis8 gis8 gis8 gis8 |

  gis4 fis8 fis8 fis8 fis8 | gis4 gis4 r4 | R2. | R2. | R2. | R2. |

  R2. | R2. | R2. | R2. | R2. |

  b4\f b8\( bis8 bis8 bis8 | cis4 gis8 gis8 gis8 gis8 | gis4 fis8 fis8 fis8 fis8 | gis4 gis2\) | R2. |

  gis2(\mf fis4 | gis2) b4( | gis2\( fis4 | gis2)\) r4 | e2( dis4) |

  e4\( dis4 e4 | cis2 fis4 | e2\) b'4\f | b4. b8 b4 | b4 b4 cis4 | cis8 cis8 cis4 b4 |

  b4 b4 gis4 | gis4. gis8 gis4 | gis4 gis4 r8 gis8\p | gis4. gis8 gis4 | gis4 gis2 |
}

soprano_lyrics = \lyricmode {
  Du -- du, du -- du -- ru -- du -- du, du -- du -- ru -- du -- du, du -- du -- ru -- du. U __
  Ca -- mi -- ni -- to, del in -- dio, sen -- de ro co ya sem -- brao de pie -- dras, Ca -- mi -- ni -- to del
  in -- dio, que jun -- ta~el va -- lle con las es -- tre -- llas. Ca -- mi -- ni -- to del in -- dio, que jun -- ta~el
  va -- lle con las es -- tre -- llas.
  y~el ca -- mi -- ni -- to sa -- be cual es la cho -- la que~el in -- dio lla -- ma...
  U __ u __ u __
  _ _ _ _ _ _ El sol y la lu -- na y~es -- _ te can -- to
  mí -- o be -- ca -- ron tus pie -- dras, ca -- mi -- no del in -- dio...
}

soprano_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  Ca -- mi -- ni -- to que~an -- du vo de sur a nor te Mi ra -- za vie -- ja; An -- tes que~en la mon --
  ta -- ña la Pa -- cha -- ma -- ma se~en -- som -- bre -- cia -- ra. An -- tes que~en la mon -- ta -- ña la Pa -- cha
  ma -- ma se~en -- som -- bre -- cie -- ra.
  y~el ca -- mi -- no la -- men -- ta ser el cul -- pa -- ble de la dis -- ta -- cia.
}

soprano = \new Staff \with {instrumentName="Sopr."
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\soprano_music}
  \addlyrics {\soprano_lyrics}
  \addlyrics {\soprano_lyrics_ii}
>>

alto_music = \repeat segno 2 {
  e8^\p-> e4 e8 e8 dis8 | e8-> e4 e8 gis8 fis8 | e4 e8 e8 dis8 dis8 | cis2 r4 | 
  e4.-> e8-. dis4-> | cis4.-> e8-. dis4-> |

  cis2-> r4 | r4 r8 e8( fis4 | gis2 fis4 | e4.) e8( fis4 | gis2 fis4 | e4.) \breathe e4->^\> dis8 |

  e4.-> e4->\! dis8 | e4 r4 r4 | cis4 cis8 cis8 dis8 dis8 | e4 e2 | e4 e8 e8 fis8 fis8 | gis4 gis8 gis8 fis8 fis8 |

  e4 e8 e8 dis8 dis8 | cis4 dis8 dis8 bis8 bis8 | cis4 cis4 r4 | e4 e8 fis8 fis8 fis8 | e4 e8 e8 cis8 cis8 |

  cis4 cis8 cis8 bis8 bis8 | cis4 cis4 r4 | R2. | R2. | cis8( b8 cis4 e4 | gis2 b4) |

  gis2 fis8( gis8\( | b8 cis8 gis4 fis4 | e4)\) gis8 fis8\( e8 dis8 | cis8 b8 cis4 gis'4 | e2.\) |

  e4 e8\( fis8 fis8 fis8 | e4 e8 e8 d8 d8 | cis4 cis8 cis8 bis8 bis8 | cis4 cis2\) | R2. |

  e2 dis4 | e2 e4( | e2 dis4 | e2) r4 | cis2( bis4) |

  cis4\( b2 | cis2 bis4 | cis2\) r4 | gis'2(\mf fis4\( | e2 dis4 | e2 dis4)\) |

  e2 gis4 | e4. e8 dis4 | cis4 b4 r8 dis8\p | cis4. cis8 bis4 | cis4 cis2 |
}

alto_lyrics = \lyricmode {
  Du -- du, du -- du -- ru -- du -- du, du -- du -- ru -- du -- du, du -- du -- ru -- du. Du -- du -- du, du -- du -- du,
  du. U __ U __ Du -- du --
  du, du -- du -- du. Ca -- mi -- ni -- to del in -- dio, Ca -- mi --ni -- to del in -- dio que jun -- ta~el
  va -- llee con las es -- tre -- llas, con las es -- tre -- llas. Ca -- mi -- ni -- to del in -- dio que jun -- ta~el
  va -- lle con las es -- tre -- llas. U __
  _ u __ u _ _ _ _ _ _ _ _
  y~el ca -- mi -- ni -- to sa -- be cual es la cho -- la que~el in -- dio lla -- ma...
  _ _ _ u __ u __
  _ _ _ _ _ U __
  _ be -- ca -- ron tus pie -- dras, ca -- mi -- no del in -- dio...
}

alto_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _
  _ _ _ _ Ca -- mi -- ni -- to del in dio, Ca -- mi -- ni -- to que~an -- du vo, de sur a
  nor -- te, mi ra -- za vie -- ja, mi ra -- za vie -- ja An -- tes que~en la mon -- ta -- ña la Pa -- cha
  ma -- ma se~en -- som -- bre -- cie -- ra. _
  _ _ _ _ _ _ _ _ _ _ _
  y~el ca -- mi -- no la -- men -- ta ser el cul -- pa -- ble de la dis -- ta -- cia.
}

alto = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \soprano_style
  \armure
  \relative c' {\alto_music}
  \addlyrics {\alto_lyrics}
  \addlyrics {\alto_lyrics_ii}
>>

tenor_music = \repeat segno 2 {
  cis'4.^\p-> cis8 b4-> | cis4.-> cis8 b4-> | gis4.-> gis8-. fis4-> | e2-> r4 | gis4.-> gis8-. fis4-> | e4.-> gis8-. fis4-> |

  e2-> r4 | r4 r8 b'8( e4 | cis2 b4 | gis4.) b8( e4 | cis2 b4 | gis4.) \breathe  cis8^\> bis4-> |

  cis4.-> cis8\! bis4 | cis4-> r4 r4 | cis4 cis8 cis8 b8 b8 | a4 a8 a8 a8 a8 | gis4 gis4 r4 | e'4 e8 dis8 dis8 dis8 |

  cis4 gis8 gis8 fis8 fis8 | e4 e8 e8 dis8 dis8 | e4 e4 r4 | gis4 gis8 gis8 gis8 gis8 | gis4 gis8 gis8 e8 e8 |

  e4 e8 e8 dis8 dis8 | e4 e4 cis'8 b8\( | gis2 fis4 | cis2\) r4 | R2. | e'8( dis8 e4 fis4) |

  e2 r4 | e2( dis4 | cis4) e8 dis8 cis8\( b8 | gis4 cis4 dis4 | b4 cis4 b4\) |

  gis4 gis8\( gis8 gis8 gis8 | gis4 gis8 gis8 e8 e8 | e4 e8 e8 dis8 dis8 | e4 e2\) | r2 b'4\f |

  b4. b8 b4 | b4 b4 cis4 | cis4. cis8 b4 | b4 b4 r4 | R2. |

  R2. | R2. | R2. | b2(\mf a4\( | gis2 fis4 | gis2 fis4)\) |

  gis2 gis4 | cis4. cis8 b4 | a4 fis4 r8 fis8\p | e4. e8 fis4 | e4 e2 |
}

tenor_lyrics = \lyricmode {
  Du -- du -- du, du -- du -- du du -- du -- du -- du. Du -- du -- du, du -- du -- du,
  du. U __ U __ Du -- du --
  du, du -- du -- du. in -- dio,sen _ de -- ro co -- ya sem -- brao de pie -- dras. Ca mi ni -- to del
  in -- dio que jun -- ta~el va -- lle con las es -- tre -- llas. Ca -- mi -- ni -- to del in -- dio que jun -- ta~el
  va -- lle con las es -- tre -- llas. U _ _ _ _ U __
  _ u __ _ _ _ _ _ _ _ _ _ _
  y~el ca -- mi -- ni -- to sa -- be cual es la cho -- la que~el in -- dio lla -- ma... Can --
  ta -- do~en el ce -- rro, llo -- ran -- do~en el río -- o,
  U __
  _ be -- ca -- ron tus pie -- dras, ca -- mi -- no del in -- dio...
}

tenor_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _
  _ _ _ _ du -- vo, de sur a nor te, mi ra -- za vie -- ja. an -- tes que~en la mon --
  ta -- ña la Pa -- cha -- ma -- ma en~en -- som -- bre -- cie -- ra An -- tes que~en la mon -- ta -- ña la Pa -- cha
  ma -- ma se~en -- som -- bre -- cie -- ra. _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _
  y~el ca -- mi -- no la -- men -- ta ser el cul -- pa -- ble de la dis -- ta -- cia. _
}

tenor = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \soprano_style
  \armure
  \relative c' {\tenor_music}
  \addlyrics {\tenor_lyrics}
  \addlyrics {\tenor_lyrics_ii}
>>

basse_music = \repeat segno 2 {
  R2. | R2. | R2. | R2. | R2. | R2. |

  r2 <gis fis'>4 | <gis' cis,>2 <a b,>4 | \duo { b2^"(u)" gis4-> } { e4. fis8 gis4 } | <gis cis,>2 <a b,>4 | \duo { b2^"(u)" gis4-> } { e4. fis8 gis4 } | <gis cis,>2-> \breathe <gis, fis'>4^\> |

  <gis' cis,>2 <gis, fis'>4->\! | <gis' cis,>4-> r4 r4 | R2. | R2. | e2 b4 | e4. fis8 gis4 |

  cis,2 b4 | a4. a8 gis4 | cis4 cis4 r4 | e4 e8 dis8 dis8 dis8 | cis4 cis8 cis8 b8 b8 |

  a4 a8 a8 gis8 gis8 | cis4 cis4 r4 | R2. | gis'4^\p gis8\( gis8 gis8 fis8 | gis4 gis8 gis8 gis8 gis8 | cis4 cis8 cis8 cis8 cis8 |

  b4 b2\) | b4 b8 b8\( bis8 bis8\) | cis4 gis8 gis8 gis8 gis8 | gis4 fis8 fis8 fis8 fis8 | gis4 gis2 |

  e4 e8\( dis8 dis8 dis8 | cis4 cis8 cis8 b8 b8 | a4 a8 a8 gis8 gis8 | cis4 cis2\) | e8\mf fis8 gis4 fis4 |

  e2 b4 | e2 a,4( | a2\( b4 | e2)\) gis4 | gis4. gis8 gis4 |

  gis4 gis4 gis4 | gis4. gis8 gis4 | gis4 gis4 r4 | e2(\mf dis4 | cis2\( b4 | a2 b4)\) |

  e2 gis4 | gis4. gis8 fis4 | e4 dis4 r8 b8\p | a4. a8 gis4 | cis4 cis2 |
}

basse_lyrics = \lyricmode {
  Bom -- bom, bom -- bom,~bom. bom bom -- bom -- bom,~bom. bom bom. bom
  bom, bom -- bom. Ca -- mi -- ni -- to del
  in -- dio sem -- brao de pie -- dras. Ca -- mi -- ni -- to del in -- dio que jun -- ta~el
  va -- lle con las es -- tre -- llas. En la no -- che se -- rra -- na llo -- ra la que -- na su~hon -- da nos --
  tal -- gia, y~el ca -- mi -- ni -- to sa -- be cual es la cho -- la que~el in -- dio lla -- ma...
  y~el ca -- mi -- ni -- to sa -- be cual es la cho -- la que~el in -- dio lla -- ma... U _ _ _
  _ _ _ u __ se~a -- gran -- da la
  no -- che, la pe -- na del in -- dio... U __
  _ be -- ca -- ron tus pie -- dras, ca -- mi -- no del in -- dio...
}

basse_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _
  _ _ _ Ca -- mi -- ni -- to que~an --
  du -- vo, mi ra -- za vie -- ja An -- tes que~en la mon -- ta -- ña la Pa -- cha
  ma -- ma se~en -- som -- bre -- cie -- ra. Se le -- van -- ta~en el ce -- rro la voz do -- lien -- te de la va --
  gua -- da y~el ca -- mi -- no la -- men -- ta ser el cual -- pa -- ble de la dis -- ta -- cia.
  y~el ca -- mi -- no la -- men -- ta ser el cul -- pa -- ble de la dis -- ta -- cia. _ _ _ _
}

basse = \new Staff \with {instrumentName="Basse"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c {\basse_music}
  \addlyrics {\basse_lyrics}
  \addlyrics {\basse_lyrics_ii}
>>

pianoderecha_music = \repeat segno 2 {
  \duo { gis'8^\p gis4 gis8 gis8 fis8 } { e8 e4 e8 e8 dis8 } | \duo { gis8 gis4 gis8 cis8 e8 } { e,8 e4 e8 gis8 fis8 } | \duo { b4 b8 b8 cis8 b8 } { e,4 e8 e8 dis8 dis8 } | \duo { gis2 r4 } { cis,2 r4 } | \duo { r4 r8 b'8\( cis8 b8 } { e,4.-> e8-. dis4-> } | \duo { gis4. cis8 e8 cis8 } { cis,4.-> e8-. dis4-> } |

  \duo { b'8 gis8 fis8 e8 cis8 b8 } { cis2-> s4 } | \duo { cis4.\)} {s4.} e8\( fis4  | gis2 fis4 | e4.\) e8\( fis4 | gis2 fis4 | e4.\) \breathe e4 dis8 |

  e4. e4 dis8 |
  <gis e>4 gis8 8 8 fis |
  <gis cis,>4 8 8 <gis dis>8 8
  \duo { cis4 cis8 cis8 cis8 cis8 } { e,4 e2 } | 
  \duo { b'4 b2 } { e,4 e8 e8 fis8 fis8 } | 
  <gis b>4 8 <gis bis> <fis bis>8 8

  \duo { cis'4 gis8 gis8 gis8 gis8 } { e4 e8 e8 dis8 dis8 } | \duo { gis4 fis8 fis8 fis8 fis8 } { cis4 dis8 dis8 bis8 bis8 } | \duo { gis'4 gis4 r4 } { cis,4 cis4 r4 } | \duo { b'4 b8 bis8 bis8 bis8 } { e,4 e8 fis8 fis8 fis8 } | \duo { cis'4 gis8 gis8 gis8 gis8 } { e4 e8 e8 cis8 cis8 } |

  \duo { gis'4 fis8 fis8 fis8 fis8 } { cis4 cis8 cis8 bis8 bis8 } | \duo { gis'4 gis4 r4 } { cis,4 cis4 r4 } | R2. | R2. | cis8 b8 cis4 e4 | gis2 b4 |

  gis2 fis8 gis8 | b8 cis8 gis4 fis4 | 
  
  e4 gis8\( fis e dis | cis b cis4 gis' | e2.\) |
  
  \duo { b'4 b8 bis8 bis8 bis8 } { e,4 e8 fis8 fis8 fis8 } | \duo { cis'4 gis8 gis8 gis8 gis8 } { e4 e8 e8 d8 d8 } | \duo { gis4 fis8 fis8 fis8 fis8 } { cis4 cis8 cis8 bis8 bis8 } | \duo { gis'4 gis2 } { cis,4 cis2 } | R2. |

  \duo { gis'2 fis4 } { e2 dis4 } | \duo { gis2 b4 } { e,2 e4 } | \duo { gis2 fis4 } { e2 dis4 } | \duo { gis2 r4 } { e2 r4 } | \duo { e2 dis4 } { cis2 bis4 } |

  \duo { e4 dis4 e4 } { cis4 b2 } | \duo { cis2 fis4 } { cis2 bis4 } | \duo { e2 b'4\f } { cis,2 r4 } | \duo { b'4. b8 b4 } { gis2 fis4 } | \duo { b4 b4 cis4 } { e,2 dis4 } | \duo { cis'8 cis8 cis4 b4 } { e,2 dis4 } |

  \duo { b'4 b4 gis4 } { e2 gis4 } | \duo { gis4. gis8 gis4 } { e4. e8 dis4 } | \duo { gis4 gis4 r8 gis8\pp\pp } { cis,4 b4 r8 dis8\pp\pp } | \duo { gis4. gis8 gis4 } { cis,4. cis8 bis4 } | \duo { gis'4 gis2 } { cis,4 cis2 } |
}

pianoderecha = \new Staff <<
  \soprano_style
  \armure
  \relative c' {\pianoderecha_music}
>>

pianoizquierda_music = \repeat segno 2 {
  cis'4.^\p-> cis8 b4-> | cis4.-> cis8 b4-> | gis4.-> gis8-. fis4-> | e2-> r4 | gis4.-> gis8-. fis4-> | e4.-> gis8-. fis4-> |

  e2-> <fis gis,>4  | \duo { s4 r8 b8 e4 } { <gis, cis,>2 <a b,>4 } | \duo { cis2 b4 } { <b e,>4. <b fis>8 gis4-> } |
  
  \duo {gis4. b8 e4} {cis,2 <b a'>4} |
  %<gis cis,>2 gis2. b8 e4 <a, b,>4 %{ À RELIRE mesure 10 : somme fausse %} | \duo { cis2 b4 } { <b e,>4. <b fis>8 <gis gis>4 } | <gis cis,>2 gis2. cis8 bis8 <fis gis,>4 %{ À RELIRE mesure 12 : somme fausse %} |
  \duo { cis'2 b4 } { <b e,>4. <b fis>8 gis4-> }
  %cis'4. <gis cis,>2 cis8 bis8 <fis gis,>4 %{ À RELIRE mesure 13 : par espacement %} | \duo { cis'4 r4 r4 } { <gis cis,>4 r4 r4 } | cis4 cis8 cis8 b8 b8 | a4 a8 a8 a8 a8 | \duo { gis4 gis4 r4 } { e2 b4 } | e4. e'4 e16 dis8 fis,8 gis4 dis'16 dis8 %{ À RELIRE mesure 18 : par espacement %} |
  \duo {gis4. \breathe cis8 bis4->}{cis,2-> <fis gis,>4} |
  \duo {cis'4. 8 bis4} {<gis cis,>2 <fis gis,>4} | <gis cis cis,> r2 |
  cis4 8 8 b b a4 8 8 8 8 \duo {gis4 4} {e2} b4 |
  \duo {e'4 8 dis8 8 8} {e,4. fis8 gis4} |

  % 19 below
  \duo { cis4 gis8 gis8 fis8 fis8 } { cis2 b4 } | \duo { e4 e8 e8 dis8 dis8 } { a4. a8 gis4 } | \duo { e'4 e4} { cis4 cis4} r4 | \duo { gis'4 gis8 gis8 gis8 gis8 } { e4 e8 dis8 dis8 dis8 } | \duo { gis4 gis8 gis8 e8 e8 } { cis4 cis8 cis8 b8 b8 } |

  \duo { e4 e8 e8 dis8 dis8 } { a4 a8 a8 gis8 gis8 } | \duo { e'4 e4 cis'8 b8 } { cis,4 cis4 r4 } | gis'2 fis4 | 
  \duo  { gis4 gis8 gis8 gis8 fis8 } {cis2 s4} | 
  % \duo { cis2 r4 } { <gis' gis>8 gis8 gis8 r4 fis8 } | 
  gis'4 gis8 gis8 gis8 gis8 | \duo { e'8 dis8 e4 fis4 } { cis4 cis8 cis8 cis8 cis8 } |

  \duo { e2 r4 } { b4 b2 } | 
  \duo { e2 dis4 } { b4 b8 b8 bis8 bis8 } | 
  cis4 <e gis, >8 <dis gis,> <cis gis> <b gis>
  gis4 \duo {cis4 dis}{fis,8 8 8 8} |
  % cis4 cis4 e16 gis,8 dis'8 gis,8 cis16 gis8 b8 gis8 %{ À RELIRE mesure 32 : ambigu %} | 
  % gis4 gis8 cis4 fis,8 fis8 dis'4 fis,8 fis8 %{ À RELIRE mesure 33 : ambigu %} | 
  \duo { b4 cis4 b4 } { gis4 gis2 } |

  \duo { gis4 gis8 gis8 gis8 gis8 } { e4 e8 dis8 dis8 dis8 } | 
  \duo { gis4 gis8 gis8 e8 e8 } { cis4 cis8 cis8 b8 b8 } | 
  \duo { e4 e8 e8 dis8 dis8 } { a4 a8 a8 gis8 gis8 } | 
  \duo { e'4 e2 } { cis4 cis2 } |
  e8^\mf fis gis4 <fis b>^\f|
  \duo { b4.^\mf b8 b4 } { e,2 b4 } | 
  \duo { b'4 b4 cis4 } { e,2 a,4 } | \duo { cis'4. cis8 b4 } { a,2 b4 } | \duo { b'4 b4 r4 } { e,2 gis4 } | gis4. gis8 gis4 |

  gis4 gis4 gis4 | gis4. gis8 gis4 | gis4 gis4 r4 | \duo { b2 a4 } { e2 dis4 } | \duo { gis2 fis4 } { cis2 b4 } | \duo { gis'2 fis4 } { a,2 b4 } |

  \duo { gis'2 gis4 } { e2 gis4 } | \duo { cis4. cis8 b4 } { gis4. gis8 fis4 } | \duo { a4 fis4 r8 fis8 } { e4 dis4 r8 b8 } | \duo { e4. e8 fis4 } { a,4. a8 gis4 } | \duo { e'4 e2 } { cis4 cis2 } |
}

pianoizquierda = \new Staff <<
  \hommes_style
  \armure
  \relative c {\pianoizquierda_music}
>>

piano = \new PianoStaff \with {instrumentName="Piano"
  shortInstrumentName ="Pno."}
  <<
    \pianoderecha
    \pianoizquierda
  >>

#(set-global-staff-size conductor_size)
\book {
  \score {
    \layout {
      \context {
        \Staff
        \RemoveAllEmptyStaves
        % Le « D.C. » est un saut, gravé une seule fois pour toute la
        % partition — au-dessus de la seule portée du haut. Chaque exécutant
        % lit sa ligne et doit voir où il repart : descendre le graveur au
        % niveau de la portée le pose sur toutes, comme dans le candombe.
        \consists "Jump_engraver"
      }
      \context {
        \Score
        \remove "Jump_engraver"
      }
    }
    <<
      \new ChoirStaff <<
        \soprano
        \alto
        \tenor
        \basse
      >>
      \piano
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
      \piano
    >>
    \midi {}
  }
}

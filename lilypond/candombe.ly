\version "2.26.0"

#(set-default-paper-size "a4")

\header {
  title = \markup { \fontsize #5 \bold "Candombe del seis de enero" }
  composer = "Yabor — Abel Montenegro"
  arranger = "Arr. : Liliana Cangiano"
  tagline = ""
}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"

armure = {
  \accidentalStyle modern-cautionary
  \compressEmptyMeasures
  \time 4/4
  \tempo 4 = 108
  \key a \major
}

soprano_music = {
  \repeat segno 3 {

  \partial 8. a16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 |

  a8. gis16~ gis16 a16 b8~ b16 a8 gis16 fis8 e16 d16 | cis16 e8 d16~ d16 b16 a8 r4 cis8 e8 | a16 a8 a16~ a16 a16 a8 r4 r16 a,16 cis16 e16 |

  a16 a8 a16~ a16 a16 a8 r4 r16 a,16 cis16 e16 | cis'8. b16~ b16 cis16 d8~ d16 e8 e16 d8 cis16 b16 | a16 cis8 b16~ b16 gis16 a8 r2 |

  \volta 3 \fine
  \volta 1,2 {


  a16 a8 fis16 a8 fis16 a16~ a16 a8 fis16 a8 fis16 b16~ | b16 b8. r4 r2 | a16 a8 fis16 a8 fis16 a16~ a16 a8 fis16 a8 cis16 b16~ |

  b16 b8. r4 r2 | fis16 fis8 fis16~ fis16 fis8 fis16~ fis16 fis8 fis16 gis8 a16 gis16~ | gis16 fis8.~ fis2. |

  a16 a8 fis16 a a fis16 a16~ a8. f16 a8 a16 a16~ | a8. e16 r4 r2 | a16 a8 fis16 a8 fis16 a16~ a16 a8 fis16 a8 fis16 b16~ |

  b16 b8. r4 r2 | a16 a8 fis16 a8 fis16 a16~( a16 a8 fis16) a8 cis16 b16~ | b16 b8. r4 r2 |

  fis16 fis8 fis16~ fis16 fis8 fis16 fis16 fis8 fis16 gis8 a16 gis16~ | gis16 fis8.~ fis2. | a16 a8 fis16 a8 fis16 a16~ a16 a8 f16 a8 a16 a16~ |

  a8. e16 r4 r8 fis8 e8. d16 | cis4 r4 r2 | R1 |

  a'16 a8 b16 b16 cis16 b8~ b8 a8 b8 a16 cis16~ | cis4 r4 r2 | cis16 cis8 d16~ d16 e16 d8~ d4 cis4 |

  b16 a8 a16~ a16 fis16 a8~ a4 fis4 | e16 e8 a16~ a16 cis8 b16~ b8 a8 a8 b16 a16~ | a4 r4 r2 |

  cis16 cis8 d16~ d16 e16 d8~ d4 cis4 | b16 a8 a16~ a16 fis16 a8~ a4 fis4 | e16 e8 a16~ a16 cis8 b16~ b8 a8 a8 b16 a16~ | a4 r4 r4 r16 % clôture, écourtée de la levée
 
  }
  }
}

soprano_lyrics = \lyricmode {
  Pa ra pa pa rap __ pa pap Pa ra pa pa rap __ pa pap Pa ra pa
  pa rap __ pa pa __ rap pa pa pa ra ba rap pap __ pa pap Pap pap pa rap pap __ pa pap Pa ra pa
  pa rap pap __ pa pap Pa ra pa pa rap __ pa pa __ pap pa pa pa ra ba rap pap __ pa pap
  Es por to -- dos sa -- bi -- doque elseisde _ _ ene -- ro es el dí -- a de los __ _ _  re -- yes ma --
  gos y~en ho -- nor __ de~u -- no __ de~e llos, el más ne -- gro, __
  se pro -- gra -- ma u -- na fie -- sta en el bar -- rio. Es por to -- dos sa -- bi -- doque es el mas ne --
  gro el rey de los san -- tos __ can -- dom -- be -- ros,
  SanBal -- ta -- _ sar es unsan -- to _ muy a -- le -- gre, __ di -- ce la ma -- ma~I nés __ y mue -- ve los pies,
  es, Dom do -- ri -- do
  Con el mis -- _ mo rit -- mo~a pro fe sar __ Los ro -- jos __ co -- lo -- res,
  con fes -- tón __ do -- ra -- do, le gus tan __ al rey __ San Bal ta sar. __
  Los ro -- jos __ co -- lo -- res, con fes tón __ do -- ra -- do, le gus tan __ al rey __ San Bal ta sar. __
}

soprano_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  La co -- mu -- na convo -- _ ca y lo ve -- ne -- ra por la~es -- tre -- lla lu -- ce -- ro -- que~el cie -- lo~es -- pe -- ra, 
  San Bal -- ta -- sar~se~ha ma -- ca so -- bre las an -- das. __
  de~unmar _ de pro -- me san -- tesquecanta _ _ y bai -- la. Conversa _ el ron -- cobom -- _ bo mien -- tras a -- van -- za, 
  re -- pi -- can tam -- bo -- ri -- les~en~las com -- par -- sas,
  fies -- ta crio -- lla de ne -- _ gros y blanquea -- _ dos, __ cuan -- do  cam -- bian de to -- que cam -- bian -- de~es -- ta --
  do.
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
  \repeat segno 3 {

  \partial 8. a16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 |

  a8. gis16~ gis16 a16 b8~ b16 a8 gis16 fis8 e16 d16 | cis16 e8 d16~ d16 b16 a8 r4 cis8 e8 | a16 a8 gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 |

  a16 a8 gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 | a8. gis16~ gis16 a16 b8~ b16 a8 gis16 fis8 e16 d16 | cis16 e8 fis16~ fis16 d16 e8 r2 |

  \volta 3 \fine
  \volta 1,2 {


  cis8. cis16~ cis8 cis8~ cis8 e8 fis8 a8 | d,8. d16~ d8 d8~ d8 e8 d8 e8 | cis8. cis16~ cis8 cis8~ cis8 e8 fis8 a8 |

  d,8. d16~ d8 d8~ d8 e8 d8 e8 | cis2 cis2 | b8. cis16~ cis8 dis8~ dis2 |

  fis16 fis8 d16 fis fis d16 f16~ f8. d16 f8 f16 e16~ | e8. bis16( cis8) d8~ d8 fis8 e8. d16 | cis8. cis16~ cis8 cis8~ cis8 e8 fis8 a8 |

  d,8. d16~ d8 d8~ d8 e8 d8 e8 | cis8. cis16~ cis8 cis8~ cis8 e8 fis8 a8 | d,8. d16~ d8 d8~ d8 e8 d8 e8 |

  cis2 cis2( | b8. cis16~ cis8 dis8~) dis2 | fis16 fis8 d16 fis8 d16 f16~ f16 f8 d16 f8 f16 e16~ |

  e8. cis16~ cis8 d8~ d4 r4 | fis8 fis16 gis16~ gis16 a16 gis8~ gis4 cis,4 | fis8 fis16 gis16~ gis16 a16 gis8~ gis4 cis,4 |

  e16 e8 e16~ e16 e16 e8~ e8 e8 e8 fis16 a16~ | a4 r4 r16 e8 e16 e8 e8 | e16 e8 e16~ e16 e16 eis8~ eis4 gis4 |

  fis16 fis8 fis16~ fis16 cis16 dis8~ dis4 cis4 | cis16 cis8 e16~ e16 a8 fis16~ fis8 fis8 fis8 e16 a16~ | a16 fis16 e16 fis16 e8 cis16 e16~ e2 |

  e16 e8 e16~ e16 e16 eis8~ eis4 gis4 | fis16 fis8 fis16~ fis16 cis16 dis8~ dis4 cis4 | cis16 cis8 e16~ e16 a8 fis16~ fis8 fis8 fis8 e16 a16~ | a4 r4 r4 r16 % clôture, écourtée de la levée
 
  }
  }
}

alto_lyrics = \lyricmode {
  Pa ra pa pa rap __ pa pap Pa ra pa pa rap __ pa pap Pa ra pa
  pa rap __ pa pa __ rap pa pa pa ra ba rap pap __ pa pap Pap pap pa rap pap __ pa pap Pa ra pa
  pa rap pap __ pa pap Pa ra pa pa rap __ pa pa __ pap pa pa pa ra ba rap pap __ pa pap
  Dom dom __ dom __ di ro ri, dom dom __ dom __ di ro ri, dom dom __ dom __ di ro ri,
  dom dom __ dom __ di ro ri do ro dom dom __ do __
  se pro -- gra -- ma u -- na fie -- sta en el bar -- rio. __ Do __ domdo _ ri dom dom __ dom, __ di ro ri
  dom dom __ dom, __ di ro ri dom dom __ dom __ di ro ri dom dom __ dom __ di ro ri
  do ro __ di -- ce la ma -- ma~I nés __ y mue -- ve los pies,
  dom __ do, __ Lis -- tos co -- ra zo -- nes van con el __ can dom -- be
  Con el mis -- mo rit -- mo~a pro fe sar __ con el rit -- mo, Los ro -- jos __ co -- lo -- res,
  con fes -- tón __ do -- ra -- do, le gus tan __ al rey __ San Bal ta sar. __ pa ra pa pa pa pa __
  Los ro -- jos __ co -- lo -- res, con fes tón __ do -- _ do, le gus tan __ al rey __ San Bal ta sar. __
}

alto_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _
  de~unmar _ de pro -- me san -- tesquecanta _ _ y bai -- la _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ cuan -- do  cam -- bian de to -- que cam -- bian -- de~es -- ta
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
  \repeat segno 3 {

  \partial 8. a16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 |

  a8. gis16~ gis16 a16 b8~ b16 a8 gis16 fis8 e16 d16 | cis16 e8 d16~ d16 b16 a8 r4 cis8 e8 | a16 a8 e'16~ e16 d16 cis8 r4 r16 a,16 cis16 e16 |

  a16 a8 e'16~ e16 d16 cis8 r4 r16 a,16 cis16 e16 | e'8. e16~ e16 e16 e8~ e8 b8 b4 | a16 e'8 d16~ d16 b16 cis8 r2 |

  \volta 3 \fine
  \volta 1,2 {


  a8. e16~ e8 fis8~ fis8 a8 a4 | gis8. e16~ e8 fis8~ fis8 gis8 gis4 | a8. e16~ e8 fis8~ fis8 a8 a4 |

  gis8. e16~ e8 fis8~ fis8 gis8 gis4 | a2 a2 | a1 |

  a16 a8 a16 a a b16 c16~ c8. a16 c8 c16 cis16~ | cis8. a16~ a8 b4 d8 cis8.( b16) | a8. e16~ e8 fis4 a8 a4 |

  gis8. e16~ e8 fis8~ fis8 gis8 gis4 | a8. e16~ e8 fis8~ fis8 a8 a4 | gis8. e16~ e8 fis8~ fis8 gis8 gis4 |

  a2 a2( | a1) | a16 a8 a16 a8 b16 c16~ c16 c8 a16 c8 c16 cis16~ |

  cis8. a16~ a8 b8~ b4 r4 | a8 a16 b16~ b16 cis16 d8~ d4 cis8 b8 | a8 a16 b16~ b16 cis16 d8~ d4 cis8 b8 |

  cis8. a16~ a8 d8~ d8 d8 d8 d16 e16~ | e4 r4 r16 d8 d16 d8 d8 | a16 a8 a16~ a16 a16 b8 b4 d4 |

  cis16 cis8 cis16~ cis16 a16 c8~ c4 a4 | a8. cis16~ cis8 e8 r8 e8 e4 | r2 r16 d8 d16 d8 d8 |

  a16 a8 a16~ a16 a16 b8 b4 d4 | cis16 cis8 cis16~ cis16 a16 c8~ c4 a4 | a8. cis16 cis8 e8 r8 e8 e4 | r2 r4 r16 % clôture, écourtée de la levée
 
  }
  }
}

tenor_lyrics = \lyricmode {
  Pa ra pa pa rap __ pa pap Pa ra pa pa rap __ pa pap Pa ra pa
  pa rap __ pa pa __ rap pa pa pa ra ba rap pap __ pa pap Pap pap pa rap pap __ pa pap Pa ra pa
  pa rap pap __ pa pap Pa ra pa pa rap __ pa pa __ pap pa ba rap pap __ pa pap
  Dom dom __ dom __ dom do Dom dom __ dom __ domdo _ Dom dom __ dom __ dom do
  Dom dom __ dom __ dom do do ro do
  se pro -- gra -- ma u -- na fie -- sta en el bar -- rio. __ Do dom ri __ dom dom __ dom dom do,
  dom dom __ dom __ dom do, dom dom __ dom __ dom do, dom dom __ dom __ dom do,
  do ro __ di -- ce la ma -- ma~I nés __ y mue -- ve los pies,
  dom __ do __ Lis -- tos co -- ra zo -- nes se van con el __ can -- dom -- be y
  con el __ rit -- mo~a pro -- fe sar __ con el rit -- mo, Los ro -- jos __ co -- lo -- _ res,
  con fes -- tón __ do -- ra -- do, le gus -- tan al rey con el rit -- mo
  Los ro -- jos __ co -- lo -- _ res, con fes tón __ do -- _ do, le gus -- _ tan al rey
}

tenor_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _
  de~unmar _ de~pro -- me san -- tesquecanta _ _ y bai -- la _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ cuan -- do  cam -- bian de to -- que cam -- bian -- de~es -- ta
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
  \repeat segno 3 {

  \partial 8. a16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 | a8. gis16~ gis16 fis16 e8 r4 r16 a,16 cis16 e16 |

  a8. gis16~ gis16 a16 b8~ b16 a8 gis16 fis8 e16 d16 | cis16 e8 d16~ d16 b16 a8 r4 cis8 e8 | a16 a8 a16~ a16 a16 a8 r4 r16 a,16 cis16 e16 |

  a16 a8 a16~ a16 a16 a8 r4 r16 a,16 cis16 e16 | a8. a16~ a16 a16 e8~ e8 e8 e4 | a,16 a8 e'16~ e16 e16 a8 r2 |

  \volta 3 \fine
  \volta 1,2 {


  a,8. e'16~ e8 a,8~ a8 e'8 e4 | b8. e16~ e8 b8~ b8 e8 e4 | a,8. e'16~ e8 a,8~ a8 e'8 e4 |

  b8. e16~ e8 b8~ b8 e8 e4 | fis2 e2 | dis8. b16~ b8 fis'8~ fis8 b,8 b8. cis16 |

  d16 d8 d16 d d d16 d16~ d8. d16 d8 d16 e16~ | e8. e16~ e8 e8~ e2 | a,8. e'16~ e8 a,8~ a8 e'8 e4 |

  b8. e16~ e8 b8~ b8 e8 e4 | a,8. e'16~ e8 a,8~ a8 e'8 e4 | b8. e16~ e8 b8~ b8 e8 e4 |

  fis2 e2 | dis8. b16~ b8 fis'8~ fis8 b,8 b8. cis16 | d16 d8 d16 d8 d16 d16~ d16 d8 d16 d8 d16 e16~ |

  e8. e16~ e8 e8~ e4 e8 eis8 | fis8. cis16~ cis8 fis8~ fis8 eis8 gis4 | fis8. cis16~ cis8 fis8~ fis8 eis8 gis4 |

  a8. e16~ e8 b'8~ b8 e,8 e8 e16 a16~ | a16 fis16 e16 fis16 e8 cis16 e16~ e2 | a16 a8 gis16~ gis16 fis16 gis8~ gis4 e4 |

  fis16 fis8 a16~ a16 fis16 f8~ f4 a4 | e8. e16~ e8 e8 r8 <d' e,>8 <d e,>4 | r2 r16 e,8 e16 e8 e8 |

  a16 a8 gis16~ gis16 fis16 gis8~ gis4 e4 | fis16 fis8 a16~ a16 fis16 f8~ f4 a4 | e8. e16~ e8 e8 r8 e8 e4 | r2 r4 r16 % clôture, écourtée de la levée
 
  }
  }
}

basse_lyrics = \lyricmode {
  Pa ra pa pa rap __ pa pap Pa ra pa pa rap __ pa pap Pa ra pa
  pa rap __ pa pa __ rap pa pa pa ra ba rap pap __ pa pap Pap pap pa rap pap __ pa pap Pa ra pa
  pa rap pap __ pa pap Pa ra pa pa rap __ pa pa __ pap pa ba rap pap __ pa pap
  Dom dom __ dom __ dom do Dom dom __ dom __ dom do Dom dom __ dom __ dom do
  Dom dom __ dom __ dom do Do ro dom dom __ dom __ dom do ri
  se pro -- gra -- ma u -- na fie -- sta en el bar -- rio. __ Do __ dom dom __ dom __ dom do,
  dom dom __ dom __ dom do, dom dom __ dom __ dom do, dom dom __ dom __ dom do,
  do ro dom dom __ dom __ domdo _ ri di -- ce la ma -- ma~I -- nés __ y mue -- ve los pies,
  dom __ do, __ do ri dom dom __ dom __ dom do, dom dom __ dom __ dom do,
  con el __ rit -- mo~a pro -- fe sar __ pa ra pa pa pa pa __ Los ro -- jos __ co -- lo -- res,
  con fes -- tón __ do -- ra -- do, le gus -- tan al rey con el rit -- mo
  Los ro -- jos __ co -- lo -- res, con fes tón __ do -- ra -- do, le gus -- tan al rey
}

basse_lyrics_ii = \lyricmode {
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _
  de~un -- mar de pro -- me san -- te -- sque can -- ta~y bai -- la. _ _ _ _ _ _
  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  _ _ _ _ _ _ _ _ cuan -- do  cam -- bian de to -- que cam -- bian -- de~es -- ta
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
        % « Fine » et « D.C. al Fine » sont des sauts, gravés une seule fois
        % pour toute la partition — sous la basse. L'original les porte
        % au-dessus des quatre portées, et c'est ce qu'il faut : chaque
        % pupitre lit sa ligne et doit voir où il s'arrête.
        \consists "Jump_engraver"
      }
      \context {
        \Score
        \remove "Jump_engraver"
      }
      \context {
        \Lyrics
        % Ce qui déborde n'est pas la musique mais le texte : le second
        % couplet empile des mots que la couche texte rend d'un seul tenant
        % — « cuandocambian », « quecambiande », « blanquea » — et les
        % mesures 17 à 24 s'élargissent jusqu'à n'en plus tenir que deux par
        % système sous LilyPond 2.26, d'où une cinquième page. Un demi-cran
        % de corps sur les seules paroles suffit à revenir à quatre pages,
        % et laisse la portée à sa taille. Le vrai correctif est en amont,
        % dans le découpage des jetons fusionnés.
        \override LyricText.font-size = #-0.5
        \override LyricSpace.minimum-distance = #0.4
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

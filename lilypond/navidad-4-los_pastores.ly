% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Navidad Nuestra"
  subtitle = "4 - Los Pastores - Pas de Ah en 3e reprise (instrumental)"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 18
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 6/8
\tempo 4. = 72
\key e \major
}


sop_music = {
  e'4. d 
  \repeat volta 4 {
  c b r2. r4. r4 b8 4. r r2. \bar "||" \break
  <e, gis>8^"Tutti" <fis a> <gis b> <cis e> <b dis> <a cis>
  <gis b> e <cis' e> <b dis> <a cis> <cis e>
  <gis b> b, <gis' b> <fis a> b, <fis' a> <e gis>4. r r2. \break
  g8 a b a b c b d, d' c d, c' b d, b' a b, a' \bar "||"
  \alternative {
    \volta 1,3 {gis4 r8 r4. R2.*3 e'4. d}
    \volta 2 {b4 8 e8. fis16 e8 d4 a8 c8. d16 c8
              b4 fis8 a8. b16 a8 gis8. e16 gis8 fis8. d16 fis8 e4. r}
    \volta 4 {gis4 r8 r4. R2.*3
    r4 b8 e8. fis16 e8 d4 a8 c8. d16 c8 b4\fermata fis8 a8. b16 a8
    gis8. e 16 gis8 fis8. d16 fis8 e4. r \fine
  }
  }
}
}	


sop_lyrics = \lyricmode {
  Ah __ _ _ _ Ah __ _
  \set stanza = "1."
  "Ven" -- gan pas -- to -- res del
  cam -- po que~el Rey de los Re -- yes ha na -- ci -- do ya 
  Ven -- gan an -- tes que~a -- ma -- nez -- ca que ya~a -- pun -- ta~el
  di -- a~y la no -- che se va.
  Ah __ _
  var. Al -- baha -- ca~y ce -- dron to -- mi -- llo~y lau --
  rel, que~el Ni -- ño se duer -- me al a -- ma -- ne -- cer.
  par. Al -- baha -- ca~y ce -- dron to -- mi -- llo~y lau --
  rel, que~el Ni -- ño se duer -- me al a -- ma -- ne -- cer.
}

sop_lyrics_b = \lyricmode {
"" "" "" "" "" "" 
  \set stanza = "2."
"Lle" -- guen de Pin -- chas y Chu -- quis, de~A -- min -- gay San
Pe -- dro, de~A -- rau -- coy Po -- man an -- tes que na -- die lea --
do -- re que -- si -- llos y flo -- res le va -- mo'a lle -- var.
}

sop_lyrics_c = \lyricmode {
"" "" "" "" "" "" 
  \set stanza = "3."
"Pin" -- dan -- lea Ju -- lio Ro -- me -- ro ca -- ba -- llos de
pa -- soy su mu -- la dean -- dar.
Con ca -- jas y con gui -- tar -- ras i -- re -- mos can -- tan -- do 
por el o -- li -- var.
}

sop_lyrics_d = \lyricmode {
"" "" "" "" "" "" 
  \set stanza = "4."
"Ay" na -- vi -- dad de~Ai -- mo -- gas -- ta, a -- lo -- jay a --
ña -- pa noha -- bra de fal -- tar.
mien -- tras la lu -- na rio -- ja -- na se mue -- re de
ga -- nas de par -- ti -- ci -- par.
}


sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
  \addlyrics {\sop_lyrics_b}
  \addlyrics {\sop_lyrics_c}
  \addlyrics {\sop_lyrics_d}
>>


alt_music = {
  r2. 
  \repeat volta 4 {
  r a'4. g f e4 d8 e4. r r2.
  R2.*5 e8 fis g fis g a g d b' a d, a' g d g fis b, fis'
  \alternative {
  \volta 1,3 {e4 r8 r4. R2.*4}
   \volta 2 {<e gis>4 b'8 <g b>8. <a d>16 <g c>8
             <fis a>4 a8 <e g>8. <fis a>16 <e g>8
             <dis fis>4 fis8 <e a>8. <e b'>16 <e a>8
             e8. b16 e8 d8. a16 d8 b4. r}
  \volta 4 {e4 r8 r4. R2.*3
  r4 b'8 <g b>8. <a d>16 <g c>8
             <fis a>4 a8 <e g>8. <fis a>16 <e g>8
             <dis fis>4\fermata fis8 <e a>8. <e b'>16 <e a>8
             e8. b16 e8 d8. a16 d8 b4. r\fine}
  }
  }
}

alt_lyrics = \lyricmode {
  Ah __ _ _ _ _ _
}

alt_lyrics_b = \lyricmode {
  ""
}


alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
  \addlyrics {\alt_lyrics_b}
>>

ten_music = {
   e'4. d
   \repeat volta 4 {
   c b r2. r4. r4 a8 gis4. r r2. \bar "||" \break
   R2.*5 e'2. d~d4. b
   \alternative {
   \volta 1,3 {b4\breathe b,8 e8. fis16 e8
   d4 g8 c8. d16 c8 b4 r8 r4. r2. e4. d
   }
   \volta 2 {b4 r8 r4.
             r2.
             r4 dis8 cis8. dis16 cis8
             b8. gis16 b8 a8. fis16 a8 gis4. r}
   \volta 4 {b4\breathe b,8 e8. fis16 e8
   d4 g8 c8. d16 c8 b4 r8 r4. r2. 
   R2.*2
   r4 dis8 cis8. dis16 cis8 b8. gis16 b8 a8. fis16 a8 gis4. r\fine}
   }
}
}

ten_lyrics = \lyricmode {
  Ah __ _ _ _ Ah __ _
  Ven __ _ _   gan!
  Al -- baha -- ca~y ce -- dron to -- mi llo~y lau -- rel,
  Ah __ _ Guen!
  que~el Ni -- ño se duer -- me al a -- ma -- ne -- cer.
  na!
  Al -- baha -- ca~y ce -- dron to -- mi -- llo~y lau --
  rel, que~el Ni -- ño se duer -- me al a -- ma -- ne -- cer.

}

ten_lyrics_b = \lyricmode {
  "" "" "" "" "" "" 
  Lle __ _ _ guen!
}

ten_lyrics_c = \lyricmode {
  "" "" "" "" "" "" 
  Pi __ _ _ dan!
}

ten_lyrics_d = \lyricmode {
  "" "" "" "" "" "" 
  Ay __ _ _ na!
}


ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \alto_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
  \addlyrics {\ten_lyrics_b}
  \addlyrics {\ten_lyrics_c}
  \addlyrics {\ten_lyrics_d}
>>


bass_music = {
r2. 
\repeat volta 4 {
r a4. g f e4 b8 e4. r r2.
R2.*8
\alternative {
\volta 1,3 {R2.*2 r4 e8 a8. b16 a8
gis8. e16 gis8 fis8. d16 fis8 e4 r8 r4.}
\volta 2 {R2.*5}
\volta 4 {R2.*2 r4 e8 a8. b16 a8
gis8. e16 gis8 fis8. d16 fis8 e4 r8 r4. R2.
%r4 e8 a8. b16 a8
%gis8. e16 
r2. r4 b8 8. 16 8 e4 r8 r4.\fine}
}
}
}

bass_lyrics = \lyricmode {
  Ah __ _ _ _ _ _
  que~el Ni -- ño se duer -- me al a -- ma -- ne -- cer.
  que~el Ni -- ño se duer -- me al a -- ma -- ne -- cer.
  % que~el Ni -- ño se duer -- me 
  al a -- ma -- ne -- cer.
}

bass_lyrics_b = \lyricmode {
  ""  
}


bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
  \addlyrics {\bass_lyrics_b}  
>>


\include "utils/booksq.ly"

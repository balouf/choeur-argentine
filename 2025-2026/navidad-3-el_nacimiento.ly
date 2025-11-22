% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Navidad Nuestra"
  subtitle = "3 - El Nacimiento"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 18
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 3/4
\tempo 4 = 108
\key g \major
}


sop_music = {
\repeat volta 2 {
  b'4.\p 8 c4 d2 g,4 <g g'>4. <g e'>8 <a g'>4 <b d>2.
  c4. d8 c4 b2 4 g4. 8 b4 a2.\> \breathe
  b4.\pp 8 c4 d2 g,4 
  <<{
        \voiceOne
        g4.\< 8 g'4 g2.\mp e4. d8 c4
      }
      \new Voice {
        \voiceTwo
        f,4 4 4 g2 f4 a4. b8 c4
      }
    >>
    \oneVoice
    b2 g4 4.\> 8 a4\! g2.\fermata
}
<fis' a>4.\mp <a, d>8 4 <b d>2 <g b>4 <gis b> <a c> <b d> <c e>2.\>
fis,4.\p g8 a4 b2 4 b\< <b cis> <b d> <b e>2(\mf <d, a'>4)\>\fermata 
\bar "||"
b'4.\p 8 c4 d2 g, 4 <e' g>4. <c e>8 <e g>4 <b d>2.
c4. d8 c4 b2 4 g4. 8 b4 a2. b4.\cresc 8 c4 d2 g,4 
  <<{
        \voiceOne
        g4. 8 g'4 g2.\>\fermata
      }
      \new Voice {
        \voiceTwo
        f,4 4 a g2( f4)\fermata
      }
    >>
    \oneVoice
e'4.\mf d8 c4 b2 g4 4. 8 a4 g2.~\p g \fine
}
	


sop_lyrics = \lyricmode {
    No -- che~a -- nun -- cia -- da,
    no -- che de~a -- mor.
    Dios ha na -- ci -- do, pé -- ta -- lo~y flor.
    To -- de~es si -- len -- cio~y se -- re -- ni --  dad. 
    Pas a los hom -- bres, es Na -- vi -- dad.
    
    An -- ge -- les can -- ten so -- bre~el por -- tal,
    Dios ha na -- ci -- do, es Na -- vi -- dad! __ 
    Es -- ta~es la no -- che que pro -- me -- tió
    Dios a los hom -- bres y ya lle -- gó.
    Es no -- che bue -- na, no~hay que dor -- mir.
    Dios ha na -- ci -- do,
    Dios es -- tá~a qui! __
}

sop_lyrics_b = \lyricmode {
  En -- el pe -- se -- bre
  mi Re -- den -- tor
  es men -- sa -- jer -- o
  de paz y~a -- mor.
  
  Cuan -- do son -- ri -- e
  se~ha -- ce la luz
  y~en sus bra -- ci -- tos cre -- ce~u -- na cruz.
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
  \addlyrics {\sop_lyrics_b}
>>


alt_music = {
  \repeat volta 2 {
g'2\p d4 g2. e4. 8 4 g2.d2 4 2 dis4 d4. 8 cis4 e2(\> d4) \breathe
g2\pp d4 g2. f4\< 4 4\! e2(\mp f4) e4. d8 c4 g'2 4 g4.\> 8 e4\! g2( d4)\fermata
  }
d'4.\mp fis,8 4 g2 d4 fis e e b'(\> a g) 
dis4.\p e8 fis4 g( a) b g\< g g g2(\mf c,4)\>\fermata \bar "||" g'2\p fis4 g2. 4. e8 g4 2.
<e g>2 4 <e a>2 <e g>4 r e e <e g>2( <e fis>4)
g2\cresc fis4 g2. f4 4 4 e2(\> a4)\fermata e4.\mf d8 c4 d2 cis4 c4. 8 e4 4.\p\> d8 c4 b2.\! \fine
}

alt_lyrics = \lyricmode {
Uh __ _ _ no -- che de~a -- mor.
Uh __ _ _ _ pé -- ta -- lo~y flor. __
Uh __ _ _ se -- re -- ni --  dad. __
    Pas a los hom -- bres, es Na -- vi -- dad.
    
    An -- ge -- les can -- ten so -- bre~el por -- tal, __
    Dios ha na -- ci -- do, es Na -- vi -- dad! __ 
    Uh __ _ _ _ _ _ _
    Oh __ _ _ _ y lle -- gó.
    Es no -- che, no~hay que dor -- mir. __
    Dios ha na -- ci -- do,
    Dios es -- tá Dios es -- tá~a qui!
}

alt_lyrics_b = \lyricmode {
Uh __ _ _  mi Re -- den -- tor
Uh __ _ _ _ de paz y~a -- mor.
Uh __ _ _ se~ha -- ce la luz __
  y~en sus bra -- ci -- tos cre -- ce~u -- na cruz.
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
\repeat volta 2 {
d'2\p fis4 d2. c4. 8 4 d2. fis,2 4 g2 a4 b4. 8 4 g2(\> fis4) \breathe
d'2\pp fis4 d2. c4\< 4 b e(\mp c gis) a4. gis8 a4 b2 cis4 c4.\> a8 c4\! b2.\fermata
}
R2.*4
a4\p g fis dis'( e) fis e\< e d cis2(\mf fis,4)\>\fermata
\bar "||"
d'2\p 4 2. c2 a4 g2. a2 4 b2 4 r cis cis c2. d2\cresc 4 2. c4 c b g2(\> gis4)\fermata
a4.\mf gis8 a4 b2 bes4 a4. 8 fis4 g4.\p\> fis8 e4 d2.\! \fine
}

ten_lyrics = \lyricmode {
Uh __ _ _ no -- che de~a -- mor.
Uh __ _ _ _ pé -- ta -- lo~y flor. __
Uh __ _ _ se -- re -- ni --  dad. __
    Pas a los hom -- bres, es Na -- vi -- dad.
    Dios ha na -- ci -- do, es Na -- vi -- dad! __ 
    Uh __ _ _ _ _ _
    Oh __ _ _ _
y lle -- gó.
    Es no -- che, no~hay que dor -- mir. __
    Dios ha na -- ci -- do,
    Dios es -- tá Dios es -- tá~a qui!
    
}

ten_lyrics_b = \lyricmode {
Uh __ _ _  mi Re -- den -- tor
Uh __ _ _ _ de paz y~a -- mor.
Uh __ _ _ se~ha -- ce la luz __
  y~en sus bra -- ci -- tos cre -- ce~u -- na cruz.
}


ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \alto_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
  \addlyrics {\ten_lyrics_b}
>>


bass_music = {
  \repeat volta 2 {
g,2 a4 b2. c4. g'8 c,4 b2. a2 4 g2 fis'4 e4. 8 a,4 d2.\> \breathe
g,2\pp a4 b2. g'4\< 4 4 2(\mp e4) c4. b8 c4 d2 es4 d2\> 4\! g, 2.\fermata
  }
  R2.*4
b2\p 4  e2 4 e'\< cis b a2(\mf d,4)\>\fermata \bar "||"
g,2\p a4 b2. c2 4 d2. d2 4 2 4 4.-> 8-> 4-> 2. g,2\cresc a4 b2. g'4 4 4 2(\> e4)\fermata
c4.\mf b8 c4 d2 es4 d2 4 g,2.~ g \fine
}

bass_lyrics = \lyricmode {
Uh __ _ _ no -- che de~a -- mor.
Uh __ _ _ _ pé -- ta -- lo~y flor. __
Uh __ _ _ se -- re -- ni --  dad. __
    Pas a los hom -- bres, Na -- vi -- dad. Dios na -- ci -- do, es Na -- vi -- dad! __ 
    Uh __ _ _ _ _ _
    Oh __ _ _ _
    
   y ya lle -- gó.
    Es no -- che, no~hay que dor -- mir. __
    Dios ha na -- ci -- do,
    Dios a qui! __
}

bass_lyrics_b = \lyricmode {
Uh __ _ _  mi Re -- den -- tor
Uh __ _ _ _ de paz y~a -- mor.
Uh __ _ _ se~ha -- ce la luz __
  y~en sus bra -- ci -- tos u -- na cruz.
  
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

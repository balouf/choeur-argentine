% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = \markup { \fontsize #5 \bold "Hanacpachap Cussicuinin"}
  subtitle = ""
  composer = "Anónimo"
  tagline = ""

}

conductor_size = 17
individual_size = 20

\include "utils/macros.ly"


armure = {
\accidentalStyle modern-cautionary
\compressEmptyMeasures
\time 4/4
\tempo 4 = 112
\key d \minor
}

intro = {}

sop_music = {
  \intro
  \repeat volta 2 {
    d2. 4 f f g g a2 2
    d2. 4 c c bes bes a2 2
    r4 a8 8 c2~4 bes a a g1 fis
    r4 f8 8 2~4 4 g a~a g a2
    r4 a8 8 2~4 f g g e2 d
    r bes'2~4 a g2~(2 fis4 e) fis1
%    \alternative {
%      {r bes'2~4 a g2~(2 fis4 e) fis1
%      \bar "||" R1*2}
%      {r2 bes2~4 a g2~(^"rall." 2 fis4 e) fis1\fermata \fine}
%    }
  }
 }


sop_lyrics = \lyricmode {
  Ha -- nac -- pa -- chap cu -- ssi -- cui -- nin
  Hua -- ran ca -- cta mu -- chas cai -- qui
  Yu pai ru -- ru -- pu -- coc mall -- qui
  ru -- na cu -- nap su -- ya -- cui -- nin
  call pan nac -- pa que -- mi cui -- nin,
  Huac __ ias -- cai -- ta.
  
  Su -- sur -- hua -- na
}

sop_lyricsb = \lyricmode { \emph
  U -- ya -- ri -- huai mu -- chas -- cai -- ta
  Dios -- pa ram -- pan Dios -- pa ma -- man
  Yu -- ra -- toc -- to ha -- man -- cai -- man
  Yu pas ca -- lla, coll -- pas -- cai -- ta
  Hua huar qui __ man su -- yus -- cai -- ta
  Ri -- cu -- chi -- llai.
}

sop_lyricsc = \lyricmode {
  Chip -- chij -- ca -- chac ca -- ta -- chi -- llai
  Pun -- chau pus -- sac que -- an tu -- pa
  Cam hua -- cy -- ac -- pac, ma -- nau -- pa
  Que -- çai -- quic -- ta ha -- mui -- ñi -- llai
  Pi -- ñas -- cai -- ta ques -- pi chi -- llai
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \armure
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
  \addlyrics {\sop_lyricsb}
  % \addlyrics {\sop_lyricsc}
>>

alt_music = {
  \intro
  \repeat volta 2 {
    d2. 4 4 4 c c f2 2
    f2. 4 4 4 g g f2 2
    r4 f8 8 e2~4 g d2~4 c8( bes) c2 d1
    r4 d8 8 2~4 4 e e d2 cis
    r4 f8 8 2~4 f e d~4 cis d2
    r d2 1 1 1
%    \alternative {
%      {r d2 1 1 1
%      \bar "||" R1*2}
%      {r2 d2 1 1 1\fermata \fine}
%    }
  }
}

alt_lyrics = \lyricmode {
  Ha -- nac -- pa -- chap cu -- ssi -- cui -- nin
  Hua -- ran ca -- cta mu -- chas cai -- qui
  Yu pai ru -- ru -- pu -- coc mall -- qui
  ru -- na cu -- nap su -- ya -- cui -- nin
  call pan nac -- pa que -- mi cui -- nin,
  Huac ias -- cai -- ta.

  Su -- sur -- hua -- na
}

alt_lyricsb = \lyricmode { \emph
  U -- ya -- ri -- huai mu -- chas -- cai -- ta
  Dios -- pa ram -- pan Dios -- pa ma -- man
  Yu -- ra -- toc -- to ha -- man -- cai -- man
  Yu pas ca -- lla, coll -- pas -- cai -- ta
  Hua huar qui __ man su -- yus -- cai -- ta
  Ri -- cu -- chi -- llai.
}

alt_lyricsc = \lyricmode {
  Chip -- chij -- ca -- chac ca -- ta -- chi -- llai
  Pun -- chau pus -- sac que -- an tu -- pa
  Cam hua -- cy -- ac -- pac, ma -- nau -- pa
  Que -- çai -- quic -- ta ha -- mui -- ñi -- llai
  Pi -- ñas -- cai -- ta ques -- pi chi -- llai
}


alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \armure
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
  \addlyrics {\alt_lyricsb}
  %\addlyrics {\alt_lyricsc}
>>

ten_music = {
  \intro
  \repeat volta 2 {
    a'2. bes4 a a g g c2 2
    bes2. 4 f f bes bes d2 2
    r4 a8 8 g4 e g g a2~( 2 g) a1
    r4 8 8 2~4 4 4 4~4 d, a'2
    r4 c8 8 2~4 d a bes a2 2
    r g g2.( a4) bes2( a4 g) a1
%    \alternative {
%      {r g g2.( a4) bes2( a4 g) a1 \bar "||" R1*2}
%      {r2 g g2.( a4) bes2( a4 g) a1\fermata \fine}
%    }
  }
}

ten_lyrics = \lyricmode {
  Ha -- nac -- pa -- chap cu -- ssi -- cui -- nin
  Hua -- ran ca -- cta mu -- chas cai -- qui
  Yu pai ru -- ru -- pu -- coc mall -- qui
  ru -- na cu -- nap su -- ya -- cui -- nin
  call pan nac -- pa que -- mi cui -- nin,
  Huac ias -- cai -- ta.

  Su -- sur -- hua -- na
}

ten_lyricsb = \lyricmode { \emph 
  U -- ya -- ri -- huai mu -- chas -- cai -- ta
  Dios -- pa ram -- pan Dios -- pa ma -- man
  Yu -- ra -- toc -- to ha -- man -- cai -- man
  Yu pas ca -- lla, coll -- pas -- cai -- ta
  Hua huar qui __ man su -- yus -- cai -- ta
  Ri -- cu -- chi -- llai.
}

ten_lyricsc = \lyricmode {
  Chip -- chij -- ca -- chac ca -- ta -- chi -- llai
  Pun -- chau pus -- sac que -- an tu -- pa
  Cam hua -- cy -- ac -- pac, ma -- nau -- pa
  Que -- çai -- quic -- ta ha -- mui -- ñi -- llai
  Pi -- ñas -- cai -- ta ques -- pi chi -- llai
}


ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \alto_style
  \armure
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
  \addlyrics {\ten_lyricsb}
  %\addlyrics {\ten_lyricsc}
>>


bass_music = {
  \intro
  \repeat volta 2 {
    d,2. g,4 d' d e e f2 2
    bes,2. 4 a a g g d'2 2
    r4 f8 8 c2~4 g d' d es1 d
    r4 8 8 2~4 4 c a bes2 a
    r4 f'8 8 2~4 d g, g a2 d
    r2 g,2~4 a bes( c) d1~1
%    \alternative {
%      {r2 g,2~4 a bes( c) d1~1
%      \bar "||" R1*2}
%      {r2 g,2~4 a bes( c) d1~1\fermata \fine}
%    }
  }
}

bass_lyrics = \lyricmode {
  Ha -- nac -- pa -- chap cu -- ssi -- cui -- nin
  Hua -- ran ca -- cta mu -- chas cai -- qui
  Yu pai ru -- ru -- pu -- coc mall -- qui
  ru -- na cu -- nap su -- ya -- cui -- nin
  call pan nac -- pa que -- mi cui -- nin,
  Huac ias -- cai -- ta.

  Su -- sur -- hua -- na
}

bass_lyricsb = \lyricmode {\emph
  U -- ya -- ri -- huai mu -- chas -- cai -- ta
  Dios -- pa ram -- pan Dios -- pa ma -- man
  Yu -- ra -- toc -- to ha -- man -- cai -- man
  Yu pas ca -- lla, coll -- pas -- cai -- ta
  Hua huar qui __ man su -- yus -- cai -- ta
  Ri -- cu -- chi -- llai.
}

bass_lyricsc = \lyricmode {
  Chip -- chij -- ca -- chac ca -- ta -- chi -- llai
  Pun -- chau pus -- sac que -- an tu -- pa
  Cam hua -- cy -- ac -- pac, ma -- nau -- pa
  Que -- çai -- quic -- ta ha -- mui -- ñi -- llai
  Pi -- ñas -- cai -- ta ques -- pi chi -- llai
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \armure
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
  \addlyrics {\bass_lyricsb}
  % \addlyrics {\bass_lyricsc}
>>

%\include "utils/booksq.ly"

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
%    \new StaffGroup
%    <<
      \sop
      \alt
      \ten
      \bass
%    >>
    >>

  }
  \score {
    \unfoldRepeats
    <<
%      \lead
      \sop
      \alt
      \ten
      \bass
    >>
    \midi {}
  }
}


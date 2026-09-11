\version "2.22.0"
\include "utils/AccordsJazzDefs.ly"


#(set-global-staff-size 24)
#(set-default-paper-size "a4")


\paper { indent = 0\cm} 

\header {
	title = "Burrito"
	composer = ""
	tagline = "" 
}


%%%%%%%%%%%%%%%%%%%
% ThÃ¨me
%%%%%%%%%%%%%%%%%%%

staffViolon = \new Staff
{
	\clef treble
	\time 2/2
	\tempo 2 = 96
	\key g \major

\relative c' {
  \repeat volta 3 {
  r4 r8 g' 8 4 4 4 4 4 4
  c4. 8 4 4 a a g a8 b~8 g4
  
  g8 4 4 4 4 4 4
  c4. 8 4 4 a a g a8 b~8 g4 r8
  
  g4 4 2 4 4 2 b4 b a a g fis8 g~4 r
  g4 4 2 4 4 2 b4 b a a g fis8 g~4 r r2
  }
  
  b4 8 8~8 8 a a g4 4~2
  b4 8 8~8 8 a a g4 r
  a a a a a g fis fis a a a g fis e8 d~2 r

  b'4 8 8~8 8 a a g4 4~2
  b4 8 8~8 8 a a g4 r
  g g g g g g b g d b' a g fis a g r r2
\fine
}
}


%%%%%%%%%%%%%%%%%%%%%%%
% Grille
%%%%%%%%%%%%%%%%%%%%%%%

accords = {
	\chords {
  \repeat volta 3 {
  s1 g a:m d:7 g s 
  a:m d:7 g s s
  d:7 g s s d:7 g
  }
  s2. d4:7 g1 s2. d4:7
  g1:7 a:m d:7 a:7 d:7 
  g2. d4:7 g1 s2. d4:7
  g1 s s d:7 g
	}
}

theme = \staffViolon

lyricsa = \lyricmode{
  Con mi bu -- rri -- to sa -- ba -- ne -- ro 
  voy ca -- mi -- no de Be -- le -- én 
  Con mi bu -- rri -- to sa -- ba -- ne -- ro
  voy ca -- mi -- no de Be -- le -- én 
  
  Si me ven, si me ven 
  voy ca -- mi -- no de Be -- lén __
  Si me ven, si me ven 
  voy ca -- mi -- no de Be -- lén __
  
  Tu -- qui tu -- qui tu -- qui tu -- qui __
    Tu -- qui tu -- qui tu -- qui ta
    
  A -- pú -- ra -- te mi bu -- rri -- to
  que ya va -- mos a lle -- gar __

  Tu -- qui tu -- qui tu -- qui tu -- qui __
    Tu -- qui tu -- qui tu -- qui ta

  A -- pú -- ra -- te mi bu -- rri -- to
  va -- mos a ver a Je -- sús
}

lyricsb = \lyricmode{
  En mi bu -- rri -- to voy can -- tan -- do
  En mi bu -- rri -- to va tro -- tando
  En mi bu -- rri -- to voy can -- tan -- do
  En mi bu -- rri -- to va tro -- tando
}

lyricsc = \lyricmode{
  Con mi cua -- tri -- co voy can -- tan -- do
  En mi bu -- rri -- to va tro -- tando
  Con mi cua -- tri -- co voy can -- tan -- do
  En mi bu -- rri -- to va tro -- tando
}


\book {
%  \bookOutputSuffix #(string-append suffix "Ut")
	\header{
	instrument = "(version Ut)"
	}
\score {
	<<
	\accords
	\theme
	\addlyrics {\lyricsa}
	\addlyrics {\lyricsb}
	\addlyrics {\lyricsc}
	>>

  \layout {
\context {
      \Score
      \override SpacingSpanner.common-shortest-duration = #(ly:make-moment 1 2)
    }
  }
}
   \score {
    \unfoldRepeats
    <<
      \accords
      \theme
    >>
    \midi {}
  }

}
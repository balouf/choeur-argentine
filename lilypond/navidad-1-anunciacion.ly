% Created on Mon Sep 20 15:23:38 CEST 2010
\version "2.22.0"

#(set-default-paper-size "a4")

% \paper { indent = 0\cm}

\header {
  title = "Navidad Nuestra"
  subtitle = "1 - La Anunciacion"
  composer = "Ariel Ramirez"
  tagline = ""

}

conductor_size = 15
individual_size = 20

\include "utils/macros.ly"


%%%%%%%%%%%%%%%%%
% Gloria
%%%%%%%%%%%%%%%%%

gloria = {
\compressEmptyMeasures
\time 6/8
\tempo 4. = 84
\key d \major
}

lead_music = {
\partial 4 r4
R2.*16
r4. r4 a'8
\repeat volta 2 {
g b a a fis g~ g e'4~4 8}
\fine
}

lead_lyrics = \lyricmode {
  Ji -- ne -- ted -- s~un ra -- yo ro -- jo
}

lead = \new Staff \with {
  instrumentName="Lead"
  shortInstrumentName = "L."} <<
  \soprano_style
  \gloria
  \relative c' {\lead_music}
  \addlyrics {\lead_lyrics}
>>


sop_music = {
\partial 4 r4
R2.*16
r4. r4 a'8
\repeat volta 2 {
g b a a fis g~ g e'4~4 8}
\fine
}


sop_lyrics = \lyricmode {
  Ji -- ne -- te -- de~un ra -- yo ro -- jo __
}

sop = \new Staff \with {instrumentName="Soprano"
  shortInstrumentName ="S."} <<
  \soprano_style
  \gloria
  \relative c' {\sop_music}
  \addlyrics {\sop_lyrics}
>>


alt_music = {
\partial 4 r4
R2.*16
r4. r4 a'8
\repeat volta 2 {
g b a a fis g~ g e'4~4 8}
\fine
}

alt_lyrics = \lyricmode {
  Ji -- ne -- te d -- s~un ra -- yo ro -- jo
}

alt = \new Staff \with {instrumentName="Alto"
  shortInstrumentName ="A."} <<
  \alto_style
  \gloria
  \relative c' {\alt_music}
  \addlyrics {\alt_lyrics}
>>


ten_music = {
\partial 4 r4
R2.*16
r4. r4 a'8
\repeat volta 2 {
g b a a fis g~ g e'4~4 8}
\fine
}

ten_lyrics = \lyricmode {
  Ji -- ne -- ted -- s~un ra -- yo ro -- jo
}

ten = \new Staff \with {instrumentName="Tenor"
  shortInstrumentName ="T."} <<
  \tenor_style
  \gloria
  \relative c' {\ten_music}
  \addlyrics {\ten_lyrics}
>>


bass_music = {
\partial 4 r4
R2.*16
r4. r4 a8
\repeat volta 2 {
g b a a fis g~ g e'4~4 8}
\fine
}

bass_lyrics = \lyricmode {
  Ji -- ne -- ted -- s~un ra -- yo ro -- jo
}

bass = \new Staff \with {instrumentName="Bass"
  shortInstrumentName ="B."} <<
  \hommes_style
  \gloria
  \relative c' {\bass_music}
  \addlyrics {\bass_lyrics}
>>


\include "utils/booksmisa.ly"

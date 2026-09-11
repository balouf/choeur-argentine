
% Deux voix indépendantes sur une même portée : pupitre divisé, polyrythmie.
%
%   \duo { <bes' d>4 4 <g c>2 } { f2. e4 }
%
% développe exactement l'écriture manuelle
%
%   <<{\voiceOne <bes' d>4 4 <g c>2 } \new Voice {\voiceTwo f2. e4 }>> \oneVoice
%
% — gravure identique au pixel près et MIDI identique à l'octet, y compris à
% l'intérieur d'un \relative, où les deux voix partent de la même note de
% référence et la suite reprend celle de la voix du haut. La voix du bas
% accepte les silences invisibles (s1*2) pour sauter les mesures qu'elle ne
% chante pas.
duo =
#(define-music-function (haut bas) (ly:music? ly:music?)
   #{
     << { \voiceOne #haut } \new Voice { \voiceTwo #bas } >> \oneVoice
   #})

emph = {
  \override Lyrics.LyricText.font-shape = #'italic
  % \override Lyrics.LyricText.font-series = #'bold
}

normal = {
  \revert Lyrics.LyricText.font-shape
  % \revert Lyrics.LyricText.font-series
}

pe = \markup {\dynamic p \italic espressivo}
pl = \markup {\dynamic p \italic legato}
spl = \markup {\italic subito \dynamic p \italic legato}
pll = \markup {\dynamic p \italic legatissimo}
mpe = \markup {\dynamic mp \italic espressivo}
mfa = \markup {\dynamic mf \italic articolato}
mfll = \markup {\dynamic mf \italic legatissimo}
fa = \markup {\dynamic f \italic articolato}
fam = \markup {\dynamic f \italic ampio}
fs = \markup {\dynamic f \italic sostenuto}
ffp = \markup {\dynamic ff \italic pesante}


soprano_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef treble
  \accidentalStyle modern-cautionary

}


alto_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef treble
  \accidentalStyle modern-cautionary

}

tenor_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef treble
  \accidentalStyle modern-cautionary

}


hommes_style = {
  \set Staff.midiInstrument = "trumpet"
  \set Staff.midiMinimumVolume = #0.7
  \set Staff.midiMaximumVolume = #0.9
  \clef bass
  \accidentalStyle modern-cautionary

}

lpiano_syle = {
\set Staff.midiInstrument = "acoustic grand"
\set Staff.midiMinimumVolume = #0.5
\set Staff.midiMaximumVolume = #0.7
\clef bass
\accidentalStyle modern-cautionary
}

rpiano_syle = {
\set Staff.midiInstrument = "acoustic grand"
\set Staff.midiMinimumVolume = #0.5
\set Staff.midiMaximumVolume = #0.7
\clef treble
\accidentalStyle modern-cautionary
}

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

% Une nuance suivie de son intention : l'intensité dans la fonte des nuances,
% l'intention en italique à sa droite.
%
%   c4^\markup \nuance p legato
%   c4_\markup \nuance ff pesante
%   c4-\markup \nuance f "molto sostenuto"
%
% Les deux arguments sont des markups, donc les mots nus passent sans
% guillemets — y compris `f`, qui est aussi un nom de note. C'est la raison
% pour laquelle c'est une **commande de markup** et non une fonction
% d'événement : `c4^\nuance f legato` ferait lire `f` comme une hauteur et
% échouerait, quand `^\markup \nuance f legato` lit ses arguments en mode
% markup, où `f` n'est qu'un mot. Le `\markup` coûte huit caractères et
% supprime un piège qui ne se déclenche que sur certaines nuances.
%
% Et comme ça rend un markup, ça se compose — ce qui couvre le cas où un
% terme précède la nuance :
%
%   c4^\markup { \italic subito \nuance p legato }
%
% Remplace douze variables (`pe`, `pl`, `ppl`, `spl`, `pll`, `mpe`, `mfa`,
% `mfll`, `fa`, `fam`, `fs`, `ffp`) dont chaque combinaison nouvelle
% demandait sa propre déclaration, et dont certaines portaient un nom qui
% ment : `ffp` se lit « fortissimo puis subito piano » pour un musicien.
#(define-markup-command (nuance layout props intensite intention)
   (markup? markup?)
   (interpret-markup layout props
     #{ \markup { \dynamic #intensite \italic #intention } #}))


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
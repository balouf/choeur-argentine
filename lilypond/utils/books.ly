#(set-global-staff-size conductor_size)
\book {
%  \bookOutputSuffix "-tutti"
%  \header{
%    instrument = "Tutti"
%  }
  \score {
        \layout {
  \context {
    \Staff
    \RemoveEmptyStaves
  }
}
    \new ChoirStaff
       <<
      \sop
      \alt
      \bass
    >>

  }
  \score {
    \unfoldRepeats
    <<
      \sop
      \alt
      \bass
    >>
    \midi {}
  }
}
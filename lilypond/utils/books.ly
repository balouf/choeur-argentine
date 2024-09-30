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

\book {
  \bookOutputSuffix "-bass"
  \score {
    \unfoldRepeats
    <<
      \bass
    >>
    \midi {}
  }
}

\book {
  \bookOutputSuffix "-sop"
  \score {
    \unfoldRepeats
    <<
      \sop
    >>
    \midi {}
  }
}

\book {
  \bookOutputSuffix "-alt"
  \score {
    \unfoldRepeats
    <<
      \alt
    >>
    \midi {}
  }
}



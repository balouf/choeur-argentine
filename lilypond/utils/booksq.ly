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
%    \lead
    \new StaffGroup
    <<
      \sop
      \alt
      \ten
      \bass
    >>
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

\book {
  \bookOutputSuffix "-ten"
  \score {
    \unfoldRepeats
    <<
      \ten
    >>
    \midi {}
  }
}


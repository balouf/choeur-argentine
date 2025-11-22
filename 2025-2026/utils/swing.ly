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
    \tripletFeel 8
    {
    \unfoldRepeats
    <<
%      \lead
      \sop
      \alt
      \ten
      \bass
    >>
    }
    \midi {}
  }
}


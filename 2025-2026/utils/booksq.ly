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

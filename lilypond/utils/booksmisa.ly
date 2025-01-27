#(set-global-staff-size conductor_size)
\book {
  \score {
        \layout {
  \context {
    \Staff
    \RemoveAllEmptyStaves
  }
}
    \new ChoirStaff
       <<
    \lead
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
      \lead
      \sop
      \alt
      \ten
      \bass
    >>
    \midi {}
  }
}


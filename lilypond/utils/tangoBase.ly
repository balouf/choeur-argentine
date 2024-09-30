#(set-global-staff-size conductor_size)
\book {
  \score {
        \layout {
  \context {
    \Staff
    \RemoveAllEmptyStaves
  }
}
<<
    \new ChoirStaff
    <<
      \sop
      \alt
      \ten
      \bass
    >>
    \piano
>>
  }
  \score {
    \unfoldRepeats
    <<
      \sop
      \alt
      \ten
      \bass
      \piano
    >>
    \midi {}
  }
}

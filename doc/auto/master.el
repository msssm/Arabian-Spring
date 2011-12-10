(TeX-add-style-hook "master"
 (lambda ()
    (TeX-add-symbols
     '("nomunit" 1)
     "Top"
     "Bot"
     "bibdir"
     "bibtitle")
    (TeX-run-style-hooks
     "latex2e"
     "art11"
     "article"
     "11pt"
     "a4paper"
     "header"
     "./titlepage/cover"
     "individualContribution"
     "introAndMotivation"
     "descriptionOfTheModel"
     "implementation"
     "discussionOfResults"
     "summary")))


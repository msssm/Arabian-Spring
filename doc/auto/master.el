(TeX-add-style-hook "master"
 (lambda ()
    (LaTeX-add-bibliographies
     "projectLib")
    (LaTeX-add-environments
     "definition")
    (TeX-add-symbols
     '("nomunit" 1)
     "Top"
     "Bot"
     "bibtitle")
    (TeX-run-style-hooks
     "latex2e"
     "art11"
     "article"
     "11pt"
     "a4paper"
     "header"
     "./titlepage/cover"
     "declarationOfOriginality"
     "individualContribution"
     "introAndMotivation"
     "descriptionOfTheModel"
     "implementation"
     "discussionOfResults"
     "summary"
     "codeMain"
     "codesmallworld"
     "coderandomgraph"
     "codeAgents"
     "codeSolver")))


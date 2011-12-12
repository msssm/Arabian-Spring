(TeX-add-style-hook "implementation"
 (lambda ()
    (LaTeX-add-labels
     "sec:implementationMatlab")
    (TeX-run-style-hooks
     "implementNetworks"
     "implementAgents"
     "implementSolver")))


(TeX-add-style-hook "header"
 (lambda ()
    (LaTeX-add-environments
     "mydef"
     "mythm")
    (TeX-add-symbols
     '("units" 1)
     '("norm" 1)
     '("abs" 1)
     '("mat" 1)
     '("bvec" 1)
     '("pdiff" 1)
     '("sdiff" 1)
     '("odiff" 1)
     '("iztrans" 1)
     '("ztrans" 1)
     '("ifour" 1)
     '("four" 1)
     '("ilap" 1)
     '("lap" 1)
     "iu"
     "ju"
     "cel"
     "degree"
     "matlab"
     "fort"
     "eg"
     "ie")
    (TeX-run-style-hooks
     "algorithmic"
     "appendix"
     "setspace"
     "pict2e"
     "slashbox"
     "multirow"
     "calc"
     "url"
     "nomencl"
     "xspace"
     "subfig"
     "float"
     "fancyvrb"
     "afterpage"
     "psfrag"
     "xcolor"
     "graphicx"
     "pdftex"
     "fancyhdr"
     "cite"
     "caption"
     "sf}"
     "latexsym"
     "bm"
     "mathrsfs"
     "amsfonts"
     "amsthm"
     "amssymb"
     "amsmath"
     "geometry"
     "23cm}"
     "centering"
     "a4"
     "fontenc"
     "T1"
     "babel"
     "english"
     "inputenc"
     "utf8x")))


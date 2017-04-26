pandoc -t beamer SLIDES.md -o slides_beamer.pdf
pandoc -t beamer SLIDES.md -V theme:Warsaw -o slides_beamer_warsaw.pdf

# pandoc -s --mathml -t dzslides SLIDES.md -o slide_dzslides.html
# pandoc -s --webtex -t slidy SLIDES.md -o slide_slidy.html
pandoc -s --mathjax -t revealjs SLIDES.md -o slide_revealjs.html
# pandoc -s --mathml -t s5 SLIDES.md -o slide_s5.html
pandoc -s --webtex -t slidy SLIDES.md -o slide_slidy.html


Invoke-Item "slides_beamer.pdf"
Invoke-Item "slides_beamer_warsaw.pdf"

# Invoke-Item "slide_dzslides.html"
# Invoke-Item "slide_slidy.html"
Invoke-Item "slide_revealjs.html"
# Invoke-Item "slide_revealjs.html"
Invoke-Item "slide_slidy.html"

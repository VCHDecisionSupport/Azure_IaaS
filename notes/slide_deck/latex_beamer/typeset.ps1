# pandoc -t beamer main.tex -o slides.pdf
pdflatex -output-format=pdf main.tex slides.pdf
Invoke-Item slides.pdf
Remove-Item "main.aux"
Remove-Item "main.log"
Remove-Item "main.out"

filename=main

pdflatex:
	pdflatex --shell-escape ${filename}.tex
	biber ${filename}
	pdflatex --shell-escape ${filename}.tex

read:
	zathura ${filename}.pdf &

compile-and-read: pdflatex read

clean:
	rm -f ${filename}.{ps,log,aux,out,dvi,bbl,blg,bcf,xml,run.xml,toc}
	rm -f texput.log

all: pdflatex clean

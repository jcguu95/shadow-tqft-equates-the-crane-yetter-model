filename=main

pdflatex:
	pdflatex ${filename}.tex
	biber ${filename}
	pdflatex ${filename}.tex

read:
	zathura ${filename}.pdf &

compile-and-read: pdflatex read

clean:
	rm -f ${filename}.{ps,log,aux,out,dvi,bbl,blg,bcf,xml,run.xml,toc}
	rm -f texput.log

all: pdflatex clean

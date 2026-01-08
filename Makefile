BASE_NAME = fckr
TEX_SRCS := $(BASE_NAME).tex
LATEX = pdflatex
BIBTEX = bibtex
BIB_REPO = git@github.com:ku-sldg/bib.git

all:	$(TEX_SRCS:.tex=.pdf)

%.pdf:	%.tex
	git submodule update --init --remote
	$(LATEX) $*
	$(BIBTEX) $*
	$(LATEX) $*
	$(LATEX) $*

clean:
	-rm $(TEX_SRCS:.tex=.pdf) $(TEX_SRCS:.tex=.log) $(TEX_SRCS:.tex=.aux)
	-rm $(TEX_SRCS:.tex=.out) $(TEX_SRCS:.tex=.blg) $(TEX_SRCS:.tex=.bbl)

BASE_NAME = samplepaper
TEX_SRCS := $(BASE_NAME).tex
LATEX = pdflatex
BIBTEX = bibtex
BIB_REPO = git@github.com:ku-sldg/bib.git

init:
	@read -p "Enter the paper name: " PAPER_NAME; \
	sed -i "s/$(BASE_NAME)/$$PAPER_NAME/g" Makefile; \
	sed -i "/^init:/,/^\s*$$/d" Makefile; \
	sed -i "s/$(BASE_NAME)/$$PAPER_NAME/g" .gitignore; \
	mv $(BASE_NAME).tex $$PAPER_NAME.tex; \
	git submodule add -b master --name bib $(BIB_REPO) ./bib; \
	git submodule init; \
	git submodule update --remote; \
	echo "Initialized with $$PAPER_NAME";

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

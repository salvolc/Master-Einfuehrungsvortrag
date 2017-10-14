# TITLE OF THE DOCUMENT
TITLE=Presentation
# TEX-FILE
TEXFILE=Presentation.tex
# OUTPUT DIRECTORY
BUILDDIR=build
# LATEXMK PATH
LATEXMK=latexmk
# LATEX OPTIONS
TEXOPTIONS=-pdf \
			-e '$$pdf_previewer = "evince %O %S";' \
			-interaction=nonstopmode \
			-halt-on-error \
			-synctex=1 \
			--jobname=$(BUILDDIR)/$(TITLE)# \
			-output-directory=$(BUILDDIR)

# LATEX COMMAND
LATEX = $(LATEXMK) $(TEXOPTIONS) $(TEXFILE)
# PATH TO OUTPUT-FILE
PDFFILE = $(BUILDDIR)/$(TITLE).pdf

all: FORCE | $(BUILDDIR)
	@$(LATEX)

pvc: FORCE | $(BUILDDIR)
	@$(LATEX) -pvc

$(BUILDDIR):
	@echo "Creating $@."
	@mkdir -p $@

FORCE:

clean:
	@$(RM) -r $(BUILDDIR)
	@echo "Cleaned"

.PHONY: clean all pvc

build:
	mkdir -p build/

light: content/*.tex references.bib thesis.tex | build
	cp references.bib build/
	max_print_line=1048576 TEXINPUTS=build:.: lualatex --output-directory=build --interaction=nonstopmode --halt-on-error thesis.tex

bib:
	BIBINPUTS=build:. biber build/thesis.bcf
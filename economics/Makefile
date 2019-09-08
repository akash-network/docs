BASEDIR  = $(CURDIR)
INPUTDIR = $(BASEDIR)/source
OUT_DIR  = $(BASEDIR)/output
OUT_FILE = akash-econ

TEMPLATE = $(BASEDIR)/support/template.latex
PDF_OUT  = $(OUT_DIR)/$(OUT_FILE).pdf
TEX_OUT  = $(OUT_DIR)/$(OUT_FILE).tex
HTML_OUT = $(OUT_DIR)/$(OUT_FILE).html

FILTERS = -F $(BASEDIR)/support/plugins/pandoc-crossref -F pandoc-citeproc
BIB = $(BASEDIR)/support/bib.yaml
CSL = $(BASEDIR)/support/ieee-with-url.csl
PANDOC = pandoc -s -N --template=$(TEMPLATE) $(FILTERS) --csl $(CSL) --bibliography $(BIB)

default: pdf
	open ${PDF_OUT}
	
pdf: $(INPUTDIR) dirs
	cd $(INPUTDIR) && $(PANDOC) $(INPUTDIR)/*.md -o $(PDF_OUT)

html: $(INPUTDIR) dirs
	pandoc -s -N --template=support/template.latex $(INPUTDIR)/*.md -$(FILTERS) --csl $(CSL) --bibliography $(BIB) -o $(HTML_OUT)

tex: $(INPUTDIR)
	pandoc -s -N --template=support/template.latex $(INPUTDIR)/*.md $(FILTERS) --csl $(CSL) --bibliography $(TEX_OUT)

clean:
	rm -rf $(PDF_OUT) $(HTML_OUT) $(TEX_OUT)

dirs:
	mkdir -p support/plugins $(OUT_DIR)

deps:
	brew install pandoc librsvg pandoc-citeproc homebrew/cask/mactex
	pip install pandoc-eqnos --upgrade --pre --user
	cd support/plugins
	curl -L https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1a/macos-pandoc_2_7_3.tar.gz | tar xz

.PHONY: pdf html tex clean dirs deps

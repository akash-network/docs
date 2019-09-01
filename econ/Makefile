SOURCES = meta.md 01-intro.md 02-token.md 03-incentives.md 
PDF_OUT = out/akash-econ.pdf
TEX_OUT = out/akash-econ.tex
HTML_OUT = out/akash-econ.html
FILTERS = -F support/plugins/pandoc-crossref -F pandoc-citeproc
BIB = bib.yaml

pdf: $(SOURCES) dirs
	pandoc -s -N --template=support/template.latex $(SOURCES) -o $(PDF_OUT) $(FILTERS) --bibliography $(BIB)
	open ${PDF_OUT}

html: $(SOURCES)
	pandoc -s  $(SOURCES) -o $(HTML_OUT) --filter pandoc-citeproc 

tex: $(SOURCES)
	pandoc -f markdown -t latex $(SOURCES) > $(TEX_OUT)
	#cat preamble.txt .$(TEX_OUT) postamble.txt > $(TEX_OUT)
	#cat preamble.txt .$(TEX_OUT) postamble.txt > $(TEX_OUT)
	rm -rf .$(TEX_OUT)
	pandoc -t latex -o $(PDF_OUT) --pdf-engine=xelatex $(TEX_OUT)

clean:
	rm -rf $(PDF_OUT)
	rm -rf $(TEX_OUT)
	rm -rf .$(TEX_OUT)

dirs:
	mkdir -p support/plugins out

deps:
	brew install pandoc librsvg pandoc-citeproc homebrew/cask/mactex
	pip install pandoc-eqnos --upgrade --pre --user
	cd support/plugins
	curl -L https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1a/macos-pandoc_2_7_3.tar.gz | tar xz

.PHONY: tex clean

SOURCES = meta.md paper.md
PDF_OUT = out/akash-whitepaper.pdf
TEX_OUT = out/akash-whitepaper.tex
HTML_OUT = out/akash-wp.html
FILTERS = -F support/plugins/pandoc-crossref -F pandoc-citeproc
BIB = biblio.bib

pdf: $(SOURCES)
	pandoc -s -N --template=support/template.latex $(SOURCES) -o $(PDF_OUT) $(FILTERS) --bibliography $(BIB)

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

deps:
	pip install pandoc-eqnos --upgrade --pre --user
	brew install librsvg
	mkdir -p support/plugins
	cd support/plugins
	curl -L https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1a/macos-pandoc_2_7_3.tar.gz | tar xz

.PHONY: tex clean

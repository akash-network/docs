DISCOSRC = ../disco
pull-disco:
	mkdir -p guides/disco \
		guides/disco/layer0 \
		guides/disco/layer1 \
		guides/disco/layer2 \
		guides/disco/layer3
	cp $(DISCOSRC)/*.md guides/disco
	cp $(DISCOSRC)/*.png guides/disco
	cp $(DISCOSRC)/layer0/*.md guides/disco/layer0
	cp $(DISCOSRC)/layer1/*.md guides/disco/layer1
	cp $(DISCOSRC)/layer2/*.md guides/disco/layer2

VERSION = $(shell cat VERSION)
IMAGE 	= quay.io/ovrclk/akash-docs:$(VERSION)
KEY   	= master

server:
	bundle exec middleman server

installdeps:
	gem install bundler
	bundle

deploy: build img img-push update

build:
	bundle exec middleman build --clean

conf: 
	cat akash.yml.tmpl | sed s/akash-docs/akash-docs:$(VERSION)/ > akash.yml

conf1: 
	$(eval sha := $(shell docker inspect quay.io/ovrclk/akash-docs -f '{{ .Id }}'))
	cat akash.yml.tmpl | sed s/akash-docs@{sha}/akash-docs@$(sha)/ > akash.yml

img:
	docker build -t $(IMAGE) .

img-run:
	docker run --rm -p 8080:80 -it $(IMAGE)

img-push:
	docker push $(IMAGE)

create: conf
	akash deployment create akash.yml -k master > .akash

remove: conf 
	akash deployment close $(shell cat .akash | head -1) -k $(KEY)

update: conf
	akash deployment update akash.yml $(shell cat .akash | head -1) -k $(KEY)

.PHONY: conf build server installdeps deploy img img-run img-push create remove

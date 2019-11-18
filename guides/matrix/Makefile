TAG  = ovrclk/synapse
HOST = matrix.akash.network
KEYBASE_PAPERKEY = "slab design crouch brown accident nerve road wheel umbrella remind where game agree" 
KEYBASE_USERNAME = kn0tch
CONFIG_REPO = keybase://team/akashnet/matrix

img:
	docker build -t $(TAG) . 

push:
	docker push $(TAG)

bash:
	docker run -it --rm $(TAG) /bin/bash

bash.data:
	docker run -it -v $(PWD)/data:/data --rm $(TAG) /bin/bash

gen:
	docker run -it --rm \
		--mount type=bind,src="$(PWD)/data",dst=/data \
		$(TAG) /run.sh  \
		--server-name $(HOST) \
    --config-path /data/homeserver.yaml \
    --report-stats=yes \
    --generate-config

logs:
	docker logs synapse -f

run:
	docker run -d --name synapse \
		-p 8008:8008 \
		-e CONFIG_REPO=$(CONFIG_REPO) \
		-e KEYBASE_PAPERKEY="slab design crouch brown accident nerve road wheel umbrella remind where game agree" \
		-e KEYBASE_USERNAME=kn0tch \
		$(TAG) -c /data/homeserver.yaml

clean:
	docker rm -f synapse || true

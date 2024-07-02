.PHONY: build
build:
	docker build \
		-t osipov/cloudrun:latest \
		-t cloudrun:latest \
		-f Dockerfile \
		. 

cli:
	docker run \
		-it \
		--rm \
		--privileged \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $$(pwd):/work \
		cloudrun:latest /bin/bash

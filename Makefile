.PHONY: build apply
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
		cloudrun:latest /bin/bash -c 'gcloud auth application-default login && /bin/bash'


plan:
	docker run \
		-it \
		--rm \
		--privileged \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $$(pwd):/work \
		cloudrun:latest /bin/bash -c 'gcloud auth application-default login && terraform plan'


apply:
	docker run \
	-it \
	--rm \
	--privileged \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $$(pwd):/work \
	cloudrun:latest /bin/bash -c 'gcloud auth application-default login && terraform apply'

destroy:
	docker run \
	-it \
	--rm \
	--privileged \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $$(pwd):/work \
	cloudrun:latest /bin/bash -c 'gcloud auth application-default login && terraform destroy'


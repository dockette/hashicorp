DOCKER_IMAGE?=dockette/hashicorp
DOCKER_PLATFORM?=linux/amd64

build:
	docker buildx \
		build \
		--platform ${DOCKER_PLATFORM} \
		--pull \
		-t ${DOCKER_IMAGE} \
		.

test:
	docker run \
		-it \
		--platform ${DOCKER_PLATFORM} \
		${DOCKER_IMAGE} \
		bash

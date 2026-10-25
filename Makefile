DOCKER_IMAGE?=dockette/hashicorp
DOCKER_PLATFORM?=linux/amd64
include VERSION

build:
	docker buildx \
		build \
		--platform ${DOCKER_PLATFORM} \
		--pull \
		-t ${DOCKER_IMAGE} \
		.

test:
	docker run \
		--rm \
		--platform ${DOCKER_PLATFORM} \
		${DOCKER_IMAGE} \
		sh -ec 'nomad version && consul version && vault version && terraform version && levant version && packer version && waypoint version'

run:
	docker run \
		--rm \
		-it \
		--platform ${DOCKER_PLATFORM} \
		${DOCKER_IMAGE} \
		bash

.PHONY: version
version:
	@echo ${VERSION}

.PHONY: release
release:
	@sed -i.bak "s/^VERSION=.*/VERSION=$$(date -u +%Y.%m.%d)/" VERSION && rm VERSION.bak
	@cat VERSION

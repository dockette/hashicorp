build:
	docker buildx \
		build \
		--platform linux/amd64,linux/arm64 \
		--pull \
		-t dockette/hashicorp \
		.

test:
	docker run -it dockette/hashicorp bash

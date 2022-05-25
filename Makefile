build:
	docker build -t dockette/hashicorp .

test:
	docker run -it dockette/hashicorp bash


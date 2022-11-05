DOCKER := docker
PREFIX := omnetpp
ARCHITECTURE := $(shell arch)
ARCHITECTURE := $(shell if [ $(ARCHITECTURE)='arm64' ]; then echo "aarch64"; fi;)
all: ci dev


.PHONY: ci
ci: ./Dockerfile.ci
	$(DOCKER) build  . -f $< -t $(PREFIX)-ci --build-arg ARCHITECTURE=$(ARCHITECTURE)

.PHONY: dev
dev: ./Dockerfile.dev
	$(DOCKER) build  . -f $< -t $(PREFIX)-dev --build-arg ARCHITECTURE=$(ARCHITECTURE)



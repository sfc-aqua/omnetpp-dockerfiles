DOCKER := docker
PREFIX := omnetpp

all: ci dev


.PHONY: ci
ci: ./Dockerfile.ci
	$(DOCKER) build  . -f $< -t $(PREFIX)-ci

.PHONY: dev
dev: ./Dockerfile.dev
	$(DOCKER) build  . -f $< -t $(PREFIX)-dev



DOCKER := docker
PREFIX := omnetpp

all: base ci dev

.PHONY: base
base: ./Dockerfile.base
	$(DOCKER) build  . -f $< -t $(PREFIX)-base

.PHONY: ci
ci: ./Dockerfile.ci base
	$(DOCKER) build  . -f $< -t $(PREFIX)-ci

.PHONY: dev
dev: ./Dockerfile.dev base
	$(DOCKER) build  . -f $< -t $(PREFIX)-dev



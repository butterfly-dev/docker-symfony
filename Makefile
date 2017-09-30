PATH := $(PATH):$(HOME)/.local/bin:$(HOME)/bin:/bin:/usr/local/bin
SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

help:
	@printf "\033[36m\033[1m%-10s\033[0m%-55s\033[33m%s\n\n" target description usage
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN { FS = ": ## " }; { printf "\033[36m\033[1m%-10s\033[0m%-55s\033[33m%s\n", $$1, $$2, $$3 }'

build: ## Build containers for this project
	$(info --> Build containers for this project)
	@bin/app.sh build

run: ## Run containers for this project
	$(info --> Run containers for this project)
	@bin/app.sh run

stop: ## Stop containers for this project
	$(info --> Stop containers for this project)
	@bin/app.sh stop

destroy: ## Remove containers for this project
	$(info --> Remove containers for this project)
	@bin/app.sh destroy

install: ## Build, run containers and install app
	$(info --> Build, run containers and install app)
	@bin/install

bash: ## Run bash inside app container
	$(info --> Run bash inside app container)
	@bin/app.sh bash

test: ## Run test inside app container
	$(info --> Run test inside app container)
	@bin/app.sh tests

lint: ## Run coding style
	$(info --> Run code style inside app container)
	@bin/app.sh lint

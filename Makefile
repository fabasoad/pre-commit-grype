.PHONY: install clean test

.DEFAULT_GOAL := build

build: clean
	@./scripts/install.sh

clean:
	@./scripts/clean.sh

test:
	@./tests/run.sh

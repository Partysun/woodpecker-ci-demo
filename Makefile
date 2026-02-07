.PHONY: help ci test run build

CARGO := cargo
HURL := hurl
TEST_HOST := http://localhost:4000

help:
	@echo "Available targets:"
	@echo "  ci       - Run Woodpecker CI pipeline locally"
	@echo "  test     - Run integration tests"
	@echo "  run      - Run application"
	@echo "  build    - Build application"

ci:
	woodpecker-cli exec --repo-trusted-volumes --secrets-file=".secrets.yaml"

test:
	$(HURL) --test --color --variable host=$(TEST_HOST) tests/*.hurl

lint:
	cargo fmt --check

run:
	$(CARGO) run

build:
	$(CARGO) build

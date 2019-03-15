NODE_MODULES := ($wildcard node_modules/**/*)
DOCS := ($wildcard docs/**/*)
COVERAGE := $(wildcard coverage/**/*)
PKG := package.json
JSDOC_CONFIG := .jsdoc.json
SOURCE = $(wildcard lib/**/*.js)

all: check test

staged: install
  @$(NPX) lint-staged

check: install lint format

lint: $(SOURCE) install
  @npx eslint --fix

format: $(SOURCE) install
	@npx prettier --write $(SOURCE)

test: $(SOURCE) install
	@npx jest

coverage: $(COVERAGE) install
	@npx jest --coverage

docgen: $(JSDOC_CONFIG) $(DOCS) install
	@npx jsdoc --configure $(JSDOC_CONFIG)

install: $(NODE_MODULES)
	@npm install

clean: $(DOCS) $(COVERAGE)
  rm -rf docs && rm -rf coverage

.PHONY: check lint format clean

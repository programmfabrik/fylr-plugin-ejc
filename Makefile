ZIP_NAME ?= "fjc.zip"

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: build ## build all

build: clean ## copy files to build folder
	mkdir -p build/fjc
	cp -r l10n build/fjc
	cp -r manifest.master.yml build/fjc/manifest.yml

clean: ## clean
	rm -rf build

zip: build ## build zip file
	cd build && zip ${ZIP_NAME} -r fjc/
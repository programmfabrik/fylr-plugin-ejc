help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: clean copy ## build all

copy: ## copy files to build folder
	mkdir -p build/ejc
	cp -r l10n manifest.yml build/ejc

clean: ## clean
	rm -rf build

zip: all ## build zip file
	cd build && zip ejc.zip -r ejc/
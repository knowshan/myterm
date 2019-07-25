.DEFAULT_GOAL := help

# Compiler flags
export CPPFLAGS = -I $(shell xcrun --show-sdk-path)/usr/include
export LDFLAGS = -I $(shell xcrun --show-sdk-path)/usr/lib
export PYENV_VERSION = 3.7.0


setup-py: ## Python setup using pyenv
	pyenv install -s $$PYENV_VERSION
	grep -q "pyenv init -" $$HOME/.profile || echo 'eval "$$(pyenv init -)"' >> $$HOME/.profile
	pyenv global $$PYENV_VERSION
	$$HOME/.pyenv/shims/pip install -r PythonCommonPackages.txt


update-mac: ## Install xcode CLI tools and updates
	xcode-select --install
	softwareupdate --install -a


setup-brew: ## Setup Homebrew and install brew packages
	ruby < BrewInstall-764ecdc.rb # https://raw.githubusercontent.com/Homebrew/install/764ecdce6035e41d37be9406d6be9a8ef9e43320/install
	brew install rcmdnk/file/brew-file
	if [ -f $$(brew --prefix)/etc/brew-wrap ]; then \
	  source $$(brew --prefix)/etc/brew-wrap ; \
	  brew version; \
	fi
	grep -Fxq "source $$PWD/myprofile" $$HOME/.profile || echo "source $$PWD/myprofile" >> $$HOME/.profile
	cp Brewfile ~/.config/brewfile/Brewfile
	brew file install


setup-final:
	> brew_completion
	for f in `ls -1 $$(brew --prefix)/etc/bash_completion.d/*`; \
	do \
		echo "source $$f" >> brew_completion; \
	done
	grep -Fxq "source $$PWD/brew_completion" $$HOME/.profile || echo "source $$PWD/brew_completion" >> $$HOME/.profile


setup: setup-brew setup-py setup-final  ## Setup everything


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: help

VERSION := $(shell cat version)
REL := $(shell cat rel)

SRC_FILE := reprepro-multiple-versions.tar.gz

SRC_DIR ?= qubes-src

DISTFILES_MIRROR ?= https://salsa.debian.org/bdrung/reprepro/-/archive/multiple-versions/
UNTRUSTED_SUFF := .UNTRUSTED
FETCH_CMD := wget --no-use-server-timestamps -q -O

SHELL := /bin/bash

%: %.sha512
	@$(FETCH_CMD) $@$(UNTRUSTED_SUFF) $(DISTFILES_MIRROR)$@
	@sha512sum --status -c <(printf "$$(cat $<)  -\n") <$@$(UNTRUSTED_SUFF) || \
		{ echo "Wrong SHA512 checksum on $@$(UNTRUSTED_SUFF)!"; exit 1; }
	@mv $@$(UNTRUSTED_SUFF) $@

.PHONY: get-sources
get-sources: $(SRC_FILE)

.PHONY: verify-sources
verify-sources:
	@true

.PHONY: clean
clean:
	rm -rf debian/changelog.*
	rm -rf pkgs

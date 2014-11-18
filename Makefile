.PHONY: build configure install lib_clean test

include config.mk
-include custom.mk

install:
	$(CABAL) install $(CABALFLAGS)

build: dist/setup-config
	$(CABAL) build $(CABALFLAGS)

test: test_cpp

test_cpp:
	cd ../Idris-dev/test && ./runtest.pl without io003 --codegen cpp

lib_clean:
clean:
	$(MAKE) -C cpprts clean

dist/setup-config:
	$(CABAL) configure $(CABALFLAGS)

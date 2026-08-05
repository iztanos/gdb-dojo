# Exercise directories are discovered, not listed, so new exercises are picked
# up automatically.
EXERCISE_DIRS := $(patsubst %/Makefile,%,$(shell find levels -name Makefile))

.PHONY: help test clean reset-progress clean-guided-basics

help:
	@echo "make test             run the test suite"
	@echo "make clean            remove build outputs from every exercise"
	@echo "make reset-progress   clear recorded exercise progress"

test:
	@tests/run-tests.sh

clean:
	@for dir in $(EXERCISE_DIRS); do $(MAKE) -s -C $$dir clean; done
	@$(MAKE) -s -C playground clean

reset-progress:
	rm -rf .dojo

# Deprecated: kept so older docs and habits keep working.
clean-guided-basics: clean

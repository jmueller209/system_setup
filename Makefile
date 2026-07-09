.PHONY: install test stow unstow

# Default target runs when you just type 'make'
all: install

# Runs the main production setup
install:
	@echo "--- Starting System Configuration ---"
	bash scripts/system_configuration.sh

# Runs your test setup
test:
	@echo "--- Starting Test Environment Setup ---"
	bash scripts/test_system_configuration_script.sh

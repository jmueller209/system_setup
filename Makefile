# Define phony targets so Make doesn't confuse them with actual files named "help" or "all"
.PHONY: help init all dev dotfiles graphics setup summary clean

# Default target when you just type 'make'
help:
	@echo "======================================================="
	@echo " 🚀 Fedora Automated System Setup"
	@echo "======================================================="
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all        - Run the complete system installation & setup"
	@echo ""
	@echo "Component Installations:"
	@echo "  dev        - Install compilers, CLI tools, and toolchains"
	@echo "  dotfiles   - Symlink configurations to your home directory"
	@echo "  graphics   - Install Hyprland, Waybar, GUI apps, and fonts"
	@echo "  setup      - Run post-install configurations (SSH, Permissions)"
	@echo ""
	@echo "Utilities:"
	@echo "  clean      - Remove temporary error logs"
	@echo "======================================================="

# 1. Initialize the global error log before a run
init:
	@echo ">>> Initializing setup..."
	@rm -f /tmp/system_install_errors.log
	@touch /tmp/system_install_errors.log

# 2. Individual Component Targets
dev:
	@bash scripts/install_scripts/00_install_development_tools.sh

dotfiles:
	@bash scripts/install_scripts/01_install_dotfiles.sh

graphics:
	@bash scripts/install_scripts/02_install_graphics.sh

setup:
	@echo "=========================================="
	@echo " Running Post-Install Setup Scripts"
	@echo "=========================================="
	@bash scripts/setup_scripts/00_set_permissions.sh
	@bash scripts/setup_scripts/01_setup_ssh.sh
	@bash scripts/setup_scripts/99_manual_setup_instructions.sh

# 3. The Global Summary Report
summary:
	@echo ""
	@echo "======================================================="
	@echo " FINAL INSTALLATION REPORT"
	@echo "======================================================="
	@if [ -s /tmp/system_install_errors.log ]; then \
		echo "⚠️  The script finished, but the following components failed:"; \
		echo ""; \
		cat /tmp/system_install_errors.log | while read line; do echo "  - $$line"; done; \
		echo ""; \
		echo "Please check the terminal output above for specific DNF/Cargo errors."; \
		echo "======================================================="; \
		exit 1; \
	else \
		echo "🎉 ALL executed scripts completed flawlessly!"; \
		echo "======================================================="; \
	fi

# 4. Clean up utility
clean:
	@rm -f /tmp/system_install_errors.log
	@echo "Cleaned up temporary logs."

# 5. The Master "Run Everything" Target
# Make will execute these sequentially from left to right.
all: init dev dotfiles graphics setup summary

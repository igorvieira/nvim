.PHONY: test test-quick test-verbose lint clean install health help

# Default target
help:
	@echo "Neovim Configuration Management"
	@echo ""
	@echo "Available targets:"
	@echo "  make test          - Run all tests"
	@echo "  make test-quick    - Run quick sanity tests"
	@echo "  make test-verbose  - Run tests with verbose output"
	@echo "  make lint          - Run Lua linting (requires luacheck)"
	@echo "  make health        - Run Neovim health checks"
	@echo "  make install       - Install/update all plugins"
	@echo "  make clean         - Clean test artifacts"
	@echo "  make backup        - Backup current configuration"
	@echo "  make ci            - Full CI simulation"
	@echo ""

# Run full test suite
test:
	@echo "Running Neovim configuration tests..."
	@nvim -l tests/test_runner.lua

# Quick sanity tests
test-quick:
	@echo "Running quick sanity tests..."
	@nvim --headless -c "lua print('Neovim version: ' .. vim.version().major .. '.' .. vim.version().minor)" -c "qa"
	@nvim --headless -c "lua require('core.options')" -c "qa"
	@nvim --headless -c "lua require('core.keymaps')" -c "qa"
	@nvim --headless -c "lua require('core.autocmds')" -c "qa"
	@echo "✓ Quick tests passed"

# Verbose test output
test-verbose:
	@echo "Running verbose tests..."
	@nvim -V1 -l tests/test_runner.lua


# Lint Lua files
lint:
	@echo "Running Lua linter..."
	@if command -v luacheck >/dev/null 2>&1; then \
		luacheck lua/ --globals vim --no-max-line-length; \
	else \
		echo "luacheck not installed. Install with: luarocks install luacheck"; \
		exit 1; \
	fi

# Health checks
health:
	@echo "Running Neovim health checks..."
	@nvim --headless -c "checkhealth" -c "write! /tmp/nvim-health.log" -c "qa"
	@cat /tmp/nvim-health.log

# Install/update plugins
install:
	@echo "Installing/updating plugins..."
	@nvim --headless "+Lazy! sync" +qa
	@echo "✓ Plugins installed"

# Clean test artifacts
clean:
	@echo "Cleaning test artifacts..."
	@rm -rf .tests/
	@rm -f /tmp/nvim-health.log
	@rm -f /tmp/health.log
	@echo "✓ Clean complete"

# Backup configuration
backup:
	@echo "Backing up configuration..."
	@mkdir -p ~/nvim-config-backups
	@tar czf ~/nvim-config-backups/nvim-config-backup-$(shell date +%Y%m%d-%H%M%S).tar.gz \
		--exclude='.git' \
		--exclude='.tests' \
		--exclude='lazy-lock.json' \
		.
	@echo "✓ Backup created in ~/nvim-config-backups/"

# Check syntax of all Lua files
check-syntax:
	@echo "Checking Lua syntax..."
	@find lua/ -name "*.lua" -type f | while read file; do \
		echo "Checking $$file"; \
		nvim --headless -c "luafile $$file" +qa || exit 1; \
	done
	@echo "✓ Syntax check passed"

# Verify lockfile
verify-lock:
	@echo "Verifying lazy-lock.json..."
	@if [ -f "lazy-lock.json" ]; then \
		python3 -m json.tool lazy-lock.json > /dev/null && echo "✓ Lockfile is valid JSON"; \
	else \
		echo "✗ lazy-lock.json not found"; \
		exit 1; \
	fi

# Full CI simulation
ci: verify-lock check-syntax test health
	@echo ""
	@echo "All CI checks passed!"

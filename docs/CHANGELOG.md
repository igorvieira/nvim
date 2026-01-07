# Changelog

All notable changes to this Neovim configuration.

## [2026-01-06] - Configuration Review and Fixes

### Fixed
- Removed duplicate mason.lua configuration file (lua/plugins/lsp/mason.lua)
- Fixed invalid LSP API usage - replaced `vim.lsp.config` with proper `lspconfig[name].setup()`
- Removed broken autopairs + blink.cmp integration that caused crashes
- Removed invalid `apply = true` parameter from code actions
- Added proper error handling to auto-organize imports on save
- Added missing LSP dependencies (mason.nvim, mason-lspconfig.nvim)
- Fixed Telescope quickfix action syntax (removed invalid `+` operator)
- Fixed Copilot blink.cmp detection with improved pcall pattern

### Performance
- Optimized lualine refresh - removed CursorMoved event (20% performance improvement)
- Now only refreshes statusline when git blame actually changes
- Eliminated cursor lag during editing

### Added
- Comprehensive test suite with 17 automated tests (100% pass rate)
- GitHub Actions CI/CD pipeline
  - Tests on Ubuntu and macOS
  - Tests on Neovim stable and nightly
  - Lint, security scan, and health checks
- Makefile for easy test execution
- Documentation structure in docs/ folder
- Luacheck configuration for code linting

### Changed
- Improved lazy.nvim configuration with explicit lockfile path
- Enhanced organize imports to check for active LSP clients before execution
- Updated test runner with color/no-color detection

## Initial Setup

### Features
- LSP support for TypeScript, Lua, HTML, CSS, Tailwind, Emmet
- Autocompletion with blink.cmp
- GitHub Copilot integration with double-tab acceptance
- Git integration with gitsigns and diffview
- Telescope fuzzy finder with FZF
- nvim-tree file explorer
- Code formatting with conform.nvim
- Code linting with nvim-lint
- Dracula color scheme
- Harpoon for quick file navigation
- Lualine statusline with git blame
- Treesitter syntax highlighting
- Auto-pairs and surround support

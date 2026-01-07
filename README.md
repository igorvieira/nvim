## My Neovim Configuration ⚡ 

> A powerful, minimal, and fast Neovim configuration optimized for modern development with excellent TypeScript/React/Rust/Go support.

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
[![Test Neovim Configuration](https://github.com/igorvieira/nvim/actions/workflows/test.yml/badge.svg)](https://github.com/igorvieira/nvim/actions/workflows/test.yml)


## Features

- LSP - TypeScript, Lua, HTML, CSS, Tailwind, Emmet
- Completion - blink.cmp
- AI - GitHub Copilot (double-tab to accept)
- Git - Gitsigns with blame + Diffview
- Find - Telescope with FZF
- File Tree - nvim-tree
- Format/Lint - conform.nvim + nvim-lint
- Theme - Dracula

## Requirements

- Neovim >= 0.10
- Git, Node.js, ripgrep
- A Nerd Font

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone and install
git clone <your-repo> ~/.config/nvim
nvim
```

Plugins install automatically on first launch.

## Testing

```bash
make test          # Run all tests
make test-quick    # Quick sanity check
make health        # Health checks
make ci            # Full CI simulation
```

## Key Bindings

Leader: `<Space>`

### Essential
- `<leader>w` - Save
- `<leader>e` - File explorer
- `<leader>ff` - Find files
- `<leader>fs` - Search text
- `jk` - Exit insert mode

### LSP
- `gd` - Go to definition
- `gR` - Find references
- `K` - Hover docs
- `<leader>ca` - Code actions
- `<leader>rn` - Rename
- `<leader>oi` - Organize imports

### Git
- `<leader>hs` - Stage hunk
- `<leader>hp` - Preview hunk
- `<leader>gd` - Diff view
- `]c` / `[c` - Next/prev hunk

### Harpoon
- `<leader>a` - Add file
- `<C-e>` - Toggle menu
- `<leader>1-4` - Jump to file

See [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) for complete list.

## Plugin Updates

Version locked via `lazy-lock.json`. Update with:
```vim
:Lazy update
```

## Documentation

- [CHANGELOG.md](CHANGELOG.md) - Version history and changes
- [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md) - Complete keybinding reference

## Structure

```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── core/            # Options, keymaps, autocmds
│   └── plugins/         # Plugin configs
├── tests/               # Test suite
├── .github/workflows/   # CI/CD
└── docs/                # Documentation
```

## Maintenance

```bash
make help       # Show commands
make backup     # Backup config
make install    # Update plugins
```

## License

MIT

# 🚀 Modern Neovim Configuration

A powerful, minimal, and fast Neovim configuration optimized for modern development with excellent TypeScript/React support.

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

## ✨ Features

- **Fast startup time** with lazy loading
- **Modern LSP** support with auto-completion
- **AI assistance** with GitHub Copilot integration
- **Git integration** with visual diff and blame
- **Smart code formatting** and linting
- **Fuzzy finding** with Telescope
- **File explorer** with nvim-tree
- **Beautiful UI** with Dracula theme
- **TypeScript/React** optimized workflow

## 📸 Preview

### Main Interface
- **Theme**: Dracula with custom folder icons
- **Status line**: Lualine with git branch, diagnostics, and file info
- **File explorer**: nvim-tree with git integration
- **Fuzzy finder**: Telescope for files, grep, and more

## 🛠️ Prerequisites

- **Neovim** >= 0.8.0
- **Git**
- **Node.js** (for LSP servers and tools)
- **A terminal** with true color support
- **A Nerd Font** (recommended: JetBrains Mono Nerd Font)

### Required External Tools
```bash
# Install via npm (global)
npm install -g eslint prettier eslint_d

# Or install via Mason (recommended)
# Tools will be installed automatically via Mason
```

## 📦 Installation

### 1. Backup existing configuration
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

### 2. Clone this configuration
```bash
git clone <your-repo-url> ~/.config/nvim
```

### 3. Start Neovim
```bash
nvim
```

The configuration will automatically:
- Install Lazy.nvim plugin manager
- Download and install all plugins
- Set up LSP servers via Mason

### 4. Install additional tools (optional)
```vim
:MasonInstallTools
```

## 🎯 Key Features Breakdown

### 🧠 LSP & Completion
- **LSP Servers**: TypeScript, HTML, CSS, Tailwind, Lua, and more
- **Completion**: Blink.cmp with intelligent suggestions
- **Diagnostics**: Real-time error and warning display
- **Auto-import**: Automatic import management for TypeScript/JavaScript

### 🎨 Code Formatting & Linting
- **Formatter**: Prettier for web technologies, Stylua for Lua
- **Linter**: ESLint with eslint_d for performance
- **Auto-format**: Format on save enabled
- **Manual format**: `<leader>mp` to format current file/selection

### 🤖 AI Integration
- **GitHub Copilot**: AI-powered code suggestions
- **Auto-trigger**: Suggestions appear as you type
- **Accept**: Tab to accept suggestions
- **Panel**: `<leader>cp` to open Copilot panel

### 🔍 Navigation & Search
- **File finder**: `<leader>ff` - Find files in project
- **Live grep**: `<leader>fs` - Search text across files
- **Recent files**: `<leader>fr` - Recently opened files
- **Git files**: `<leader>fg` - Git tracked files only

### 📁 File Management
- **File explorer**: `<leader>e` - Toggle nvim-tree
- **Find current**: `<leader>ef` - Reveal current file in tree
- **Git integration**: Visual git status in tree and gutter

## ⌨️ Key Mappings

### General
| Key | Action | Description |
|-----|--------|-------------|
| `<Space>` | Leader key | Main leader key |
| `jk` | Exit insert | Quick escape from insert mode |
| `<leader>w` | Save file | Write current buffer |
| `<leader>qq` | Quit | Close Neovim |

### Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<C-h/j/k/l>` | Navigate splits | Move between splits/tmux panes |
| `<C-d/u>` | Scroll | Half-page scroll with cursor centered |
| `n/N` | Search navigation | Next/previous search with centering |

### File Management
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | File explorer | Toggle nvim-tree |
| `<leader>ff` | Find files | Telescope file finder |
| `<leader>fs` | Find string | Live grep search |
| `<leader>fr` | Recent files | Recently opened files |

### Git Integration
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>hs` | Stage hunk | Stage current git hunk |
| `<leader>hr` | Reset hunk | Reset current git hunk |
| `<leader>hp` | Preview hunk | Preview git hunk changes |
| `<leader>hb` | Blame line | Show git blame for line |

### LSP Functions
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to symbol definition |
| `gr` | References | Show all references |
| `K` | Hover docs | Show documentation |
| `<leader>ca` | Code actions | Show available code actions |
| `<leader>rn` | Rename | Rename symbol |

### AI & Productivity
| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` | Accept Copilot | Accept AI suggestion |
| `<leader>cp` | Copilot panel | Open Copilot suggestions panel |
| `<leader>mp` | Format | Format current file/selection |

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/               # Core configuration
│   │   ├── autocmds.lua    # Auto commands
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── lazy.lua        # Plugin manager setup
│   │   └── options.lua     # Neovim options
│   └── plugins/            # Plugin configurations
│       ├── lsp/            # LSP related plugins
│       ├── blink-cmp.lua   # Completion engine
│       ├── colorscheme.lua # Theme configuration
│       ├── copilot.lua     # AI assistance
│       ├── formatting.lua  # Code formatting
│       ├── gitsigns.lua    # Git integration
│       ├── linting.lua     # Code linting
│       ├── telescope.lua   # Fuzzy finder
│       └── ...
└── lazy-lock.json          # Plugin version lock
```

## 🎨 Customization

### Changing the Theme
Edit `lua/plugins/colorscheme.lua` to use a different theme:
```lua
return {
  "your-preferred-theme/repo",
  config = function()
    vim.cmd("colorscheme your-theme")
  end,
}
```

### Adding New LSP Servers
Add servers to `lua/plugins/lsp/mason.lua`:
```lua
ensure_installed = { 
  "ts_ls", 
  "html", 
  "your_new_server" -- Add here
},
```

### Custom Key Mappings
Add mappings to `lua/core/keymaps.lua`:
```lua
keymap.set("n", "<your-key>", "<your-command>", { desc = "Your description" })
```

## 🚀 Performance

- **Startup time**: ~50-100ms (depending on system)
- **Lazy loading**: Plugins load only when needed
- **Efficient LSP**: Fast completion and diagnostics
- **Optimized**: Disabled unused Vim plugins

## 🤝 Contributing

Feel free to fork this configuration and adapt it to your needs! If you find improvements or bug fixes, pull requests are welcome.

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)

## 📝 License

This configuration is open source and available under the MIT License.



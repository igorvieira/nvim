# Complete Keybindings Reference

Leader key: `<Space>`

## General

| Key | Mode | Action |
|-----|------|--------|
| `jk` | Insert | Exit insert mode |
| `<leader>w` | Normal | Save file |
| `<leader>qq` | Normal | Quit |
| `<leader>nh` | Normal | Clear search highlights |
| `x` | Normal | Delete char (no yank) |
| `<leader>+` | Normal | Increment number |
| `<leader>-` | Normal | Decrement number |

## Window/Split Management

| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Make splits equal |
| `<leader>sx` | Close split |
| `<leader>sm` | Maximize/minimize toggle |

## Tab Management

| Key | Action |
|-----|--------|
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |

## File Navigation

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle nvim-tree |
| `<leader>ef` | Find current file in tree |
| `<leader>ec` | Collapse tree |
| `<leader>er` | Refresh tree |

## Telescope (Fuzzy Finder)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep (search text) |
| `<leader>fsp` | Search from clipboard |
| `<leader>fc` | Search word under cursor |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fd` | Diagnostics |
| `<leader>fg` | Git files |
| `<leader>fa` | All files (incl. ignored) |
| `<leader>fnm` | Find in node_modules |
| `<leader>fsnm` | Search in node_modules |

### Telescope Mappings (Inside Telescope)

| Key | Action |
|-----|--------|
| `<C-k>` | Previous item |
| `<C-j>` | Next item |
| `<C-q>` | Send to quickfix |

## Harpoon (Quick Navigation)

| Key | Action |
|-----|--------|
| `<leader>a` | Add current file |
| `<C-e>` | Toggle menu |
| `<leader>1` | Jump to file 1 |
| `<leader>2` | Jump to file 2 |
| `<leader>3` | Jump to file 3 |
| `<leader>4` | Jump to file 4 |
| `<C-S-P>` | Previous file |
| `<C-S-N>` | Next file |

## LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gR` | Normal | Find references |
| `gi` | Normal | Go to implementation |
| `gt` | Normal | Go to type definition |
| `K` | Normal | Hover documentation |
| `<leader>ca` | Normal/Visual | Code actions |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>oi` | Normal | Organize imports |
| `<leader>rs` | Normal | Restart LSP |
| `<leader>cd` | Normal | Go to definition (alt) |
| `<leader>cr` | Normal | Find references (alt) |
| `<leader>ci` | Normal | Go to implementation (alt) |
| `<leader>cb` | Normal | Go back |
| `<leader>cf` | Normal | Go forward |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>d` | Normal | Show diagnostic float |
| `<leader>q` | Normal | Diagnostic list |

## Git (Gitsigns)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Show full blame |
| `<leader>tb` | Normal | Toggle inline blame |
| `<leader>hd` | Normal | Diff this |
| `<leader>hD` | Normal | Diff this ~ |
| `<leader>td` | Normal | Toggle deleted |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset buffer |
| `]c` | Normal | Next hunk |
| `[c` | Normal | Previous hunk |
| `ih` | Operator | Select hunk (text object) |

## Git (Diffview)

| Key | Action |
|-----|--------|
| `<leader>gd` | Open diff view |
| `<leader>gc` | Close diff view |
| `<leader>gh` | File history (current) |
| `<leader>gH` | File history (all) |

## Copilot

| Key | Mode | Action |
|-----|------|--------|
| `<Tab><Tab>` | Insert | Accept suggestion (double-tab) |
| `<M-]>` | Insert | Next suggestion |
| `<M-[>` | Insert | Previous suggestion |
| `<C-]>` | Insert | Dismiss suggestion |
| `<M-CR>` | Normal | Open panel |

## Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle trouble |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |

## Formatting & Linting

| Key | Action |
|-----|--------|
| `<leader>mp` | Format file |
| `<leader>l` | Run linter |

## Plugin Management (Lazy)

| Key | Action |
|-----|--------|
| `<leader>lu` | Update plugins |
| `<leader>lc` | Check for updates |

## Text Editing

| Key | Mode | Action |
|-----|------|--------|
| `J` | Visual | Move line down |
| `K` | Visual | Move line up |
| `<` | Visual | Indent left (repeatable) |
| `>` | Visual | Indent right (repeatable) |
| `p` | Visual | Paste without yank |
| `<C-d>` | Normal | Scroll down (centered) |
| `<C-u>` | Normal | Scroll up (centered) |
| `n` | Normal | Next search (centered) |
| `N` | Normal | Prev search (centered) |

## Tmux Integration

| Key | Action |
|-----|--------|
| `<C-h>` | Navigate left |
| `<C-j>` | Navigate down |
| `<C-k>` | Navigate up |
| `<C-l>` | Navigate right |

## Auto-import

| Key | Action |
|-----|--------|
| `<leader>ai` | Auto-import symbol under cursor |

---

Total: 84+ keybindings

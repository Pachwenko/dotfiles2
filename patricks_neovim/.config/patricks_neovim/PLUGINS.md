# Neovim Plugin Reference

## Git

| Plugin | Purpose | Key Bindings |
|--------|---------|-------------|
| **snacks.nvim** (lazygit) | Full lazygit TUI inside Neovim | `<leader>lg` open lazygit, `<leader>gf` file history, `<leader>gl` git log |
| **gitsigns.nvim** | Git diff signs in the gutter (`+`, `~`, `_`) | Signs appear automatically |
| **mini.git** | Git commands and blame | `<leader>ga` show at cursor, `<leader>gh` range history, `<leader>gd` diff source |
| **mini.diff** | Inline diff overlay | `<leader>go` toggle overlay |

**Typical workflow:** `<leader>lg` to stage/commit/push via lazygit. `<leader>gb` for quick blame. Gutter signs from gitsigns show what changed at a glance.

## LSP & Completion

| Plugin | Purpose | Key Bindings |
|--------|---------|-------------|
| **nvim-lspconfig** | Language server setup (TS, Python, Lua, JSON, HTML, CSS, Terraform, YAML, Docker, Biome, Ember) | `gd` definition, `gr` references, `gI` implementation, `<leader>rn` rename, `<leader>ca` code action, `<leader>D` type def, `<leader>ds` doc symbols, `<leader>ws` workspace symbols, `<leader>th` toggle inlay hints |
| **mason.nvim** | Auto-install LSP servers and tools | Managed via `:Mason` |
| **blink.cmp** | Fast completion engine (Rust-based) with LSP, buffer, path, and snippet sources | `<Tab>`/`<S-Tab>` navigate, `<CR>` confirm, `<C-y>` accept (default), `<C-e>` dismiss |
| **LuaSnip** | Snippet engine (loaded via friendly-snippets) | Integrated with blink.cmp |
| **lazydev.nvim** | Neovim Lua API completions | Automatic |
| **fidget.nvim** | LSP progress indicator | Automatic (bottom-right) |
| **conform.nvim** | Code formatting (Black, isort, Stylua, terraform fmt) | `<leader>fm` format buffer |

**Typical workflow:** Open a file, LSP attaches automatically. `gd` to jump to definition, `gr` to find references. `<leader>ca` for quick fixes. `<leader>fm` to format.

## Navigation & Search

| Plugin | Purpose | Key Bindings |
|--------|---------|-------------|
| **snacks.nvim** (picker) | Fast fuzzy finder for everything | `<leader>sf` files, `<leader>sg` grep, `<leader>sb` buffers, `<leader>sh` help, `<leader>sk` keymaps, `<leader>sr` resume, `<leader>s.` recent files, `<leader>st` treesitter symbols, `<leader>sw` LSP workspace symbols, `<leader>so` Obsidian search, `<leader>ss` sessions, `<leader>/` fuzzy find in buffer, `<leader>s/` grep open files, `<leader>sn` neovim config, `<leader>fc` commands, `<leader>fk` keymaps, `<leader>ch` command history |
| **neo-tree.nvim** | File tree sidebar | `<leader>tr` or `<leader>ee` toggle tree, `\` reveal current file |
| **harpoon** | Quick-access file marks | `<leader>ha` add, `<leader>hd` remove, `<leader>hm` menu, `<leader>h1`-`<leader>h5` jump to marks |
| **filenav.nvim** | File visit history (back/forward) | `<leader>bp` back, `<leader>bn` forward |
| **vim-tmux-navigator** | Seamless tmux/neovim pane navigation | `<C-h>` left, `<C-j>` down, `<C-k>` up, `<C-l>` right |

**Typical workflow:** `<leader>sf` to find a file, `<leader>sg` to search text. Pin frequent files with `<leader>ha` then jump with `<leader>h1`-`<leader>h5`. `<leader>bp`/`<leader>bn` to go back/forward in file history.

## Editing

| Plugin | Purpose | Key Bindings |
|--------|---------|-------------|
| **vim-surround** | Change/delete/add surrounding chars | `cs'"` change `'` to `"`, `ds"` delete `"`, `ysiw)` surround word with `()`, `S` in visual mode |
| **nvim-autopairs** | Auto-close brackets and quotes | Automatic |
| **nvim-ts-autotag** | Auto-close HTML/JSX tags | Automatic |
| **targets.vim** | Extra text objects (arguments, separators) | `cia` change inner argument, `da,` delete around comma-separated |
| **tidy.nvim** | Remove trailing whitespace | `<leader>tw` tidy whitespace (also runs on save) |
| **debugprint.nvim** | Insert debug print statements | `g?p`/`g?P` plain print below/above, `g?v`/`g?V` variable print below/above |

## UI & Appearance

| Plugin | Purpose | Key Bindings |
|--------|---------|-------------|
| **tokyonight.nvim** | Color scheme | Set automatically |
| **alpha-nvim** | Startup dashboard with recent sessions | `e` new file, `<leader>sf` find file, `<leader>sg` find word, `<leader>ss` all sessions, `1`-`5` load recent session, `q` quit |
| **which-key.nvim** | Shows available keymaps in popup | Appears automatically after pressing a leader key |
| **indent-blankline.nvim** | Indentation guides | Automatic |
| **smartcolumn.nvim** | Color column at 120 chars (Python/Lua) | Automatic |
| **nvim-treesitter** | Syntax highlighting and code parsing | Automatic |
| **showkeys** | Display pressed keys in floating window | `:ShowkeysToggle` |
| **tailwindcss-colorizer-cmp** | Color previews in completion menu | Automatic (with Tailwind) |
| **mini.statusline** | Minimal status line | Automatic |
| **snacks.nvim** (toggles) | Various UI toggles | `<leader>us` spelling, `<leader>uw` wrap, `<leader>uL` relative numbers, `<leader>ud` diagnostics, `<leader>ul` line numbers, `<leader>uc` conceal, `<leader>uT` treesitter, `<leader>ub` background, `<leader>uh` inlay hints |

## Notes & Markdown

| Plugin | Purpose | Key Bindings |
|--------|---------|-------------|
| **obsidian.nvim** | Obsidian vault integration (`~/Documents/notes/`) | `:ObsidianSearch`, `:ObsidianNew`, `:ObsidianToday` (also via `<leader>so`) |
| **markdown-preview.nvim** | Live markdown preview in browser | `:MarkdownPreview`, `:MarkdownPreviewToggle` |
| **todo-comments.nvim** | Highlight TODO/FIXME/NOTE comments | Automatic highlighting |

## Session & Buffer Management

| Plugin | Purpose | Key Bindings |
|--------|---------|-------------|
| **persisted.nvim** | Auto-save/restore sessions per project | `<leader>ss` browse sessions, `1`-`5` on dashboard to load recent |
| **snacks.nvim** (bufdelete) | Clean buffer deletion | `<leader>bd` delete buffer |
| **snacks.nvim** (rename) | Rename current file | `<leader>rf` rename file |

## Utility

| Plugin | Purpose |
|--------|---------|
| **luvit-meta** | Lua runtime type definitions for LSP |
| **plenary.nvim** | Shared Lua utility library (dependency) |
| **nvim-web-devicons** | File type icons (requires Nerd Font) |

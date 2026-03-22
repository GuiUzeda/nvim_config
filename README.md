# 🚀 Uzeda's Neovim Configuration

A high-performance, modular Neovim setup based on **Kickstart.nvim**, heavily customized for **Python**, **Go**, **Web Development**, and **Personal Knowledge Management (Obsidian)**.

## 🏗️ Architecture

The configuration is modularized for clarity and maintainability:

- **`init.lua`**: Main entry point, enables the experimental Lua loader.
- **`lua/options.lua`**: Editor settings (indentation, clipboard, folding, etc.).
- **`lua/keymaps.lua`**: Essential global keybindings.
- **`lua/lazy-plugins.lua`**: Plugin declarations via `lazy.nvim`.
- **`lua/kickstart/plugins/`**: Core modular plugins (LSP, Telescope, Treesitter, etc.).
- **`lua/custom/`**: Personal utility modules and domain-specific logic.

---

## 🐍 Python Development Workflow

Optimized for speed and accuracy using **Basedpyright** and **Ruff**.

### ✨ Enhanced Features:
- **Auto-Save Rename**: When you rename a symbol with `grn`, all affected buffers are automatically saved to disk.
- **Neo-tree Import Sync**: Moving or renaming a Python file in the file explorer automatically updates its references in other files.
- **Smart Venv Support**: Automatic detection of `.venv`/`venv`. Use `grv` to manually switch environments and restart the LSP.
- **Instant Linting**: **Ruff** handles linting and "Fix All" actions near-instantly.

---

## 📓 Obsidian & Knowledge Management

Deep integration for note-taking and PKM workflow.

### Keymaps:
| Key | Action | Description |
| :--- | :--- | :--- |
| `<leader>on` | **Switch** | Quick search for notes |
| `<leader>os` | **Search** | Full-text search in Obsidian vault |
| `<leader>ot` | **Today** | Open/Create today's daily note |
| `<leader>ow` | **New** | Create a new note with advanced templates |
| `<leader>oc` | **Capture** | Quick capture to Obsidian |

---

## 📂 Navigation & UI

- **Neo-tree**: Modern file explorer. Press `\` to reveal the current file.
- **Telescope**: Fuzzy finding for files, buffers, help, and LSP symbols.
- **Blink.cmp**: Blazing fast completion engine.
- **Treesitter**: Advanced syntax highlighting and code folding (enabled by default).

---

## ⌨️ Essential Keymaps

### Window & Buffer Management
- `<leader>wv` / `<leader>ws`: Vertical/Horizontal splits.
- `<leader>bn` / `<leader>bp`: Next/Previous buffer.
- `<leader>bd`: Delete current buffer.
- `<leader>bb`: Browse open buffers with Telescope.

### LSP & Refactoring
- `grn`: **Rename** (and auto-save).
- `gra`: **Code Actions**.
- `grd`: **Go to Definition**.
- `grr`: **Find References**.
- `grt`: **Type Definition**.

### Visual Mode
- `J` / `K`: Move selected lines down/up.
- `<` / `>`: Indent lines while staying in visual mode.

---

## 🛠️ Infrastructure

Managed via **Mason** for easy updates:
- **LSPs**: `basedpyright`, `ruff`, `gopls`, `ts_ls`, `lua_ls`, `sqls`, `eslint`, `tailwindcss`.
- **Tools**: `watchman` (for file changes), `stylua`, `black`, `isort`, `goimports`.

---

*Last updated: March 22, 2026*

# Implementation Plan - Overhaul to Neovim 0.12 Native Standards

## Phase 1: Environment Preparation and Core Options [checkpoint: 7a45aef]
- [x] Task: Audit current plugin list and extract configuration logic (8cdd187)
- [x] Task: Verify system prerequisites (87bb908) (luarocks installed, nvim-treesitter removed)
- [x] Task: Update `lua/options.lua` with 0.12 specific settings (e.g., `vim.o.autocomplete`) (25c7b21)
- [x] Task: Conductor - User Manual Verification 'Environment Preparation and Core Options' (Protocol in workflow.md) (7a45aef)

## Phase 2: Plugin Management Migration (`vim.pack`)
- [ ] Task: Implement the new `lua/plugins.lua` using `vim.pack.add`
- [ ] Task: Migrate core UI and utility plugins (Telescope, Mini, etc.)
- [ ] Task: Enable native `ui2` engine in `init.lua`
- [ ] Task: Conductor - User Manual Verification 'Plugin Management Migration' (Protocol in workflow.md)

## Phase 3: LSP and Tree-sitter Modernization
- [~] Task: Transition to native Tree-sitter management and parser installation (Partially complete: plugin removed)
- [ ] Task: Migrate LSP configuration to `vim.lsp.config` and `vim.lsp.enable`
- [ ] Task: Verify specialized workflows (Python, Go, Obsidian) under the new LSP/TS architecture
- [ ] Task: Conductor - User Manual Verification 'LSP and Tree-sitter Modernization' (Protocol in workflow.md)

## Phase 4: Finalization and Cleanup
- [ ] Task: Decommission `lazy.nvim` and remove bootstrap files
- [ ] Task: Final performance profiling and startup optimization
- [ ] Task: Conductor - User Manual Verification 'Finalization and Cleanup' (Protocol in workflow.md)

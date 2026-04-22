# Product Guidelines - Uzeda's Neovim Configuration

## 1. Code Style & Documentation
- **Surgical Documentation**: Code should be self-documenting. Comments are reserved for explaining "why" rather than "what," and should only be applied to complex logic or non-obvious configurations.
- **Naming Conventions**: Follow standard Neovim/Lua conventions (mostly `snake_case` for local variables and functions).
- **Modularity**: Every plugin or logical group of settings must reside in its own file to ensure high maintainability.

## 2. User Interface & Aesthetics
- **Balanced Design**: Maintain a clean and functional interface. Avoid visual clutter but ensure that essential information (LSP status, file location, Git branch) is always accessible.
- **Native-First UI**: Prioritize native Neovim UI components (like `ui2` and built-in completion) where they meet the "Balanced" aesthetic goal.

## 3. Interaction & Feedback
- **Verbose Feedback**: Background tasks, LSP actions (like renames), and system events should provide clear visual feedback. Use progress bars and toast notifications to keep the user informed of the editor's state.
- **Responsiveness**: Ensure that notifications do not block the main UI thread. All interactive operations should feel "instant."

## 4. Stability & Evolution
- **Hybrid Approach**: Leverage modern, built-in Neovim features (Bleeding Edge) while keeping stable, battle-tested plugins (like `telescope` or `mini.nvim`) for mission-critical functionality.
- **Consistency**: All new keymaps or features must follow the established mnemonic patterns (e.g., `<leader>o` for Obsidian, `gr` for LSP).

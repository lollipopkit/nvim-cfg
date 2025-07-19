# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modern Neovim configuration written in Lua, using lazy.nvim as the plugin manager. The configuration supports multi-language development with strong AI assistance, debugging capabilities, and productivity features.

## Architecture

The configuration follows a modular structure:

- `init.lua` - Entry point that loads basic settings and lazy.nvim
- `lua/configs/` - Core configuration files
  - `options.lua` - Vim options and basic settings
  - `keymaps.lua` - Key mappings and leader key configuration
- `lua/plugins/` - Plugin configurations organized by functionality
  - `init.lua` - Core plugins (theme, status line, telescope, git signs)
  - `lsp.lua` - Language Server Protocol setup with Mason
  - `cmp.lua` - Completion engine with nvim-cmp and AI integration
  - `dap.lua` - Debug Adapter Protocol configuration
  - `treesitter.lua` - Syntax highlighting and parsing
  - `conform.lua` - Code formatting setup
  - `copilot.lua` - GitHub Copilot AI assistant
  - Individual plugin files for specialized functionality

## Key Features

### Language Support

Primary languages with full LSP, debugging, and formatting support:

- **Go**: gofumpt formatting, comprehensive LSP with staticcheck
- **Rust**: rustfmt, Clippy integration, codelldb debugging
- **TypeScript/JavaScript**: prettier formatting, js-debug-adapter
- **Swift**: swiftformat, sourcekit-lsp
- **Dart**: dart format, dart LSP
- **Lua**: stylua formatting, lua-language-server
- **Bash**: shfmt formatting, bash-language-server

### Development Workflow

1. **AI-Assisted Coding**: GitHub Copilot with smart Tab completion prioritization
2. **Auto-formatting**: Format-on-save enabled for all supported languages
3. **Debugging**: Full DAP setup with auto-opening UI for Python, JS/TS, C/C++/Rust
4. **Session Management**: Automatic session save/restore for project continuity
5. **File Navigation**: Telescope fuzzy finder with hidden file support

### Key Bindings

View [KEYS.md](KEYS.md) for a comprehensive list of key bindings.

## Working with this Configuration

### Adding New Language Support

1. Add LSP server to `lua/plugins/lsp.lua` servers table
2. Add formatter to `lua/plugins/conform.lua` formatters_by_ft
3. Add treesitter parser to `lua/plugins/treesitter.lua` ensure_installed
4. Add debugging adapter to `lua/plugins/dap.lua` if needed

### Plugin Management

- Uses lazy.nvim with automatic installation on first run
- Plugins are configured with lazy loading for optimal startup time
- Lock file (`lazy-lock.json`) tracks exact plugin versions

### File Organization

- All configuration is in Lua, no Vimscript
- Chinese comments throughout configuration files
- Modular design allows easy customization of individual components
- Plugin configurations are self-contained in their respective files

### Notable Configuration Choices

- Disabled built-in Netrw in favor of nvim-tree
- Performance optimizations: lazyredraw, ttyfast, disabled swap files
- Leader key timeout set to 500ms for comfortable key sequences
- Auto-pairs and smart indentation enabled by default
- Clipboard integration with system clipboard ("unnamedplus")

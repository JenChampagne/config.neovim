# Neovim Configuration

This repository contains my personal Neovim configuration, providing a powerful and customizable editing environment with modern features.

## Features

- **Modern UI**: Tokyo Night color scheme by default, with multiple other themes available (Kanagawa, Nordic, Nightfox)
- **File Navigation**: Neo-tree file explorer sidebar with hidden files visible
- **LSP Support**: Language Server Protocol for code completion, linting, and diagnostics
- **Debugging**: Built-in debugger with DAP UI integration
- **Git Integration**: Fugitive and GitGutter for comprehensive git functionality
- **Productivity Tools**: Harpoon for quick file navigation, Undotree for undo history visualization
- **Clipboard Management**: OSC52 support for clipboard over SSH

## Plugins

This configuration uses the following key plugins:

### Core Functionality
- `lazy.nvim` - Plugin management
- `telescope.nvim` - Fuzzy finder and file search
- `nvim-tree` - File explorer sidebar
- `bufferline.nvim` - Buffer/tab navigation at bottom
- `lualine.nvim` - Status line

### LSP & Development
- `nvim-lspconfig` + `mason.nvim` - Language Server Protocol support
- `rustaceanvim` - Rust language support
- `nvim-dap` - Debugger integration
- `gitsigns.nvim` - Git diff markers in gutter

### UI & Productivity
- `tokyonight.nvim`, `kanagawa.nvim`, etc. - Color schemes
- `nvim-treesitter` - Syntax highlighting and code parsing
- `which-key.nvim` - Keybinding help modal
- `harpoon` - Quick file navigation
- `undotree` - Visualize undo history
- `sidebar.nvim` - Sidebar with various views

## Installation

1. Clone this repository:
   ```bash
   git clone --recursive .../nvim-config.git ~/.config/nvim
   ```

2. Install dependencies (Linux):
   ```bash
   sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
   ```

3. Build and install Neovim from source with helper script (hopefully not out of date):
   ```bash
   cd ~/.config/nvim
   ./easy_build_install.sh  # Follow prompts to build dependencies and Neovim
   ```

## Usage

After installation, start Neovim with:
```bash
nvim
```

### Keybindings
- `<leader>pv` - Open file explorer
- `J/K` in visual mode - Move selected lines up/down
- `<C-d>/<C-u>` - Center cursor after scrolling
- `<leader>f` - Format code (with LSP)
- `<space>b` - Toggle breakpoint for debugging
- `<F1>-<F5>` - Debugger controls (continue, step into, etc.)

## Customization

To customize this configuration:

1. Edit `init.lua` and the Lua modules in `lua/` directory
2. Add/remove plugins in `lua/lazy_packages.lua`
3. Modify keybindings in `lua/remap.lua`
4. Adjust settings in `lua/set.lua`

## License

This project is open source and available under the MIT License.


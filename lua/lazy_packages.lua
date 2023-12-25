local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Various utility functions including async coroutines.
    {
        'nvim-lua/plenary.nvim',
        version = '0.1.4',
    },

    -- Modal that displays keybind information on incomplete keybind combos.
    {
        "folke/which-key.nvim",
        version = '0.6.0',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },

    -- Tree-sitter AST syntax parsing library for plugins and highlighting.
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                modules = {},
                -- A list of parser names, or "all".
                ensure_installed = {
                    -- General plain text data file types
                    "csv",
                    "json",
                    "json5",
                    "toml",
                    "yaml",

                    -- Web
                    "http",
                    "html",
                    "css",
                    "javascript",
                    "typescript",

                    -- Server
                    "bash",
                    "cmake",
                    "make",
                    "dockerfile",
                    "ssh_config",

                    -- Git
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",

                    -- Compiled languages
                    "c",
                    "cpp",
                    "lua",
                    "ocaml",
                    "rust",
                    "sql",

                    -- Meta
                    "diff",
                    "llvm",
                    "regex",
                    "vim",
                    "vimdoc",
                },

                -- Install `ensure_installed` parsers synchronously.
                sync_install = false,

                -- Automatically install missing parsers when entering buffer.
                --! Set to false if you don't have `tree-sitter` CLI installed.
                auto_install = true,

                -- List of parsers to ignore installing, or "all".
                ignore_install = {},

                highlight = {
                    enable = true,

                    -- Disable languages from syntax highlighting.
                    --disable = { "c", "rust" },

                    -- Disable function for slow highlighting for large files.
                    disable = function(_, buf) -- `_` is language of buffer
                        local max_filesize = 100 * 1024
                        local ok, stats = pcall(
                            vim.loop.fs_stat,
                            vim.api.nvim_buf_get_name(buf)
                        )
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Instead of true it can also be a list of languages.
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    -- todo: Unsure if this is needed. To confirm.
    'nvim-treesitter/nvim-treesitter-context',

    -- Playground to visualize the Abstract Syntax Tree.
    'nvim-treesitter/playground',

    -- Special color highlighting for comments that fit certain patterns,
    -- like for todos, warnings, and ticket ids.
    {
        'iferc/better-comments.nvim',
        dependencies = { { 'nvim-treesitter/nvim-treesitter' } },
        config = function()
            require('better-comments').setup()
        end,
    },

    -- LSP for neovim Lua scripts. Does not affect other Lua code.
    {
        'folke/neodev.nvim',
        version = '2.5.2',
        opts = {},
    },

    -- Fancy git integration and ui.
    {
        'tpope/vim-fugitive',
        keys = {
            { "<leader>gs", vim.cmd.Git, mode = { "n" }, desc = "Open Fugitive" },
        },
    },

    -- Left side gutter indicators of git status changes.
    {
        'airblade/vim-gitgutter',
        lazy = false,
        keys = {
            { "<leader>gh", "<cmd>GitGutterStageHunk<CR>", mode = { "n" }, desc = "Stage Hunk" },
        },
    },

    -- Keybind for copying a URL to a file and line of a remote git repository.
    {
        'linrongbin16/gitlinker.nvim',
        config = function()
            require('gitlinker').setup()
        end,
    },

    -- Highly extensible list model with built-in file search features.
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Popup modal listing all registers contents.
    -- Keybind `""`: Opens modal.
    -- Next keybinds:
    --   `<C-j>`: scroll down
    --   `<C-k>`: scroll up
    --   `<Up>`: move up registers list
    --   `<Down>`: move down registers list
    --   `"x`: empty all registers
    -- Then hitting any other character will select and copy from
    -- the chosen register into the corresponding * register.
    {
        'gennaro-tedesco/nvim-peekup',
        version = '0.1.1',
    },

    -- Precise multi-select similar to Ctrl+D in VSCode.
    -- Keybind `<C-n>`: from normal mode will select current word,
    -- and uses current selection from visual mode.
    -- Next keybinds:
    --   `n`: get next occurrence
    --   `N`: get previous occurrence
    --   `[`: select next cursor
    --   `]`: select previous cursor
    --   `q`: skip current cursor and get last used next/prev occurrence
    --   `Q`: remove current cursor/selection
    -- Then start insert mode with one of `i`/`I`/`a`/`A`.
    {
        'mg979/vim-visual-multi',
        branch = 'master',
    },

    -- Themes
    'lewpoly/sherbet.nvim',
    'rebelot/kanagawa.nvim',
    'AlexvZyl/nordic.nvim',

    {
        'theprimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    -- 'theprimeagen/refactoring.nvim',
    'mbbill/undotree',
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    --  'folke/zen-mode.nvim',
    --  'github/copilot.vim',
    -- 'eandrju/cellular-automaton.nvim',
    'laytan/cloak.nvim',
    'mfussenegger/nvim-dap',
    'simrat39/rust-tools.nvim',
    'taybart/b64.nvim',
    --'phelipetls/jsonpath.nvim',

    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
        end,
        keys = {
            { "<leader>cc", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
        },
    },

    'sidebar-nvim/sidebar.nvim',

    -- 'boxofrox/neovim-scorched-earth',

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'simrat39/rust-tools.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    },
})

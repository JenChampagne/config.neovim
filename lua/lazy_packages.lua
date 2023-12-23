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

    -- LSP for neovim Lua scripts. Does not affect other Lua code.
    {
        'folke/neodev.nvim',
        version = '2.5.2',
        opts = {},
    },

    -- Highly extensible list model with built-in file search features.
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Popup modal listing all registers contents.
    -- Keybind `""`: Opens modal.
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

    -- themes
    'lewpoly/sherbet.nvim',
    'rebelot/kanagawa.nvim',
    'AlexvZyl/nordic.nvim',

    'Djancyp/better-comments.nvim',

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/playground',
    {
        'theprimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    -- 'theprimeagen/refactoring.nvim',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    'nvim-treesitter/nvim-treesitter-context',
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
    'airblade/vim-gitgutter',

    -- 'boxofrox/neovim-scorched-earth',

    {
        'linrongbin16/gitlinker.nvim',
        config = function()
            require('gitlinker').setup()
        end,
    },

    -- {
    --     'giusgad/pets.nvim',
    --     dependencies = {
    --         'giusgad/hologram.nvim',
    --         'MunifTanjim/nui.nvim',
    --     },
    --     config = function()
    --         require('pets').setup({
    --             -- your options here
    --         })
    --     end,
    -- },

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

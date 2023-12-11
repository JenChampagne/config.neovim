require("lazy").setup({
    'nvim-lua/plenary.nvim',

    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {'mg979/vim-visual-multi', branch = 'master'},

    -- themes
    'lewpoly/sherbet.nvim',
    'rebelot/kanagawa.nvim',
    'AlexvZyl/nordic.nvim',

    'Djancyp/better-comments.nvim',

    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-treesitter/playground',
    {
        'theprimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
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
    'laytan/cloak.nvim',
    'mfussenegger/nvim-dap',
    'simrat39/rust-tools.nvim',

    'sidebar-nvim/sidebar.nvim',
    'airblade/vim-gitgutter',

    {
        'linrongbin16/gitlinker.nvim',
        config = function()
            require('gitlinker').setup()
        end,
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'simrat39/rust-tools.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    },
})


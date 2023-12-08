-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {'mg979/vim-visual-multi', branch = 'master'}

    -- themes
    use 'lewpoly/sherbet.nvim'
    use 'rebelot/kanagawa.nvim'
    use 'AlexvZyl/nordic.nvim'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use {
        'theprimeagen/harpoon',
        branch = 'harpoon2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'laytan/cloak.nvim'
    use 'mfussenegger/nvim-dap'
    use 'simrat39/rust-tools.nvim'

    use {
        'linrongbin16/gitlinker.nvim',
        config = function()
            require('gitlinker').setup()
        end,
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
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
    }
end)


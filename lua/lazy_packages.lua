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
    -- Clipboard over SSH with OSC52 control codes support.
    {
        'ojroques/nvim-osc52',
        config = function()
            require('osc52').setup({ tmux_passthrough = true })
        end
    },

    -- Various utility functions including async coroutines.
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons', lazy = true },

    -- Modal that displays keybind information on incomplete keybind combos.
    {
        "folke/which-key.nvim",
        --version = '1.6.0',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1800
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

    -- Shows context lines at top of buffer, such as seeing the
    -- function name when it is too far away to be on the screen.
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 8,           -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 32,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 1, -- Maximum number of lines to show for a single context, default: 20
            trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'topline',        -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20,     -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },
    },

    -- Playground to visualize the Abstract Syntax Tree.
    {
        'nvim-treesitter/playground',
        event = "BufRead",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                -- Other treesitter configs...
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from the cursor
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                    highlight_deferred = true, -- Enable reverse highlighting
                }
            }
        end,
    },

    -- Special color highlighting for comments that fit certain patterns,
    -- like for todos, warnings, and ticket ids.
    {
        'iferc/better-comments.nvim',
        dependencies = { { 'nvim-treesitter/nvim-treesitter' } },
        config = function()
            require('better-comments').setup()
        end,
    },

    -- LSP server management. See configurations in `after/plugins/lsp.lua`.
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            --- Uncomment these if you want to manage LSP servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'jay-babu/mason-nvim-dap.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'mrcjkb/rustaceanvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    },

    -- LSP for neovim Lua scripts. Does not affect other Lua code.
    {
        'folke/neodev.nvim',
        --version = '2.5.2',
        opts = {},
    },

    -- Fancy git integration and ui.
    {
        'tpope/vim-fugitive',
        keys = {
            { "<leader>gs", function() vim.cmd.Git() end, mode = { "n" }, desc = "Open Fugitive" },
        },
        config = function()
            -- Automatically move git status window to bottom with small height.
            --
            -- When the commit message window is closing, something in fugitive
            -- conflicts with running vim.cmd("wincmd J") which causes the whole
            -- commit to be cancelled.
            --
            -- If there is a way to only run this move and resize once when the
            -- git status window is created, this would probably not be an issue.
            -- Until then, defer_fn works to asynchronously move the window after
            -- the conflict has passed.
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                pattern = "*",
                callback = function()
                    local bufnum = vim.api.nvim_get_current_buf()
                    local bufname = vim.api.nvim_buf_get_name(bufnum)

                    if vim.fn.expand("%:t") == "COMMIT_EDITMSG" then
                        vim.cmd("resize 24")
                    elseif string.match(bufname, "^fugitive:") then
                        local bufhead = vim.api.nvim_buf_get_text(bufnum, 0, 0, 0, 5, {})

                        if bufhead[1] == "Head:" then
                            local winnum = vim.api.nvim_get_current_win()
                            local winnr = vim.api.nvim_win_get_number(winnum)

                            vim.defer_fn(function()
                                local current_win = vim.fn.win_getid()

                                -- Go to the target window to perform its move.
                                vim.cmd(winnr .. "wincmd w")
                                vim.cmd("wincmd J")
                                vim.cmd("resize 12")

                                vim.fn.win_gotoid(current_win)
                            end, 10)
                        end
                    end
                end,
            })
        end,
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
        keys = {
            { "<leader>gul", "<cmd>GitLink<CR>",        mode = { "n", "v" } },
            { "<leader>gUl", "<cmd>GitLink!<CR>",       mode = { "n", "v" } },
            { "<leader>gub", "<cmd>GitLink blame<CR>",  mode = { "n", "v" } },
            { "<leader>gUb", "<cmd>GitLink! blame<CR>", mode = { "n", "v" } },
        },
    },

    -- Keybind for copying a URL to a file and line of a remote git repository.
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },

    -- Highly extensible list model with built-in file search features.
    {
        'nvim-telescope/telescope.nvim',
        --version = '0.1.5',
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
        --version = '0.1.1',
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
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    'lewpoly/sherbet.nvim',
    'rebelot/kanagawa.nvim',
    'AlexvZyl/nordic.nvim',

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    -- lualine_a = { 'mode' },
                    lualine_a = {},
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { { 'filename', path = 1 } },
                    -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_x = { 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { { 'filename', path = 1 } },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },

    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup {}
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        opts = {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                },
                hijack_netrw_behavior = "open_default",
            },
            window = {
                width = 28,
            },
        },
    },

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
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"

            require("dapui").setup()

            require("nvim-dap-virtual-text").setup {
                -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
                display_callback = function(variable)
                    local name = string.lower(variable.name)
                    local value = string.lower(variable.value)
                    if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
                        return "*****"
                    end

                    if #variable.value > 15 then
                        return " " .. string.sub(variable.value, 1, 15) .. "... "
                    end

                    return " " .. variable.value
                end,
            }


            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)
            vim.keymap.set("n", "<F13>", dap.restart)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
    { 'rust-lang/rust.vim' },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
    },
    'taybart/b64.nvim',
    --'phelipetls/jsonpath.nvim',

    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase").load_extension('dap')
        end,
        keys = {
            { "<leader>cc", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
        },
    },

    {
        'sidebar-nvim/sidebar.nvim',
        opts = {
            files = {
                show_hidden = true,
            },
        },
    },

    -- Conflict marker resolution plugin that also highlights diff regions.
    -- Regions are blocks of `<<<<<<<\n=======\n>>>>>>>`.
    -- Keys:
    --   `co` => keep ours (between <<<<<<< and =======)
    --   `ct` => keep theirs (between ======= and >>>>>>>)
    --   `cb` => keep both (between <<<<<<< and ======= then between ======= and >>>>>>>)
    --   `cB` => keep both (between ======= and >>>>>>> then between <<<<<<< and =======)
    --   `cn` => keep none
    --   `[x` => goto next conflict
    --   `]x` => goto previous conflict
    { 'rhysd/conflict-marker.vim' },
})

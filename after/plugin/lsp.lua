local lsp_zero = require('lsp-zero')

-- local function allow_format(servers)
--     return function(client) return vim.tbl_contains(servers, client.name) end
-- end

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set({ 'n', 'x' }, 'gq', function()
        vim.lsp.buf.format({
            async = false,
            timeout_ms = 4000,
            --filter = allow_format({ 'lua_ls', 'rust_analyzer' })
        })
    end, opts)
end)

-- Automatic formatting on save for filetypes that have a language server.
-- To write the file bypassing formatting, run ':noautocmd w' instead of ':w'.
lsp_zero.format_on_save({
    format_opts = { async = false, timeout_ms = 4000 },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['tsserver'] = { 'javascript', 'typescript' },
        ['rust_analyzer'] = { 'rust' },
    }
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'rust_analyzer',
        'tsserver',
        'eslint',
        'lua_ls',
        'bashls',
        'dockerls',
        'docker_compose_language_service',
        'angularls',
        'htmx',
        'jsonls',
        'marksman', -- markdown
        'spectral', -- openapi
        'openscad_lsp',
        'sqlls',
        'taplo',   -- toml
        'tailwindcss',
        'volar',   -- vue
        'yamlls',
        'lemminx', -- xml
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        rust_analyzer = function()
            local rust_tools = require('rust-tools')

            rust_tools.setup({
                server = {
                    on_attach = function(client, bufnr)
                        -- Hover actions
                        -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        vim.keymap.set('n', '<leader>ha', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                        vim.keymap.set('n', '<leader>ca', rust_tools.code_action_group.code_action_group,
                            { buffer = bufnr }
                        )
                    end
                }
            })
        end
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
        -- todo: what is complete vs confirm?
        -- ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

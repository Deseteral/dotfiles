require("deseteral")

--[[

require('lazy').setup({
    -- Code editing
    --
    -- LSP setup. Dependencies from lsp-zero docs (as of 2024-02-17).
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },

})

-- Setup LSP
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        'lua_ls',
        'rust_analyzer',
    },
    handlers = {
        lsp_zero.default_setup,

        tsserver = function()
            require('lspconfig').tsserver.setup({
                single_file_support = false,
                on_attach = function(client, bufnr)
                    print('hello tsserver')
                end
            })
        end,

        -- tsserver = function()
        --     -- TODO: this does not work
        --     require('lspconfig').tsserver.setup({
        --         init_options = {
        --             preferences = {
        --                 importModuleSpecifier = 'non-relative',
        --                 useAliasesForRenames = false,
        --             },
        --         },
        --
        --         -- settings = {
        --         --     typescript = {
        --         --         preferences = {
        --         --             importModuleSpecifier = 'non-relative',
        --         --             useAliasesForRenames = false,
        --         --         },
        --         --     },
        --         -- },
        --     })
        -- end,

        eslint = function()
            require('lspconfig').eslint.setup({
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })
        end,

        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end
    },
})

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['rust_analyzer'] = { 'rust' },
        ['lua_ls'] = { 'lua' },
    }
})

--]]

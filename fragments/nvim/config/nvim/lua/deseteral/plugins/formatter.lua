return {
    'stevearc/conform.nvim',

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                python = { "black" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        })

        vim.keymap.set('n', '<leader>f', function()
            conform.format({ async = true })
        end)
    end,
}

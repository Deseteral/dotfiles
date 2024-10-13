return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                autotag = { enable = true },
                ensure_installed = {
                    'bash',
                    'c',
                    'css',
                    'fish',
                    'gomod',
                    'gosum',
                    'html',
                    'javascript',
                    'json',
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'python',
                    'query',
                    'rust',
                    'sql',
                    'templ',
                    'toml',
                    'tsx',
                    'typescript',
                    'vim',
                    'vimdoc',
                    'yaml',
                },
            })
        end
    },
}

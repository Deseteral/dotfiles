return {
    {
        'crispybaccoon/evergarden',
        config = function()
            require('evergarden').setup({
                transparent_background = false,
                contrast_dark = 'hard',
            })
            -- vim.cmd.colorscheme('evergarden')
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        config = function()
            vim.opt.background = "dark"
            -- vim.opt.background = "light"
            vim.cmd.colorscheme("oxocarbon")
        end
    }
}

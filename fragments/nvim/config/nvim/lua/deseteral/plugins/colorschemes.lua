return {
    'crispybaccoon/evergarden',
    config = function()
        require('evergarden').setup({
            transparent_background = false,
            contrast_dark = 'hard',
        })

        vim.cmd.colorscheme('evergarden')
    end,
}

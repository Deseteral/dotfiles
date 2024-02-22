return {
    'echasnovski/mini.files',

    config = function()
        require('mini.files').setup({
            mappings = {
                close = '<esc>',
            },
            windows = {
                preview = true,
                width_focus = 50,
                width_nofocus = 50,
                width_preview = 50,
            },
        })

        vim.keymap.set("n", "<D-o>", function() 
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end)
    end,
}

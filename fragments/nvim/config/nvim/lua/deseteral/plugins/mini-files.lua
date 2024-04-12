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

        local open_file_picker = function()
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end

        vim.keymap.set('n', '<leader>oo', open_file_picker)

        -- Neovide keymaps (with cmd).
        vim.keymap.set('n', '<D-o>', open_file_picker)
    end,
}

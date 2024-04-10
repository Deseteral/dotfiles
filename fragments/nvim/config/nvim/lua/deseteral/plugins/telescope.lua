return {
    'nvim-telescope/telescope.nvim',

    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        vim.keymap.set("n", "<D-p>", ":Telescope git_files<CR>", { noremap = true })
    end,
}

return { 
    "numToStr/Comment.nvim",            

    lazy = false,

    config = function()
        require('Comment').setup()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                vim.opt_local.formatoptions:remove({ 'r', 'o' })
            end,
        })
    end,
}

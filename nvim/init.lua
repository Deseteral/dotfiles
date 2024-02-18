-- Vim options
vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

-- Key mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Vex<CR>:lua MiniFiles.open()<CR>", { noremap = true })
vim.keymap.set("n", "<D-p>", ":GFiles<CR>", { noremap = true })
vim.keymap.set("n", "<D-o>", ":lua MiniFiles.open()<CR>", { noremap = true })

-- Setup lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({
    -- Code editing
    { 'numToStr/Comment.nvim',            lazy = false },

    -- File manager
    { 'echasnovski/mini.files',           version = false },

    -- Fuzzy finder
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },

    -- LSP setup. Dependencies from lsp-zero docs (as of 2024-02-17).
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },

    -- Nerd font support
    { 'nvim-tree/nvim-web-devicons' },

    -- Color schemes
    { 'ayu-theme/ayu-vim' },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "bluz71/vim-moonfly-colors",        name = "moonfly", lazy = false, priority = 1000 },
    { 'kepano/flexoki-neovim',            name = 'flexoki' },
    { 'crispybaccoon/evergarden' },
})

-- Setup comments
require('Comment').setup()
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
    end,
})

-- Setup mini.files
require('mini.files').setup({
    mappings = {
        close = '<esc>',
    },
    windows = {
        preview = true,
        width_focus = 50,
        width_nofocus = 50,
        width_preview = 50,
    }
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
        ['tsserver'] = { 'javascript', 'typescript' },
        ['rust_analyzer'] = { 'rust' },
        ['lua_ls'] = { 'lua' },
    }
})

-- Color scheme
-- vim.g.ayucolor = 'dark'
-- vim.cmd.colorscheme('ayu')

-- vim.opt.background = "dark"
-- vim.cmd.colorscheme "oxocarbon"

-- vim.cmd.colorscheme('moonfly')

-- vim.cmd.colorscheme('flexoki-dark')

require 'evergarden'.setup {
    transparent_background = false,
    contrast_dark = 'hard',
}
vim.cmd.colorscheme('evergarden')

-- Neovide specific settings
if vim.g.neovide then
    vim.o.guifont = 'Berkeley Mono Variable,Symbols Nerd Font Mono:h15'

    -- Allow clipboard copy paste in neovim
    vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
    vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
    vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

    vim.keymap.set('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
    vim.keymap.set('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.keymap.set('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.keymap.set('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
end

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
vim.keymap.set("n", "<leader>pv", ":Vex<CR>",    { noremap = true })
vim.keymap.set("n", "<D-p>",      ":GFiles<CR>", { noremap = true })

-- Plugins
---- Setup lazy
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

---- Install plugins
require('lazy').setup({
    {'junegunn/fzf'},
    {'junegunn/fzf.vim'},
    
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},

    {'ayu-theme/ayu-vim'},
})

local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here 
    -- with the ones you want to install
    ensure_installed = {
        'tsserver',
        'eslint',
--      'sumneko_lua',
        'rust_analyzer',
    },
    handlers = {
        lsp_zero.default_setup,
    },
})

-- Color scheme
vim.g.ayucolor = 'dark'
vim.cmd.colorscheme('ayu')

-- Neovide specific settings
if vim.g.neovide then
    vim.o.guifont = 'Berkeley Mono:h14' 

    -- Allow clipboard copy paste in neovim
    vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
    vim.keymap.set('v', '<D-c>', '"+y') -- Copy
    vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

    vim.keymap.set('',  '<D-v>', '+p<CR>', { noremap = true, silent = true })
    vim.keymap.set('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.keymap.set('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.keymap.set('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
end


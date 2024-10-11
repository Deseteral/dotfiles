if vim.g.neovide then
    vim.o.guifont = 'Berkeley Mono,Symbols Nerd Font Mono:h15'

    -- Allow clipboard copy paste in neovim.
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

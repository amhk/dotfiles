-- options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.visualbell = true
vim.o.nojoinspaces = true
vim.o.enc = "utf-8"
vim.o.fenc = "utf-8"

-- global key mappings
vim.g.mapleader = " "
vim.keymap.set("n", "<c-n>", ":noh<cr>")
vim.keymap.set("n", "<c-j>", ":set spell!<cr>")

-- miscellaneous
vim.api.nvim_create_augroup('spellEnabledByDefault', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  group = 'spellEnabledByDefault',
  pattern = { 'gitcommit' },
  command = 'setlocal spell'
})

vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")

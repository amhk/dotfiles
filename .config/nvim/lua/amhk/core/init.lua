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
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- miscellaneous
vim.api.nvim_create_augroup('spellEnabledByDefault', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  group = 'spellEnabledByDefault',
  pattern = { 'gitcommit' },
  command = 'setlocal spell'
})

vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")

-- git
-- Run git show on the commit that added the line under cursor
function GitBlame()
  -- get the data from git
  local path = vim.api.nvim_buf_get_name(0)
  local dir = path:match("(.*)/")
  local file = path:match(".*/(.*)")
  local lineno, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local cmd = "git -C " .. dir .. " blame --porcelain -L" .. lineno .. ",+1 " .. file
  local proc = assert(io.popen(cmd, 'r'))
  local commit = proc:read("*all"):match("(%w+)")
  if commit == nil then
    return
  end
  local proc = assert(io.popen("git -C " .. dir .. " show " .. commit))
  local data = proc:read("*all")

  -- show the data in a scratch buffer
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(bufnr, "filetype", "gitcommit")
  vim.cmd"split"
  vim.cmd(string.format("buffer %d", bufnr))
  local lines = {}
  for line in string.gmatch(data, "([^\n]+)\n") do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, true, lines)
  vim.api.nvim_win_set_cursor(0, {1, 0})
end
vim.keymap.set("n", "gb", ":lua GitBlame()<cr>")

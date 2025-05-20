return {
  -- copied from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua
  "wincent/base16-nvim",
  lazy = false, -- load at start
  priority = 1000, -- load first
  config = function()
    vim.cmd([[colorscheme gruvbox-dark-hard]])

    -- make comments stand out more (use same color as for booleans)
    local boolean_color = vim.api.nvim_get_hl(0, { name = 'Boolean' })
    vim.api.nvim_set_hl(0, 'Comment', boolean_color)
  end,
}

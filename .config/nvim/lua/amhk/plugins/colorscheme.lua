return {
	"bluz71/vim-nightfly-colors",
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme nightfly]])
	end,

	-- "ellisonleao/gruvbox.nvim",
	-- priority = 1000,
	-- config = function()
	-- 	vim.cmd([[colorscheme gruvbox]])
	-- end,

	-- "navarasu/onedark.nvim",
	-- priority = 1000,
	-- config = function()
    --     require('onedark').setup {
    --         style = 'light'
    --     }
	-- 	vim.cmd([[colorscheme onedark]])
	-- end,
}

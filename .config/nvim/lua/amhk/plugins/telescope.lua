return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({})

		local keymap = vim.keymap
		keymap.set("n", "<F1>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
	end,
}

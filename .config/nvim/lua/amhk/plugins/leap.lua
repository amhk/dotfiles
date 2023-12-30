return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")
		leap.setup({})
		-- leap.add_default_mappings()

		-- local keymap = vim.keymap
		-- keymap.set("n", "§", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
	end,
}

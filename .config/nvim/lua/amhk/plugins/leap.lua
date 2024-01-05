return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")
		leap.setup({})
		-- don't call leap.add_default_mappings() because it will hijack 's'
		-- which I still use; instead add custom keybindings
		--
		-- see :h leap-custom-mappings for more info
		vim.keymap.set({"n", "x", "o"}, "<leader>s", "<Plug>(leap-forward)")
		vim.keymap.set({"n", "x", "o"}, "<leader>S", "<Plug>(leap-backward)")
	end,
}

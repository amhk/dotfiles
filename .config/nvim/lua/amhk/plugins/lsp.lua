return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		end
		local capabilities = cmp_nvim_lsp.default_capabilities()

        lspconfig["rust_analyzer"].setup({
            on_attach = on_attach,
        })

		-- local signs = { Error = "⛔", Warn = "⚠ ", Hint = "→ ", Info = "🛈 " }
		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end
	end,
}

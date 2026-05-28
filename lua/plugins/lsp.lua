vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

-- Enable lsps
vim.lsp.enable({
	"lua_ls",
})

-- Lua setup (configured to recognize the 'vim' global for your dotfiles)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Add standard keymaps for LSP actions (only when an LSP attaches to a buffer)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		local map = vim.keymap.set

		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "<leader>rn", vim.lsp.buf.rename, opts)
		map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
	end,
})

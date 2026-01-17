return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		-- Use for lsp only
		ensure_installed = {
			-- Lua
			"lua_ls",
			-- Bash
			"bashls",
			-- Golang
			"gopls",
			"templ",
		},
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				-- Use for not lsp
				ensure_installed = {
					-- Golang
					"goimports-reviser",
				},
			},
		},
		"neovim/nvim-lspconfig",
	},
}

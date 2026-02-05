return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls" },
	},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)

		-- Mason installs a broken version of htmx, install it manually!
		vim.lsp.enable("htmx")
	end,
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	keys = {
		{ "<leader>m", ":Mason<cr>", desc = "Mason" },
	},
}

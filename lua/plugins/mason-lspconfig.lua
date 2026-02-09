return {
	"mason-org/mason-lspconfig.nvim",
	lazy = false,
	opts = {
		ensure_installed = { "lua_ls" },
	},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
	end,
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	keys = {
		{ "<leader>m", ":Mason<cr>", desc = "Mason" },
	},
}

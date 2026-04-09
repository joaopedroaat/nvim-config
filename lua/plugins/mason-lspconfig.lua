return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- 1. Setup Mason base
		require("mason").setup()

		-- 2. LSPs
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
				"templ",
				"cssls",
				"tailwindcss",
				"ts_ls",
				"html",
				"jsonls",
				"taplo",
				"docker_language_server",
				"lemminx",
				"bashls",
			},
		})

		-- 3. Other tools
		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"goimports-reviser",
				"prettierd",
				"nixfmt",
				"templ",
				"shfmt",
			},
		})
	end,
	lazy = false,
	keys = {
		{ "<leader>m", ":Mason<cr>", desc = "Mason" },
	},
}

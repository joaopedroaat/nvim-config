-- LSP Servers
local lsps = {
	-- Lua
	"lua_ls",
	-- Bash
	"bashls",
	-- Golang
	"gopls",
	"templ",
	-- HTML, CSS, JS
	"html",
	"tailwindcss",
	"cssls",
	-- SQL
	"sqlls",
}

-- Formatters, Linters, DAPs, etc...
local tools = { "prettierd", "goimports-reviser" }

return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = lsps,
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
			config = function(_, opts)
				require("mason").setup(opts)
				local mr = require("mason-registry")

				-- Trigger the installation of non-LSP tools
				for _, tool in ipairs(tools) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end,
		},
		"neovim/nvim-lspconfig",
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			-- Lua
			"lua",
			-- Neovim
			"vim",
			"vimdoc",
			-- HTML, JS, CSS
			"html",
			"javascript",
			"css",
			-- Markdown
			"markdown",
			"markdown_inline",
			-- Golang
			"go",
			"templ",
			-- Json
			"json",
			"json5",
			-- Bash
			"bash",
			-- Docker
			"dockerfile",
			-- Git
			"gitignore",
			-- Sql
			"sql",
		})

		vim.api.nvim_create_user_command("TSInstallInfo", function()
			local installed = require("nvim-treesitter").get_installed()
			vim.print(installed)
		end, { desc = "List installed Tree-sitter parsers" })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "templ", "css" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		ts.install({
			"lua",
			"vim",
			"vimdoc",
			"html",
			"javascript",
			"css",
			"markdown",
			"markdown_inline",
			"go",
			"templ",
			"json",
			"json5",
			"bash",
			"dockerfile",
			"gitignore",
			"sql",
		})

		vim.api.nvim_create_user_command("TSInstallInfo", function()
			local installed = ts.get_installed()
			vim.print(installed)
		end, { desc = "List installed Tree-sitter parsers" })

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) or vim.bo[args.buf].filetype
				local is_installed = #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0

				if is_installed then
					vim.treesitter.start(args.buf, lang)
				end
			end,
		})
	end,
}

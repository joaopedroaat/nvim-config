vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").setup({})

local ensureInstalled = {
	"lua",
	"vim",
	"vimdoc",
}
local alreadyInstalled = require("nvim-treesitter.config").get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
	:filter(function(parser) return not vim.tbl_contains(alreadyInstalled, parser) end)
	:totable()
require("nvim-treesitter").install(parsersToInstall)

local function augroup(name) return vim.api.nvim_create_augroup("treesitter_" .. name, { clear = true }) end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("highlight_indent"),
	desc = "Enable treesitter highlighting/indent for the current buffer",
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("auto_install"),
	desc = "Install missing parser for this filetype, then enable highlighting/indent",
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		local available_langs = require("nvim-treesitter").get_available()
		local is_available = vim.tbl_contains(available_langs, lang)
		if not is_available then return end

		local installed_langs = require("nvim-treesitter").get_installed()
		local installed = vim.tbl_contains(installed_langs, lang)
		if installed then
			vim.treesitter.start()
			require("nvim-treesitter").indentexpr()
			return
		end

		-- Install asynchronously so the buffer stays usable while it downloads/builds
		require("nvim-treesitter").install(lang):await(function(err)
			if err or not vim.api.nvim_buf_is_valid(ev.buf) then return end
			vim.schedule(function()
				vim.treesitter.start(ev.buf)
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end)
		end)
	end,
})

vim.api.nvim_create_user_command("TSInstalled", function()
	local installed = require("nvim-treesitter").get_installed()
	table.sort(installed)
	vim.notify("Installed parsers (" .. #installed .. "):\n" .. table.concat(installed, ", "), vim.log.levels.INFO)
end, { desc = "List installed treesitter parsers" })

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

-- Some parsers (e.g. templ) ship no indents.scm query. In that case
-- nvim-treesitter's indentexpr() always returns 0, which clobbers Neovim's
-- built-in autoindent/smartindent fallback instead of deferring to it.
local function set_indentexpr(bufnr, lang)
	if lang and vim.treesitter.query.get(lang, "indents") then
		vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	else
		vim.bo[bufnr].indentexpr = ""
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("highlight_indent"),
	desc = "Enable treesitter highlighting/indent for the current buffer",
	callback = function(ev)
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation, if the language has an indent query
		set_indentexpr(ev.buf, vim.treesitter.language.get_lang(ev.match))
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
			set_indentexpr(ev.buf, lang)
			return
		end

		-- Install asynchronously so the buffer stays usable while it downloads/builds
		require("nvim-treesitter").install(lang):await(function(err)
			if err or not vim.api.nvim_buf_is_valid(ev.buf) then return end
			vim.schedule(function()
				vim.treesitter.start(ev.buf)
				set_indentexpr(ev.buf, lang)
			end)
		end)
	end,
})

vim.api.nvim_create_user_command("TSInstalled", function()
	local installed = require("nvim-treesitter").get_installed()
	table.sort(installed)
	vim.notify("Installed parsers (" .. #installed .. "):\n" .. table.concat(installed, ", "), vim.log.levels.INFO)
end, { desc = "List installed treesitter parsers" })

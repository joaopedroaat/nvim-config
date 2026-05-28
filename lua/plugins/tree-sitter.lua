vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

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

-- ==========================================
-- Treesitter Keymaps
-- ==========================================
-- Interactive menu to seamlessly install/uninstall Tree-sitter parsers
vim.keymap.set("n", "<leader>tm", function()
	-- 1. Get currently installed parsers
	local installed_list = require("nvim-treesitter.config").get_installed()
	local installed_map = {}
	for _, p in ipairs(installed_list) do
		installed_map[p] = true
	end

	-- 2. Safely get all available parsers by querying Neovim's native command-line completion
	local available = vim.fn.getcompletion("TSInstall ", "cmdline")

	if #available == 0 then
		vim.notify("Could not fetch parsers. Is Treesitter loaded?", vim.log.levels.ERROR)
		return
	end

	-- 3. Build the UI list
	local items = {}
	for _, parser in ipairs(available) do
		if installed_map[parser] then
			table.insert(items, "✓ " .. parser)
		else
			table.insert(items, "✗ " .. parser)
		end
	end

	-- 4. Sort the list: Installed (✓) at the top, then alphabetically
	table.sort(items, function(a, b)
		local a_inst = a:match("✓") ~= nil
		local b_inst = b:match("✓") ~= nil
		if a_inst ~= b_inst then return a_inst end
		return a < b
	end)

	-- 5. Trigger the UI (fzf-lua will hijack this and open a visual picker)
	vim.ui.select(items, {
		prompt = "Toggle Tree-sitter Parsers (Enter to Install/Uninstall):",
	}, function(choice)
		-- Exit if the user presses Escape
		if not choice then return end

		-- Extract the status and parser name using Lua pattern matching
		local is_installed = choice:match("✓") ~= nil
		local parser = choice:match("%s(.+)$") -- Grabs everything after the space

		-- 6. Execute the toggle
		if is_installed then
			vim.notify("Uninstalling " .. parser .. "...", vim.log.levels.WARN)
			vim.cmd("TSUninstall " .. parser)
		else
			vim.notify("Installing " .. parser .. "...", vim.log.levels.INFO)
			vim.cmd("TSInstall " .. parser)
		end
	end)
end, { desc = "Treesitter Menu (Install/Uninstall)" })

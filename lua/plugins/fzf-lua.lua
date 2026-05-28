vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

---@module "fzf-lua"
---@type fzf-lua.Config|{}
---@diagnostic disable: missing-fields
require("fzf-lua").setup({})
---@diagnostic enable: missing-fields

local map = vim.keymap.set

map("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Find Files" })

map("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "Find Help Tags" })

map("n", "<leader><leader>", function()
	require("fzf-lua").buffers()
end, { desc = "Find Buffers" })

map("n", "<leader>/", function()
	require("fzf-lua").lgrep_curbuf()
end, { desc = "Live Grep (Buffer)" })

map("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "Live Grep (Workspace)" })

map("n", "<leader>fc", function()
	require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config Files" })

map("n", "<leader>fb", function()
	require("fzf-lua").builtin()
end, { desc = "FzfLua Builtin" })

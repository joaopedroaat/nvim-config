vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

---@module "fzf-lua"
---@type fzf-lua.Config|{}
---@diagnostic disable: missing-fields
require("fzf-lua").setup({})
---@diagnostic enable: missing-fields

local map = vim.keymap.set

-- ==========================================
-- Core Search
-- ==========================================
map("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "Find Files" })
map("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "Find Help Tags" })
map("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "Find Buffers" })
map("n", "<leader>fB", function() require("fzf-lua").builtin() end, { desc = "FzfLua Builtin" })
map("n", "<leader>/", function() require("fzf-lua").lgrep_curbuf() end, { desc = "Live Grep (Buffer)" })
map("n", "<leader>fg", function() require("fzf-lua").live_grep() end, { desc = "Live Grep (Workspace)" })
map(
	"n",
	"<leader>fc",
	function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
	{ desc = "Find Config Files" }
)

-- [NEW] Essential File/Search Operations
map("n", "<leader>fr", function() require("fzf-lua").oldfiles() end, { desc = "Find Recent Files" })
map("n", "<leader>fR", function() require("fzf-lua").resume() end, { desc = "Resume Last Search" })
map("n", "<leader>fw", function() require("fzf-lua").grep_cword() end, { desc = "Search Word Under Cursor" })
map("n", "<leader>fW", function() require("fzf-lua").grep_cWORD() end, { desc = "Search WORD Under Cursor" })

-- ==========================================
-- Git Integrations
-- ==========================================
map("n", "<leader>gc", function() require("fzf-lua").git_commits() end, { desc = "Git Commits" })
map("n", "<leader>gb", function() require("fzf-lua").git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gs", function() require("fzf-lua").git_status() end, { desc = "Git Status" })

-- ==========================================
-- Neovim Internals
-- ==========================================
map("n", "<leader>fk", function() require("fzf-lua").keymaps() end, { desc = "Find Keymaps" })
map("n", "<leader>f:", function() require("fzf-lua").commands() end, { desc = "Find Commands" })
map("n", '<leader>f"', function() require("fzf-lua").registers() end, { desc = "Find Registers" })
map("n", "<leader>fm", function() require("fzf-lua").marks() end, { desc = "Find Marks" })

-- ==========================================
-- LSP Integrations
-- ==========================================
-- Note: These usually replace standard Neovim LSP mappings
map("n", "gd", function() require("fzf-lua").lsp_definitions() end, { desc = "Go to Definition" })
map("n", "gr", function() require("fzf-lua").lsp_references() end, { desc = "Go to References" })
map("n", "gI", function() require("fzf-lua").lsp_implementations() end, { desc = "Go to Implementation" })
map("n", "<leader>cs", function() require("fzf-lua").lsp_document_symbols() end, { desc = "Document Symbols" })
map("n", "<leader>cS", function() require("fzf-lua").lsp_workspace_symbols() end, { desc = "Workspace Symbols" })
map("n", "<leader>cd", function() require("fzf-lua").diagnostics_document() end, { desc = "Document Diagnostics" })
map("n", "<leader>cD", function() require("fzf-lua").diagnostics_workspace() end, { desc = "Workspace Diagnostics" })

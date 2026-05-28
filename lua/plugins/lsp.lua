-- ==========================================
-- Plugin Dependencies
-- ==========================================
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

-- ==========================================
-- Plugin Setup (Mason)
-- ==========================================
require("mason").setup({
	ui = {
		icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
})

-- ==========================================
-- Global Keymaps
-- ==========================================
local map = vim.keymap.set

-- UI
map("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open Mason" })

-- Diagnostics
map("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix Diagnostics" })

-- ==========================================
-- LSP Attach Keymaps (Buffer Local)
-- ==========================================
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local bufmap = vim.keymap.set
		local has_fzf, fzf = pcall(require, "fzf-lua")

		-- Documentation
		bufmap("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover Documentation" })
		bufmap("n", "gs", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })

		-- Navigation (Native)
		bufmap("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to Declaration" })

		-- Navigation (Fzf-Lua or Native Fallback)
		if has_fzf then
			bufmap("n", "gd", fzf.lsp_definitions, { buffer = ev.buf, desc = "Go to Definition" })
			bufmap("n", "gr", fzf.lsp_references, { buffer = ev.buf, desc = "Go to References" })
			bufmap("n", "gI", fzf.lsp_implementations, { buffer = ev.buf, desc = "Go to Implementation" })
			bufmap("n", "<leader>cs", fzf.lsp_document_symbols, { buffer = ev.buf, desc = "Document Symbols" })
			bufmap("n", "<leader>cS", fzf.lsp_workspace_symbols, { buffer = ev.buf, desc = "Workspace Symbols" })
			bufmap("n", "<leader>cd", fzf.diagnostics_document, { buffer = ev.buf, desc = "Document Diagnostics" })
			bufmap("n", "<leader>cD", fzf.diagnostics_workspace, { buffer = ev.buf, desc = "Workspace Diagnostics" })
		else
			bufmap("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })
			bufmap("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Go to References" })
			bufmap("n", "gI", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to Implementation" })
			bufmap("n", "<leader>cs", vim.lsp.buf.document_symbol, { buffer = ev.buf, desc = "Document Symbols" })
			bufmap("n", "<leader>cS", vim.lsp.buf.workspace_symbol, { buffer = ev.buf, desc = "Workspace Symbols" })
			bufmap("n", "<leader>cd", vim.diagnostic.setloclist, { buffer = ev.buf, desc = "Loclist Diagnostics" })
			bufmap("n", "<leader>cD", vim.diagnostic.setqflist, { buffer = ev.buf, desc = "Quickfix Diagnostics" })
		end

		-- Refactoring & Actions
		bufmap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })
		bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })

		-- Formatting
		bufmap(
			"n",
			"<leader>cf",
			function() vim.lsp.buf.format({ async = true }) end,
			{ buffer = ev.buf, desc = "Format Document" }
		)
	end,
})

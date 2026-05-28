vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

-- Enable lsps
vim.lsp.enable({
	"lua_ls",
})

-- Lua setup (configured to recognize the 'vim' global for your dotfiles)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- ==========================================
-- Global Diagnostic Keymaps
-- ==========================================
local map = vim.keymap.set

-- Use 'gl' to view inline errors/warnings
map("n", "gl", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

-- Quickly jump between errors
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous Diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })

-- Send all diagnostics in current file to the quickfix list
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics Quickfix" })

-- ==========================================
-- Buffer Local LSP Keymaps
-- ==========================================
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufmap = vim.keymap.set

		-- Safely check if fzf-lua is available
		local has_fzf, fzf = pcall(require, "fzf-lua")

		-- Hover and Signature Help
		bufmap("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover Documentation" })
		bufmap("n", "gs", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })

		-- Declaration (fzf doesn't handle declaration, so it's always native)
		bufmap("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to Declaration" })

		-- Smart Fallback Goto Operations & Pickers
		if has_fzf then
			-- Use Fzf-Lua
			bufmap("n", "gd", fzf.lsp_definitions, { buffer = ev.buf, desc = "Go to Definition" })
			bufmap("n", "gr", fzf.lsp_references, { buffer = ev.buf, desc = "Go to References" })
			bufmap("n", "gI", fzf.lsp_implementations, { buffer = ev.buf, desc = "Go to Implementation" })
			bufmap("n", "<leader>cs", fzf.lsp_document_symbols, { buffer = ev.buf, desc = "Document Symbols" })
			bufmap("n", "<leader>cS", fzf.lsp_workspace_symbols, { buffer = ev.buf, desc = "Workspace Symbols" })
			bufmap("n", "<leader>cd", fzf.diagnostics_document, { buffer = ev.buf, desc = "Document Diagnostics" })
			bufmap("n", "<leader>cD", fzf.diagnostics_workspace, { buffer = ev.buf, desc = "Workspace Diagnostics" })
		else
			-- Use Native Neovim Fallbacks
			bufmap("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })
			bufmap("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Go to References" })
			bufmap("n", "gI", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to Implementation" })
			bufmap("n", "<leader>cs", vim.lsp.buf.document_symbol, { buffer = ev.buf, desc = "Document Symbols" })
			bufmap("n", "<leader>cS", vim.lsp.buf.workspace_symbol, { buffer = ev.buf, desc = "Workspace Symbols" })
			bufmap(
				"n",
				"<leader>cd",
				vim.diagnostic.setloclist,
				{ buffer = ev.buf, desc = "Document Diagnostics (Loclist)" }
			)
			bufmap(
				"n",
				"<leader>cD",
				vim.diagnostic.setqflist,
				{ buffer = ev.buf, desc = "Workspace Diagnostics (Quickfix)" }
			)
		end

		-- Code Actions & Refactoring
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

local map = vim.keymap.set

map("n", "-", function()
	local status_ok, oil = pcall(require, "oil")
	if status_ok then
		oil.open()
	else
		vim.cmd("Explore")
	end
end, { desc = "Open explorer" })

-- LSP Code Action
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- LSP Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Open Diagnostics" })

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	vim.snippet.stop()
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

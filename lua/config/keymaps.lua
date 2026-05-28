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

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Split window using leader (Tmux style)
map("n", "<leader>%", "<cmd>vsplit<cr>", { desc = "Split Window Vertically" })
map("n", '<leader>"', "<cmd>split<cr>", { desc = "Split Window Horizontally" })

-- Resize window using <ctrl> arrow keys (Inversion fixed)
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", ":Lazy<cr>", { desc = "Lazy" })

-- Open tmux-sessionizer in a floating popup
map("n", "<C-f>", function()
	if vim.env.TMUX ~= nil then
		-- We are inside tmux. Talk directly to the OS to spawn the popup.
		os.execute("tmux sessionizer")
	else
		-- We are outside tmux. Trying to attach from inside nvim will break your terminal.
		vim.notify("Start tmux first to use the sessionizer!", vim.log.levels.WARN)
	end
end, { desc = "Tmux Sessionizer" })

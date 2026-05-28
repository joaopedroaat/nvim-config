vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Open Mason UI
vim.keymap.set("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open Mason" })

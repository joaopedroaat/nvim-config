vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim" },
})

require("lazydev").setup({
	library = {
		-- The Luvit (vim.uv) support you requested
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },

		-- Ensure it still finds the other plugins you installed via vim.pack
		"~/.local/share/nvim/site/pack/",
	},
})

vim.pack.add({
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})
local cmp = require("blink.cmp")
cmp.build():wait(60000)

cmp.setup({
	keymap = {
		preset = "default",
	},

	completion = {
		documentation = { auto_show = false },
	},

	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
		},
	},

	fuzzy = {
		-- Uses the fast Rust matcher (requires running :BlinkBuild first)
		implementation = "rust",
	},
})

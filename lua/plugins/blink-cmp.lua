vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" })

local cmp = require("blink.cmp")
cmp.build()

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
		implementation = "lua",
	},
})

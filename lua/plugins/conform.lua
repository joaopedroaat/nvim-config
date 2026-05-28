vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

-- Single command to toggle formatting and handle notifications
vim.api.nvim_create_user_command("ToggleFormat", function(args)
	-- Check if formatting is currently disabled
	local is_disabled = vim.g.disable_autoformat or vim.b.disable_autoformat

	if is_disabled then
		-- If it was disabled, enable it by clearing both flags
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
		vim.notify("Autoformat: ENABLED", vim.log.levels.INFO)
	else
		-- If it was enabled, disable it
		if args.bang then
			-- :ToggleFormat! disables just for the current buffer
			vim.b.disable_autoformat = true
			vim.notify("Autoformat: DISABLED (Buffer)", vim.log.levels.WARN)
		else
			-- :ToggleFormat disables globally
			vim.g.disable_autoformat = true
			vim.notify("Autoformat: DISABLED (Global)", vim.log.levels.WARN)
		end
	end
end, {
	desc = "Toggle autoformat-on-save",
	bang = true,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports-reviser" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		css = { "prettierd" },
		nix = { "nixfmt" },
		templ = { "templ" },
		bash = { "shfmt" },
		sh = { "shfmt" },
	},
	format_on_save = function(bufnr)
		local ignore_filetypes = { "sql", "java" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		-- Disable autoformat for files in a certain path
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname:match("/node_modules/") then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

-- Format file
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format()
end, { desc = "Format File" })

-- Toggle autoformat-on-save
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleFormat<CR>", { desc = "Toggle autoformat-on-save" })

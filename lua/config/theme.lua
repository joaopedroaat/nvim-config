-- Core theme function
function ColorMyPencils(color)
	color = color or "retrobox"

	-- Apply colorscheme safely
	local status_ok, _ = pcall(vim.cmd.colorscheme, color)
	if not status_ok then
		vim.notify("Colorscheme " .. color .. " not found!", vim.log.levels.WARN)
		return
	end

	-- Force transparent background to match terminal
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

-- Init default theme
ColorMyPencils()

-- User command: :ColorMyPencils [theme]
vim.api.nvim_create_user_command("ColorMyPencils", function(opts)
	local theme = opts.args ~= "" and opts.args or nil
	ColorMyPencils(theme)
end, {
	nargs = "?",
	desc = "Change colorscheme",
	complete = "color",
})

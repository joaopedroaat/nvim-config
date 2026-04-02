local function ColorMyPencils(opts)
	local color = (opts.args ~= "") and opts.args or "gruvbox-material"

	local status, _ = pcall(vim.cmd.colorscheme, color)
	if not status then
		print("Colorscheme not found: " .. color)
	end
end

-- nargs = "?" allows 0 or 1 arguments
vim.api.nvim_create_user_command("ColorMyPencils", ColorMyPencils, { nargs = "?", complete = "color" })

return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		-- directly inside the plugin declaration.
		vim.g.gruvbox_material_enable_italic = true
		vim.g.gruvbox_material_transparent_background = 1
		vim.cmd.colorscheme("gruvbox-material")
	end,
}

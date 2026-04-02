local default_colorscheme = "rose-pine"

local function ColorMyPencils(opts)
	local color = (opts and opts.args and opts.args ~= "") and opts.args or default_colorscheme

	local status, _ = pcall(vim.cmd.colorscheme, color)
	if not status then
		print("Colorscheme not found: " .. color)
	end
end

vim.api.nvim_create_user_command("ColorMyPencils", ColorMyPencils, { nargs = "?", complete = "color" })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		ColorMyPencils()
	end,
})

return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_transparent_background = 1
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		opts = {
			styles = { transparency = true },
		},
	},
}

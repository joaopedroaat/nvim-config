local map = vim.keymap.set

map("n", "-", function()
	local status_ok, oil = pcall(require, "oil")
	if status_ok then
		oil.open()
	else
		vim.cmd("Explore")
	end
end, { desc = "Open explorer" })

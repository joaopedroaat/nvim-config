return {
  "ThePrimeagen/harpoon",
  config = true,
  init = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    vim.keymap.set("n", "ma", mark.add_file, { desc = "Mark File" })
    vim.keymap.set("n", "mq", ui.toggle_quick_menu, { desc = "Find Marks" })
    vim.keymap.set("n", "mn", ui.nav_next, { desc = "Next Mark" })
    vim.keymap.set("n", "mp", ui.nav_prev, { desc = "Prev Mark" })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

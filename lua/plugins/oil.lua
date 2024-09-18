return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
  },
  lazy = false,
  keys = {
    { "-", "<cmd>Oil<cr>", { desc = "Oil" } },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}

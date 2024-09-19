return {
  "ThePrimeagen/harpoon",
  keys = {
    {
      "<leader>mq",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon Quick Menu",
    },
    {
      "<leader>ma",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon Add File",
    },
    {
      "<leader>mp",
      function()
        require("harpoon.ui").nav_prev()
      end,
      desc = "Harpoon Prev File",
    },
    {
      "<leader>mn",
      function()
        require("harpoon.ui").nav_next()
      end,
      desc = "Harpoon Next File",
    },
  },
  dependenceis = {
    "nvim-lua/plenary.nvim",
  },
}

return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Add file to harpoon",
    },
    {
      "<C-e>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Toggle harpoon quick-menu",
    },
    {
      "<leader>h",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Jump to harpoon item #1",
    },
    {
      "<leader>j",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Jump to harpoon item #2",
    },
    {
      "<leader>k",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Jump to harpoon item #3",
    },
    {
      "<leader>l",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Jump to harpoon item #4",
    },
  },
}

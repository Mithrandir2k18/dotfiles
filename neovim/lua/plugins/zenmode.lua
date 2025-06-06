return {
  "folke/zen-mode.nvim",
  lazy = true,
  keys = {
    {
      "<leader>zz",
      function()
        require("zen-mode").setup({
          window = {
            width = 90,
            options = {},
          },
        })
        require("zen-mode").toggle()
        vim.wo.wrap = false
        vim.wo.number = true
        vim.wo.rnu = true
        CustomizeColorScheme()
      end,
      { desc = "Toggle Zen mode" },
    },
    {
      "<leader>zZ",
      function()
        require("zen-mode").setup({
          window = {
            width = 80,
            options = {},
          },
        })
        require("zen-mode").toggle()
        vim.wo.wrap = false
        vim.wo.number = false
        vim.wo.rnu = false
        vim.opt.colorcolumn = "0"
        CustomizeColorScheme()
      end,
      { desc = "Toggle Zen mode, without linenumbers" },
    },
  },
}

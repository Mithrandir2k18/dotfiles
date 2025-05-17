return {
  "brenoprata10/nvim-highlight-colors",
  lazy = true,
  keys = { { "<leader>tr", "<cmd>HighlightColors Toggle<CR>", desc = "Toggle RGB value rendering" } },
  config = function()
    local rgb = require("nvim-highlight-colors")
    rgb.setup({})
    rgb.turnOff() -- turn off initially, as the first call to toggle will toggle it on
  end,
}

-- Test colors
-- #FF0000 #00FF00, #0000FF, #000000, #FFFFFF

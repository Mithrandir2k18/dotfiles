return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  -- Uncomment next line if you want to follow only stable versions
  version = "*",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("neogen").setup({
      enabled = true,
      languages = {
        python = {
          template = { annotation_convention = "google_docstrings" },
        },
      },
    })
  end,
  keys = { { '<leader>"', ":lua require('neogen').generate()<CR>", desc = "Generate docstring" } },
}

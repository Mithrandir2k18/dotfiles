return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  version = "*",
  lazy = true,
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

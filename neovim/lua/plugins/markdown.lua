return {
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = true,
    cmd = { "Markview" },
    ft = { "markdown" },
    opts = { preview = { icon_provider = "devicons", enable = false } },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "brianhuster/live-preview.nvim",
    lazy = true,
    cmd = { "LivePreview" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}

return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = ":call mkdp#util#install()",
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Plugin is already lazy loaded
		opts = { preview = { icon_provider = "devicons", enable = false } },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}

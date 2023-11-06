return {
	"brenoprata10/nvim-highlight-colors",
	lazy = true,
	keys = { { "<leader>tr", "<cmd>HighlightColorsToggle<CR>", desc = "Toggle RGB value rendering" } },
	config = function()
		require("nvim-highlight-colors").setup({})
	end,
}

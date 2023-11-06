return {
	"HampusHauffman/block.nvim",
	lazy = true,
	keys = { { "<leader>tb", "<cmd>Block<CR>", desc = "Toggle code block highlighting" } },
	config = function()
		require("block").setup({
			bg = "#000000",
			colors = {
				"#000000",
				"#111111",
				"#151515",
				"#222222",
				"#2A2A2A",
				"#333333",
				"#3F3F3F",
				"#444444",
				"#555555",
				"#666666",
				"#bbbbbb",
				"#dddddd",
				"#ffffff",
			},
		})
	end,
}

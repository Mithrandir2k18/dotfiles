return {
	"chrisgrieser/nvim-spider",
	keys = {
		-- Enable CamelCaseMotion (also works_for_snake_case)
		{
			"<leader>w",
			"<cmd>lua require('spider').motion('w')<CR>",
			{ "n", "o", "x" },
			{ desc = "CamelCase motion w" },
		},
		{
			"<leader>b",
			"<cmd>lua require('spider').motion('b')<CR>",
			{ "n", "o", "x" },
			{ desc = "CamelCase motion b" },
		},
		{
			"<leader>e",
			"<cmd>lua require('spider').motion('e')<CR>",
			{ "n", "o", "x" },
			{ desc = "CamelCase motion e" },
		},
	},
}

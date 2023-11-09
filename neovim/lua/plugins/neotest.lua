return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	keys = {
		{ "<leader>rt", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run nearest test" },
		{ "<leader>rrt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run all tests in file" },
		{ "<leader>nst", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Show testsuite in treeview" },
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-python"),
			},
		})
	end,
}

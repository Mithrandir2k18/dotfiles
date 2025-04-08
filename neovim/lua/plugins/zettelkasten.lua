return {
	"renerocksai/telekasten.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("telekasten").setup({ home = vim.fn.expand("~/repos/notes") })
	end,
	lazy = true,
	keys = {

		-- Launch panel if nothing is typed after <leader>tk
		{ "<leader>tkp", "<cmd>Telekasten panel<CR>", desc = "Telekasten panel" },

		-- Most used functions
		{ "<leader>tkf", "<cmd>Telekasten find_notes<CR>", desc = "Telekasten find" },
		{ "<leader>tkg", "<cmd>Telekasten search_notes<CR>", desc = "Telekasten search" },
		{ "<leader>tkd", "<cmd>Telekasten goto_today<CR>", desc = "Telekasten goto today" },
		{ "<leader>tkz", "<cmd>Telekasten follow_link<CR>", desc = "Telekasten follow link" },
		{ "<leader>tkn", "<cmd>Telekasten new_note<CR>", desc = "Telekasten new note" },
		{ "<leader>tkc", "<cmd>Telekasten show_calendar<CR>", desc = "Telekasten show calendar" },
		{ "<leader>tkb", "<cmd>Telekasten show_backlinks<CR>", desc = "Telekasten show backlinks" },
		{ "<leader>tkI", "<cmd>Telekasten insert_img_link<CR>", desc = "Telekasten insert image" },

		{ "<leader>tkl", "<cmd>Telekasten insert_link<CR>", desc = "Telekasten insert link" },
	},
}

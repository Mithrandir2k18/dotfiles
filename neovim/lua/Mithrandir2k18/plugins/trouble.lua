return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("trouble").setup({ icons = false })

		vim.keymap.set("n", "<leader>tx", function()
			require("trouble").toggle()
		end, { desc = "TroubleToggle" })
		vim.keymap.set("n", "<leader>tl", function()
			require("trouble").toggle()
		end, { desc = "Trouble toggle LSP references" })
		vim.keymap.set("n", "<leader>tw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Trouble workspace diagnostics" })
		vim.keymap.set("n", "<leader>td", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Trouble document diagnostics" })
		vim.keymap.set("n", "<leader>tq", function()
			require("trouble").toggle("quickfix")
		end, { desc = "Trouble toggle quickfix pane" })
		vim.keymap.set("n", "<leader>tL", function()
			require("trouble").toggle("loclist")
		end, { desc = "Trouble toggle loclist" })
	end,
}

require("nvim-tmux-navigation").setup { }
vim.keymap.set("n", "<C-w-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { desc = "Move to left pane", silent = true })
vim.keymap.set("n", "<C-w>l", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "Move to right pane", silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { desc = "Move to upper pane", silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { desc = "Move to lower pane", silent = true })
vim.keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { desc = "Move to last pane", silent = true })
vim.keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", { desc = "Move to next pane", silent = true })

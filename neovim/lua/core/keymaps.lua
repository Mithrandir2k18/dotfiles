vim.keymap.set("n", "<space>", "<NOP>")
vim.g.mapleader = " "
-- open file explorer
-- vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

-- move blocks of code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move codeblock up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move codeblock down" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Append next line to current one" }) -- stay in place when using J

--- stay in the middle of the screen
-- ...when using page-up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- ...when using search
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })
-- clear previously highlighted search
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

--- without changing buffer
-- ...when pasting
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking into register" })
-- ...when deleting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking into register" })

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank lines to clipboard" })

-- escape insert mode with jj
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })

-- unmap Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- with tmux active, jump to different project
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>",
    { desc = "Find project and open in tmux session" })

-- reformat file (see formatting.lua)
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })

-- toggle commandline height
vim.keymap.set("n", "<leader>tc", function() vim.o.cmdheight = (vim.o.cmdheight + 1) % 2 end,
    { desc = "Toggle cmdline height" })

-- quickfix (trouble) navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace inner word in file
vim.keymap.set("n", "<leader>riw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace current word with pattern" })

-- make current file executeable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executeable" })

-- open plugins file (managed with lazy)
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/dotfiles/neovim/lua/Mithrandir2k18/plugins.lua<CR>",
    { desc = "Open plugins file" });

-- shoutout(reload) current file (for reloading neovim config files)
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Shoutout current file to neovim" })

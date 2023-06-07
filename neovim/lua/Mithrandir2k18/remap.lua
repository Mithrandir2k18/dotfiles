vim.g.mapleader = " "
-- open file explorer
-- vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

-- move blocks of code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") -- stay in place when using J

--- stay in the middle of the screen
-- ...when using page-up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- ...when using search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- clear previously highlighted search
vim.keymap.set("n", "<leader>nf", "<cmd>nohlsearch<CR>")

--- without changing buffer
-- ...when pasting
vim.keymap.set("x", "<leader>p", [["_dP]])
-- ...when deleting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- escape insert mode with jj
vim.keymap.set("i", "jj", "<Esc>")

-- unmap Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- with tmux active, jump to different project
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- reformat file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- toggle commandline height
vim.keymap.set("n", "<leader>tc", function() vim.o.cmdheight = (vim.o.cmdheight + 1) % 2 end)

-- quickfix (trouble) navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace inner word in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executeable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- open plugins file (managed with lazy)
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/dotfiles/neovim/lua/Mithrandir2k18/plugins.lua<CR>");

-- shoutout(reload) current file (for reloading neovim config files)
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- overwrite buffer into current non-writeable file using sudo (with a plugin)
vim.keymap.set("c", "w!!", "SudaWrite")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, {desc = "Add file to harpoon"})
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, {desc = "Toggle harpoon quick-menu"})

vim.keymap.set("n", "<leader>h", function() ui.nav_file(1) end, {desc = "Jump to harpoon item #1"})
vim.keymap.set("n", "<leader>j", function() ui.nav_file(2) end, {desc = "Jump to harpoon item #2"})
vim.keymap.set("n", "<leader>k", function() ui.nav_file(3) end, {desc = "Jump to harpoon item #3"})
vim.keymap.set("n", "<leader>l", function() ui.nav_file(4) end, {desc = "Jump to harpoon item #4"})

local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-python")
  }
})

-- run nearest test
vim.keymap.set("n", "<leader>rt", neotest.run.run)

-- run all tests in file
vim.keymap.set("n", "<leader>rrt", function() neotest.run.run(vim.fn.expand("%")) end)


-- run nearest test
vim.keymap.set("n", "<leader>nst", neotest.summary.toggle)

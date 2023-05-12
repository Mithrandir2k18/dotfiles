local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-python")
  }
})

-- run nearest test
vim.keymap.set("n", "<leader>rt", function() neotest.run.run() end)

-- run all tests in file
vim.keymap.set("n", "<leader>rrt", function() neotest.run.run(vim.fn.expand("%")) end)



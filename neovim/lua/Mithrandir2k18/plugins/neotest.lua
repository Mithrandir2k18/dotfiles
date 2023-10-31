return {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python"
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-python")
            }
        })

        -- run nearest test
        vim.keymap.set("n", "<leader>rt", neotest.run.run, { desc = "Run nearest test" })

        -- run all tests in file
        vim.keymap.set("n", "<leader>rrt", function() neotest.run.run(vim.fn.expand("%")) end,
            { desc = "Run all tests in file" })


        -- Open treeview of testsuite with status
        vim.keymap.set("n", "<leader>nst", neotest.summary.toggle, { desc = "Show testsuite in treeview" })
    end,
}

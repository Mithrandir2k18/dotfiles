return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Search all files in project" })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Search files tracked in git" })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") }, { desc = "Grep through all files in project" })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Search help tags" })
    end,
}

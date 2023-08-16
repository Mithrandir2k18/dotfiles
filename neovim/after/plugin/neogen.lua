require('neogen').setup {
    enabled = true,
    languages = {
        python = {
            template = {
                annotation_convention = "google_docstrings"
            }
        },
    }
}

-- generate docstring
vim.keymap.set("n", "<leader>\"", ":lua require('neogen').generate()<CR>", { desc = "Generate docstring" })

return {
  "mfussenegger/nvim-lint",
  -- event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  ft = { "markdown" }, -- add filetypes to load non-lsp linters here
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>rl", lint.try_lint, { desc = "Trigger linting for current file" })
  end,
}

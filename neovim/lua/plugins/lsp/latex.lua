return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  -- needs tree-sitter-cli. install with 'cargo install tree-sitter-cli'
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "mupdf"
    vim.keymap.set({ "n" }, "<leader>ttc", ":call vimtex#compiler#compile()<CR>", { desc = "Toggle Tex Compile" })
  end,
}

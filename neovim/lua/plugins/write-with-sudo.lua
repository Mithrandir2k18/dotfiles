return {
  "lambdalisue/suda.vim",
  keys = {
    -- overwrite buffer into current non-writeable file using sudo
    { "w!!", "SudaWrite", "c", { desc = "Write write-protected file" } },
  },
}

vim.keymap.set('n', '<leader>db', "<cmd> DapToggleBreakpoint <CR>", {desc = "DebugAdapter: Toggle Breakpoint"})
vim.keymap.set('n', '<leader>dpr', function() require('dap-python').test_method() end, {desc="DebugAdapterPython: test method"})

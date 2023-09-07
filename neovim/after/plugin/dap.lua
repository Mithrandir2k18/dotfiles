local dap_python = require('dap-python')
dap_python.test_runner = 'pytest'
vim.keymap.set('n', '<leader>db', "<cmd> DapToggleBreakpoint <CR>", { desc = "DebugAdapter: Toggle Breakpoint" })
vim.keymap.set('n', '<leader>dpr', function() dap_python.test_method() end, { desc = "DebugAdapterPython: test method" })

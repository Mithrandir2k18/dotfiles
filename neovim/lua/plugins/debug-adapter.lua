return {
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            { "mfussenegger/nvim-dap" },
            { "nvim-neotest/nvim-nio" },
            { "rcarriga/nvim-dap-ui" },
        },
        ft = "python",
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            local dap_python = require('dap-python')

            dap_python.test_runner = 'pytest'
            vim.keymap.set('n', '<leader>db', "<cmd> DapToggleBreakpoint <CR>",
                { desc = "DebugAdapter: Toggle Breakpoint" })
            vim.keymap.set('n', '<leader>dpr', function() dap_python.test_method() end,
                { desc = "DebugAdapterPython: test method" })
            dap_python.setup(path)
        end
    }
}

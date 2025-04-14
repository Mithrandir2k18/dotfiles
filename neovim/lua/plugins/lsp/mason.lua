return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            PATH = "append",
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of LSPs for mason to install
            ensure_installed = {
                "lua_ls", -- lua
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "stylua", -- lua formatter
                "ruff", -- python linter+formatter
                -- "pylsp",
                -- "ruff-lsp", -- ruff interface
                -- "mypy", -- python static type checker
                "debugpy", -- python debugger
                "pyright",
                -- "isort", -- python formatter
                -- "black", -- python formatter
                -- "pylint", -- python linter
            },
        })
    end,
}

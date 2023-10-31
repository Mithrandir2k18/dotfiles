return {}

-- local lsp_zero = require("lsp-zero")

-- lsp_zero.on_attach(function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }

--     opts["desc"] = "Go to definition"
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--     opts["desc"] = "Show help in hover"
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--     opts["desc"] = ""
--     vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--     opts["desc"] = "Signature Help"
--     vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- end)

-- -- LSP configurations
-- -- lua

-- -- python

-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--     ensure_installed = { 'lua_ls', 'pylsp', 'ruff', 'ruff-lsp' },
--     handlers = {
--         lsp_zero.default_setup,
--         lua_ls = function()
--             -- local lua_opts = lsp_zero.nvim_lua_ls()
--             require('lspconfig').lua_ls.setup({
--                 settings = {
--                     Lua = {
--                         runtime = {
--                             -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                             version = 'LuaJIT',
--                         },
--                         diagnostics = {
--                             -- Get the language server to recognize the `vim` global
--                             globals = { 'vim' },
--                         },
--                         workspace = {
--                             -- Make the server aware of Neovim runtime files
--                             library = vim.api.nvim_get_runtime_file("", true),
--                             checkThirdParty = false,
--                         },
--                         -- Do not send telemetry data containing a randomized but unique identifier
--                         telemetry = {
--                             enable = false,
--                         },
--                     },
--                 },
--             })
--         end,
--         pylsp = function()
--             require('lspconfig').pylsp.setup({
--                 settings = {
--                     pylsp = {
--                         plugins = {
--                             -- linter options
--                             ruff = {
--                                 enabled = true,
--                                 extendSelect = { "I" },
--                             },
--                             -- type checker
--                             pylsp_mypy = { enabled = true },
--                             -- auto-completion options
--                             jedi_completion = { enabled = true, fuzzy = true },
--                         }
--                     }
--                 }
--             })
--         end,
--     }
-- })


-- -- lsp_zero.preset("recommended")


-- -- Fix Undefined global 'vim'
-- -- lsp_zero.nvim_workspace()


-- vim.lsp.buf.format({ formatting_options = { insertFinalNewline = true, } })


-- lsp_zero.set_preferences({
--     suggest_lsp_servers = false,
--     sign_icons = {
--         error = 'E',
--         warn = 'W',
--         hint = 'H',
--         info = 'I'
--     }
-- })


-- -- lsp_zero.setup()

-- vim.diagnostic.config({
--     virtual_text = true
-- })

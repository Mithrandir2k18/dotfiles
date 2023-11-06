return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
		require("neodev").setup({
			-- add any options here, or leave empty to use the default settings
		})
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Go to definition"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "Show code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

			opts["desc"] = "Signature Help"
			keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)


			require("lsp_signature").on_attach({
				bind = false, -- Set to false, I use this for the virtual-text only
				noice = true, -- set to true if you using noice to render markdown
				floating_window = false,
			}, bufnr)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["ruff_lsp"].setup({
			init_options = {
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					args = {},
				},
			},
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["pylsp"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				pylsp = {
					plugins = {
						ruff = {
							-- formatter + Linter + isort
							enabled = true,
							extendSelect = { "I" },
						},
						-- formatter options
						black = { enabled = false },
						autopep8 = { enabled = false },
						yapf = { enabled = false },
						-- linter options
						pylint = { enabled = false, executable = "pylint" },
						pyflakes = { enabled = false },
						pycodestyle = { enabled = false },
						-- type checker
						pylsp_mypy = { enabled = true },
						mypy = { enabled = true },
						-- auto-completion options
						jedi_completion = { fuzzy = true },
						-- import sorting
						pyls_isort = { enabled = false },
					},
				},
			},
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							-- Make the server aware of Neovim runtime files
							-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
							-- [vim.fn.stdpath("config") .. "/lua"] = true,
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}

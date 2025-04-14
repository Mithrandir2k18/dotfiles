return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"ray-x/lsp_signature.nvim",
		{ "RaafatTurki/corn.nvim" },
	},
	config = function()
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
			keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

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

			require("corn").setup()
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" } -- fallback to this if symbols are unavailable
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- lsp for c, c++
		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		local function deepcopy(orig)
			local copy = {}
			for k, v in pairs(orig) do
				if type(v) == "table" then
					copy[k] = deepcopy(v)
				else
					copy[k] = v
				end
			end
			return copy
		end

		--- pyright expects utf-16 so we have to set it for ruff
		local ruff_capabilities = deepcopy(capabilities)
		ruff_capabilities.general = ruff_capabilities.general or {}
		ruff_capabilities.general.positionEncodings = { "utf-16" }

		-- lsp for python
		lspconfig.ruff.setup({
			capabilities = ruff_capabilities,
			on_attach = on_attach,
		})

		-- lsp for python, provides features ruff is missing like go to definition
		require("lspconfig").pyright.setup({
			settings = {
				pyright = {
					-- Using Ruff's import organizer
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						-- Ignore all files for analysis to exclusively use Ruff for linting
						ignore = { "*" },
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
					defaultConfig = {
						indent_style = "space",
						indent_size = "3",
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		lspconfig.rust_analyzer.setup({
			-- Server-specific settings. See `:help lspconfig-setup`
			settings = {
				["rust-analyzer"] = {},
			},
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}

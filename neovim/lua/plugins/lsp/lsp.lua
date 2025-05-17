return {
  {
    -- set up lua_lsp to understand neovim
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          PATH = "append",
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
          bind = false,
          noice = true,
          floating_window = false,
        },
      },
      { "saghen/blink.cmp" },
      { "RaafatTurki/corn.nvim" },
    },
    config = function()
      local icons = { error = "󰅚 ", warn = "󰀪 ", hint = "󰌶 ", info = "󰋽 " }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(
              mode,
              keys,
              func,
              { buffer = event.buf, desc = "LSP: " .. desc, noremap = true, silent = true }
            )
          end

          local telescope_builtin = require("telescope.builtin")

          map("<leader>rs", ":LspRestart<CR>", "Restart LSP")
          map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame variable")
          map("<leader>ca", vim.lsp.buf.code_action, "Goto [c]ode [a]ction", { "n", "x" })

          map("gR", telescope_builtin.lsp_references, "[g]oto [R]eferences")
          map("<leader>gt", telescope_builtin.lsp_type_definitions, "[g]oto [t]ype Definition")
          map("gi", telescope_builtin.lsp_implementations, "[g]oto [i]mplementation")
          map("gd", telescope_builtin.lsp_definitions, "[g]oto [d]efinition")
          map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

          map("gO", telescope_builtin.lsp_document_symbols, "Open Document Symbols")
          map("gW", telescope_builtin.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer [D]iagnostics")
          map("<leader>d", vim.diagnostic.open_float, "Show line [d]iagnostics")

          map("K", vim.lsp.buf.hover, "Show documentation for what is under cursor")

          map("<C-h>", vim.lsp.buf.signature_help, "Signature Help", "i")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("config-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "config-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end

          require("corn").setup({
            -- icons = { error = " ", warn = " ", hint = "󰠠 ", info = " " },
            icons = icons,
            item_preprocess_func = function(item)
              return item
            end,
          })
        end,
      })

      -- Diagnostic Config
      vim.diagnostic.config({
        jump = { float = true },
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.error,
            [vim.diagnostic.severity.WARN] = icons.warn,
            [vim.diagnostic.severity.INFO] = icons.info,
            [vim.diagnostic.severity.HINT] = icons.hint,
          },
        },
        virtual_text = false,
      })

      --  create new capabilities, then broadcast that to the servers.
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- lsp for c, c++
        clangd = {},

        -- lsp for python, provides features ruff is missing like go to definition
        basedpyright = {
          settings = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
        },

        -- lsp for python
        ruff = {},

        rust_analyzer = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              telemetry = {
                enable = false,
              },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- explicitly set to an empty table (install via mason-tool-installer)
        automatic_installation = false,
        automatic_enable = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}

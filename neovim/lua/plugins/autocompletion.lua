return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    { "rafamadriz/friendly-snippets" },
    { "L3MON4D3/LuaSnip" }, -- snippet engine
    { "onsails/lspkind.nvim" }, -- emojis in recommendations
    { "folke/lazydev.nvim" },
  },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = "cargo build --release",
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = "nix run .#build-plugin --accept-flake-config",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = "default" },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     { "hrsh7th/cmp-buffer" }, -- source from buffer
--     { "FelipeLema/cmp-async-path" }, -- source from filesystem paths
--     { "L3MON4D3/LuaSnip" }, -- snippet engine
--     { "saadparwaiz1/cmp_luasnip" }, -- for autocompletion
--     { "hrsh7th/cmp-nvim-lua" }, -- nvim lua api
--     { "onsails/lspkind.nvim" }, -- emojis in recommendations
--   },
--   config = function()
--     local cmp = require("cmp")
--     local luasnip = require("luasnip")

--     local lspkind = require("lspkind")

--     -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
--     require("luasnip.loaders.from_vscode").lazy_load()
--     local cmp_select = { behavior = cmp.SelectBehavior.Select }
--     cmp.setup({
--       completion = { completeopt = "menu,menuone,preview,noselect" },
--       snippet = { -- configure how nvim-cmp interacts with snippet engine
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       sources = {
--         { name = "async_path" },
--         { name = "nvim_lsp" },
--         { name = "nvim_lua" },
--         { name = "buffer" },
--         { name = "luasnip" },
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
--         ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--       }),
--       -- configure lspkind for vs-code like pictograms in completion menu
--       formatting = {
--         format = lspkind.cmp_format({
--           maxwidth = 50,
--           ellipsis_char = "...",
--         }),
--       },
--     })
--   end,
-- }

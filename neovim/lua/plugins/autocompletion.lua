return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        { 'hrsh7th/cmp-buffer' },        -- source from buffer
        { 'FelipeLema/cmp-async-path' }, -- source from filesystem paths
        { 'L3MON4D3/LuaSnip' },          -- snippet engine
        { 'saadparwaiz1/cmp_luasnip' },  -- for autocompletion
        { 'hrsh7th/cmp-nvim-lua' },      -- nvim lua api
        { 'onsails/lspkind.nvim' },      -- emojis in recommendations
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            completion = { completeopt = "menu,menuone,preview,noselect", },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'async_path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'buffer' },
                { name = 'luasnip' },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
            }),
            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })
    end,
}

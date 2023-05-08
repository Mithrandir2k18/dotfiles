require("Mithrandir2k18.set")
require("Mithrandir2k18.remap")

local augroup = vim.api.nvim_create_augroup
local Mithrandir2k18Group = augroup('Mithrandir2k18', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = Mithrandir2k18Group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})


return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "GitFugitive" })

        local Mithrandir2k18_Fugitive = vim.api.nvim_create_augroup("Mithrandir2k18_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = Mithrandir2k18_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local pushopts = { buffer = bufnr, remap = false, desc = "Git push" }
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, pushopts)

                -- rebase always
                local pullopts = { buffer = bufnr, remap = false, desc = "Git pull --rebase" }
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({ 'pull', '--rebase' })
                end, pullopts)

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                local pushoriginopts = { buffer = bufnr, remap = false, desc = "Git pull --rebase" }
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", pushoriginopts);
            end,
        })
    end,
}

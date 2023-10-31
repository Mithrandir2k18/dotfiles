return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>xq",
            "<cmd>TroubleToggle quickfix<cr>",
            desc = "Toggle Trouble quickfix pane",
            silent = true,
            noremap = true
        }, },
    config = function()
        require("trouble").setup { icons = false, }
    end
}

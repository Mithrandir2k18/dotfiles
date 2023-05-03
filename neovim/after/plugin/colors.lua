require('vscode').setup({
    disable_background = true
})

function CustomizeColorScheme(color)
	color = color or "vscode"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", {bg = "none", fg = "gray"})
    vim.api.nvim_set_hl(0, "ColorColumn", {bg = "black"})
    vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})

end

CustomizeColorScheme()


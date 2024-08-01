return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = function(bufnr)
                    if conform.get_formatter_info("ruff_fix", bufnr).available
                    then
                        vim.keymap.set({ "n", "v" }, "<leader>F", function()
                            conform.format({
                                lsp_format = "never",
                                async = false,
                                timeout_ms = 2000,
                                formatters = {"ruff_fix"},
                            })
                        end, { desc = "Format file or range (in visual mode) with linter and unsafe fixes" })
                    end
					if
						conform.get_formatter_info("ruff_format", bufnr).available
						and conform.get_formatter_info("ruff_organize_imports", bufnr).available
					then
						return { "ruff_organize_imports", "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format file or range (in visual mode)" })

	end,
}

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-context",
	},
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = { "vimdoc", "c", "lua", "rust", "vim", "python", "cpp", "dockerfile" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			indent = {
				-- enable indentation
				enable = true,
			},
			autotag = {
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

						["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["ab"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
						["ib"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

						["ai"] = { query = "@call.outer", desc = "Select outer part of a function call/invocation" },
						["ii"] = { query = "@call.inner", desc = "Select inner part of a function call/invocation" },

						["af"] = {
							query = "@function.outer",
							desc = "Select outer part of a method/function definition",
						},
						["if"] = {
							query = "@function.inner",
							desc = "Select inner part of a method/function definition",
						},

						["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
					include_surrounding_whitespace = true,
				},

				swap = {
					enable = true,
					swap_next = {
						["<leader>sp"] = { query = "@parameter.inner", desc = "swap parameters/argument with next" },
						["<leader>sf"] = { query = "@function.outer", desc = "swap function with next" },
					},
					swap_previous = {
						["<leader>sP"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>sF"] = "@function.outer", -- swap function with previous
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]i"] = { query = "@call.outer", desc = "Next function call start" },
						["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]b"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },

						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["]I"] = { query = "@call.outer", desc = "Next function call end" },
						["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]B"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[i"] = { query = "@call.outer", desc = "Prev function call start" },
						["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
						["[c"] = { query = "@class.outer", desc = "Prev class start" },
						["[b"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						["[I"] = { query = "@call.outer", desc = "Prev function call end" },
						["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
						["[C"] = { query = "@class.outer", desc = "Prev class end" },
						["[B"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			},
		})

		-- Repeat movements:
        -- disable until https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/519 is fixed
		-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		-- Repeat movement with ; and ,

		-- vim way: ; goes to the direction you were moving.
		-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, { desc = "Repeat last move" })
		-- vim.keymap.set(
		-- 	{ "n", "x", "o" },
		-- 	",",
		-- 	ts_repeat_move.repeat_last_move_opposite,
		-- 	{ desc = "Repeat opposite of last move" }
		-- )

		-- make builtin f, F, t, T also repeatable with ; and ,
		-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
		-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
		-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
		-- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
	end,
}

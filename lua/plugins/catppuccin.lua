return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	init = function() require("catppuccin").load() end,
	opts = {
		compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
		term_colors = true,
		no_bold = true,
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = { "italic" },
			functions = { "italic" },
			keywords = { "italic" },
			booleans = { "italic" },
			types = { "italic" },
		},
		integrations = {
			nvimtree = true,
			blink_cmp = true,
			telescope = true,
			treesitter = true,
			indent_blankline = {
				enabled = true,
				scope_color = "blue",
			},
			fidget = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
		},
	},
}

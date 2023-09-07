return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,

	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false,
			no_bold = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = { "italic" },
				functions = { "italic" },
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = { "italic" },
				properties = {},
				types = { "italic" },
				operators = {},
			},
			color_overrides = {},
			custom_highlights = {},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				treesitter = true,
				notify = false,
				mini = false,
				lsp_trouble = true,
				which_key = false,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}

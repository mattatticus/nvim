return {
	"NvChad/nvim-colorizer.lua",
	ft = { "css", "scss", "sass", "html" },
	cmd = "ColorizerToggle",
	opts = {
		filetypes = { "css", "scss", "sass", "html" },
		user_default_options = {
			RGB = true,
			RRGGBB = true,
			names = true,
			RRGGBBAA = true,
			rgb_fn = true,
			hsl_fn = true,
			css = true,
			css_fn = true,
		},
	},

	{
		"folke/trouble.nvim",
		keys = {
			{
				"<leader>T",
				Cmd "TroubleToggle",
				mode = { "n" },
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ff",
				function() require("telescope.builtin").find_files(require("telescope.themes").get_ivy {}) end,
				mode = { "n" },
			},
			{
				"<leader>fg",
				function() require("telescope.builtin").live_grep(require("telescope.themes").get_ivy {}) end,
				mode = { "n" },
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		keys = {
			{
				"<leader>t",
				Cmd "ToggleTerm direction=horizontal",
				mode = { "n" },
			},
			{
				"<leader>vt",
				Cmd "ToggleTerm direction=vertical",
				mode = { "n" },
			},
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 8
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			hide_numbers = true,
			shade_filetypes = { "none" },
			autochdir = true,
		},
	},

	{
		"numToStr/Comment.nvim",
		event = { "LazyFile" },
		opts = {},
	},
}

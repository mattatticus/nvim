return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			pickers = {
				find_files = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
			},
		},

		keys = {
			{
				"<leader>o",
				require("telescope.builtin").find_files,
				mode = { "n" },
			},
			{
				"<leader>rg",
				require("telescope.builtin").live_grep,
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
			start_in_insert = false,
			hide_numbers = true,
			shade_filetypes = { "none" },
			autochdir = false,
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function() require("which-key").show { global = false } end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},

	{
		{
			"NvChad/nvim-colorizer.lua",
			name = "colorizer",
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
		},

		{
			"max397574/colortils.nvim",
			ft = { "css", "scss", "sass", "html" },
			cmd = "Colortils",
			opts = {
				border = "none",
			},
		},
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>d",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cr",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>ll",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}

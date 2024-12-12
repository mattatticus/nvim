return {
	{
		"j-hui/fidget.nvim",
		lazy = true,
		event = { "BufNew", "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			notification = {
				override_vim_notify = true,
				window = {
					winblend = 0,
					zindex = 250,
				},
			},
		},
	},

	{
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
				cmp = true,
				nvimtree = true,
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
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
			exclude = {
				filetypes = {
					"lazy",
					"lspinfo",
					"checkhealth",
					"help",
					"man",
					"gitcommit",
				},
				buftypes = {
					"terminal",
					"lspinfo",
					"help",
					"nofile",
				},
			},
			scope = { enabled = true },
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function() _ = #vim.fn.argv() == 0 and require("nvim-tree.api").tree.toggle() end,
		keys = {
			{
				"<A-s>",
				function() require("nvim-tree.api").tree.toggle() end,
				mode = { "n" },
			},
		},
		opts = {
			sort_by = "case_sensitive",
			view = {
				side = "right",
				width = 30,
				cursorline = false,
			},
			renderer = {
				root_folder_label = ":s?$?",
				group_empty = true,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "├",
						bottom = "─",
						none = " ",
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
			filters = {
				dotfiles = true,
			},
		},
	},

	{
		"rebelot/heirline.nvim",
		lazy = false,
		config = require "config.heirline",
	},
}

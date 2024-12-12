return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			-- add any options here
		},
	},

	{
		"windwp/nvim-autopairs",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			check_ts = true,
			fast_wrap = {
				map = "<A-w>",
				chars = { "{", "[", "(", '"', "'", "<" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "-",
				before_key = "z",
				after_key = "v",
				avoid_move_to_end = false,
				cursor_pos_before = true,
				keys = "aoeuidhtns',.pyfgcrl;qjkxbmwvz",
				manual_position = false,
				highlight = "Search",
				highlight_grey = "Comment",
				use_virt_lines = false,
			},
			enable_check_bracket_line = true,
		},
	},

	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>f",
				function() require("conform").format { async = true, lsp_fallback = true } end,
				mode = { "n" },
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "js-beautify" },
				html = { "html-beautify" },
				haskell = { "fourmolu" },
				css = { "css-beautify" },
				rust = { "rustfmt" },
				go = { "gofmt" },
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			check_ts = true,
			fast_wrap = {
				map = "<A-w>",
				chars = { "{", "[", "(", '"', "'", "<" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "-",
				before_key = "z",
				after_key = "v",
				avoid_move_to_end = false,
				cursor_pos_before = true,
				keys = "aoeuidhtns',.pyfgcrl;qjkxbmwvz",
				manual_position = false,
				highlight = "Search",
				highlight_grey = "Comment",
				use_virt_lines = false,
			},
			enable_check_bracket_line = true,
		},
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "CmdlineEnter", "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"nvim-tree/nvim-web-devicons",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = require "config.cmp",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },

		build = function()
			require "nvim-treesitter"
			vim.cmd "TSUpdate"
		end,
		opts = {
			ensure_installed = require("config").parsers,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
		},
		config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
	},
}

require("Keymaps")
require("Options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

local plugins = {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true,
				fast_wrap = {
					map = "<A-w>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%)%>%]%)%}%,]]=],
					end_key = "-",
					keys = "htnsdaoeuigcrlf',.pybmwvz;",
					check_comma = true,
					highlight = "Search",
					highlight_grey = "Comment",
				},
				enable_check_bracket_line = true,
			})
			npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 200
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("Catppuccin")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle" },
	},

	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<leader>t", "<cmd>ToggleTerm direction=horizontal<cr>" },
			{ "<leader>T", "<cmd>ToggleTerm direction=vertical<cr>" },
		},
		config = function()
			require("ToggleTerm")
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "BufNew",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		config = function()
			require("indent_blankline").setup({
				show_end_of_line = true,
				show_current_context = true,
				show_current_context_start = true,
				buftype_exclude = {
					"terminal",
					"packer",
					"lspinfo",
					"help",
				},
			})
		end,
	},

	{
		"vigoux/notifier.nvim",
		event = "VimEnter",
		config = function()
			require("notifier").setup()
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		ft = "css",
		cmd = "ColorizerToggle",
		config = function()
			require("Colorizer")
		end,
	},

	{
		"mhartington/formatter.nvim",
		cmd = { "FormatWrite", "Format" },
		config = function()
			require("Formatter")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("Lualine")
		end,
		event = "UIEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"catppuccin/nvim",
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = "BufNew",
		dependencies = {
			"ray-x/lsp_signature.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("Lsp")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("Treesitter")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"lukas-reineke/cmp-under-comparator",
		},
		config = function()
			require("Cmp")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = { "NvimTreeToggle" },
		config = function()
			require("NvimTree")
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({})
		end,
	},
}

require("lazy").setup(plugins, {
	root = vim.fn.stdpath("data") .. "/lazy",
	defaults = {
		lazy = true,
		version = nil,
	},

	spec = nil,
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	concurrency = nil,
	git = {
		log = { "--since=3 days ago" },
		timeout = 120,
		url_format = "https://github.com/%s.git",
	},
	dev = {

		path = "~/projects",

		patterns = {},
	},
	install = {

		missing = true,

		colorscheme = { "habamax" },
	},
	ui = {

		size = { width = 0.8, height = 0.8 },

		border = "none",
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "鈴 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},

		browser = nil,
		throttle = 20,
		custom_keys = {

			["<localleader>l"] = function(plugin)
				require("lazy.util").float_term({ "lazygit", "log" }, {
					cwd = plugin.dir,
				})
			end,

			["<localleader>t"] = function(plugin)
				require("lazy.util").float_term(nil, {
					cwd = plugin.dir,
				})
			end,
		},
	},
	diff = {
		cmd = "git",
	},
	checker = {
		enabled = false,
		concurrency = nil,
		notify = true,
		frequency = 3600,
	},
	change_detection = {
		enabled = true,
		notify = true,
	},
	performance = {
		cache = {
			enabled = true,
			path = vim.fn.stdpath("cache") .. "/lazy/cache",
			ttl = 3600 * 24 * 5,
		},
		reset_packpath = true,
		rtp = {
			reset = true,

			paths = {},

			disabled_plugins = {},
		},
	},

	readme = {
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md", "lua/**/README.md" },
		skip_if_doc_exists = true,
	},
})

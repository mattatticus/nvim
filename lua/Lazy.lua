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
		event = "BufEnter",
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
					-- keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "Search",
					highlight_grey = "Comment",
				},
				enable_check_bracket_line = false,
			})
			npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = true, -- Force no bold
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
					notify = false,
					mini = false,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"mbbill/undotree",
        cmd = { "UndotreeToggle" }
	},

	--[[ {
		"olimorris/onedarkpro.nvim",
		event = "UiEnter",
		config = function()
			require("onedarkpro").setup({
				colors = {},
				highlights = {
					WinSeparator = { fg = "#1e222a" },
					VertSplit = { fg = "#1e222a" },
				},
				plugins = {},
				styles = {
					strings = "NONE",
					comments = "italic",
					keywords = "italic",
					functions = "italic",
					variables = "NONE",
					virtual_text = "italic",
				},
				options = {
					bold = false,
					italic = true,
					underline = true,
					undercurl = true,
					cursorline = true,
					transparency = false,
					terminal_colors = true,
					window_unfocused_color = false,
				},
			})
		end,
	}, ]]

	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<leader>t", "<cmd>ToggleTerm direction=horizontal<cr>" },
			{ "<leader>T", "<cmd>ToggleTerm direction=vertical<cr>" },
		},
		config = function()
			require("toggleterm").setup({

				size = function(term)
					if term.direction == "horizontal" then
						return 8
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,

				hide_numbers = true,
				shade_filetypes = {},
				autochdir = true,

				shade_terminals = false,

				start_in_insert = false,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,

				close_on_exit = true,
				shell = vim.o.shell,
				auto_scroll = true,

				float_opts = {},
				winbar = {
					enabled = false,
					name_formatter = function(term)
						return term.name
					end,
				},
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "VimEnter",
		config = function()
			require("Comment").setup()
		end,
	},

	{ "antoinemadec/FixCursorHold.nvim", event = "VimEnter" },

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "UiEnter",
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
		cmd = "ColorizerToggle",
		ft = "css",
		config = function()
			require("colorizer").setup({
				"*",
				css = {
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = true,
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,

					mode = "background",
				},
				html = { names = true },
			})
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
			local function lsp()
				if next(vim.lsp.buf_get_clients()) ~= nil then
					return [[力]]
				else
					return [[]]
				end
			end

			require("lualine").setup({
				options = {
					theme = "catppuccin",
					component_separators = "|",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							"filename",
							file_status = true, -- Displays file status (readonly status, modified status)
							newfile_status = false, -- Display new file status (new file means no write after created)
							path = 0, -- 0: Just the filename
							-- 1: Relative path
							-- 2: Absolute path
							-- 3: Absolute path, with tilde as the home directory
							-- 4: Filename and parent dir, with tilde as the home directory

							shorting_target = 40, -- Shortens path to leave 40 spaces in the window
							-- for other components. (terrible name, any suggestions?)
							symbols = {
								modified = "", -- Text to show when the file is modified.
								readonly = "", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "_", -- Text to show for unnamed buffers.
								newfile = "寧", -- Text to show for newly created file before first write
							},
						},
					},
					lualine_c = {
						{ lsp, color = { fg = "#d19a66" } },
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							on_click = function(_, b, _)
								if b == "l" then
									vim.cmd("cope")
								end
							end,
						},
					},
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = { "lazy", "trouble", "toggleterm", "quickfix", "nvim-tree" },
			})
		end,
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	--[[ {
		"rebelot/heirline.nvim",
		-- You can optionally lazy-load heirline on UiEnter
		-- to make sure all required plugins and colorschemes are loaded before setup
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "BufEnter",
		-- config = function()
		-- 	require("Statusline")
		-- end,
	}, ]]

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("Lsp")
		end,
	},

	"nvim-treesitter/nvim-treesitter",

	--[[ 	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" }, ]]

	{
		"hrsh7th/nvim-cmp",
		event = "BufEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("Cmp")
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

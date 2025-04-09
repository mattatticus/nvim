return {
	"folke/snacks.nvim",
	event = { "LazyFile" },

	keys = {
		-- Terminal
		{
			"<leader>t",
			function() require("snacks").terminal.toggle() end,
			desc = "ToggleTerm horizontal",
			mode = { "n", "t" },
		},

		--

		{
			"<leader>.",
			function() require("snacks").scratch() end,
			desc = "Toggle Scratch Buffer",
			mode = { "n" },
		},

		-- Picker

		{
			"<leader>o",
			function() require("snacks").picker.files() end,
			desc = "Telescope find_files",
			mode = { "n" },
		},
		{
			"<leader>rg",
			function() require("snacks").picker.grep() end,
			desc = "Telescope live_grep",
			mode = { "n" },
		},
		--
	},

	opts = {
		scope = {
			enabled = true,
			cursor = false,

			treesitter = {
				blocks = {
					enabled = true,
				},
			},

			keys = {
				textobject = {
					is = {
						min_size = 2, -- minimum size of the scope
						edge = false, -- inner scope
						cursor = false,
						treesitter = { blocks = { enabled = false } },
						desc = "inner scope",
					},

					as = {
						cursor = false,
						min_size = 2, -- minimum size of the scope
						treesitter = { blocks = { enabled = false } },
						desc = "full scope",
					},
				},

				jump = {
					["<C-t>"] = {
						min_size = 1,
						bottom = false,
						cursor = false,
						edge = true,
						desc = "jump to top edge of scope",
					},

					["<C-b>"] = {
						min_size = 1,
						bottom = true,
						cursor = false,
						edge = true,
						desc = "jump to bottom edge of scope",
					},
				},
			},
		},

		scroll = {
			enabled = true,
			animate = {
				duration = { step = 20, total = 500 },
				easing = "inOutQuad",
			},
		},

		indent = {
			enabled = true,

			chunk = {
				enabled = true,
				char = {
					corner_top = "╭",
					corner_bottom = "╰",
					arrow = "",
				},
			},
		},

		terminal = {
			win = {
				wo = {
					winbar = "",
				},
			},

			start_insert = false,
			auto_insert = false,
		},

		image = { enabled = true },

		picker = {
			prompt = "  ",
			layout = { preset = "telescope" },
		},
	},
}

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function() _ = #vim.fn.argv() == 0 and require("nvim-tree.api").tree.toggle() end,
	keys = {
		{
			"<C-s>",
			function() require("nvim-tree.api").tree.toggle() end,
			desc = "Open NvimTree",
			mode = { "n" },
		},
	},
	opts = {
		sort_by = "case_sensitive",
		view = {
			side = "right",
			width = 30,
			cursorline = true,
		},
		renderer = {
			icons = {
				glyphs = {
					default = "󰈚",
					folder = {
						default = "",
						empty = "",
						empty_open = "",
						open = "",
						symlink = "",
					},
					git = {
						unmerged = "",
						untracked = "?",
					},
				},
			},
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
}

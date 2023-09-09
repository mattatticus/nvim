return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = { "NvimTreeToggle" },
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
		filters = {
			dotfiles = true,
		},
	},
}

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		_ = #vim.fn.argv() == 0 and require("nvim-tree.api").tree.toggle()
		vim.cmd "highlight NvimTreeExecFile gui=italic,underline"
	end,
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
}

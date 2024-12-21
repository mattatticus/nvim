return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "LazyFile" },
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
}

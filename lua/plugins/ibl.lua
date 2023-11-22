return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = {
			char = "│",
		},
		exclude = {
			filetypes = {
				"lazy",
				"alpha",
				"lspinfo",
				"checkhealth",
				"help",
				"man",
				"gitcommit",
				"TelescopePrompt",
				"TelescopeResults",
			},
			buftypes = {
				"terminal",
				"lspinfo",
				"help",
                "nofile"
			},
		},
		scope = { enabled = true },
	},
}

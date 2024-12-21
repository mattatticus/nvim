return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		pickers = {
			find_files = { theme = "ivy" },
			live_grep = { theme = "ivy" },
		},
	},

	keys = {
		{
			"<leader>o",
			require("telescope.builtin").find_files,
			desc = "Telescope find_files",
			mode = { "n" },
		},
		{
			"<leader>rg",
			require("telescope.builtin").live_grep,
			desc = "Telescope live_grep",
			mode = { "n" },
		},
	},
}

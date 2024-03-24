return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>ff",
			function() require("telescope.builtin").find_files(require("telescope.themes").get_ivy {}) end,
			mode = { "n" },
		},
		{
			"<leader>fg",
			function() require("telescope.builtin").live_grep(require("telescope.themes").get_ivy {}) end,
			mode = { "n" },
		},
	},
}

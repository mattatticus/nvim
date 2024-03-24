return {
	keys = {
		{
			"<leader>T",
			function() vim.cmd "TroubleToggle" end,
			mode = { "n" },
		},
	},
	"folke/trouble.nvim",
}

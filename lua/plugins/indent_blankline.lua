return {
	"lukas-reineke/indent-blankline.nvim",
    lazy = false,

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
}

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	-- lazy = false,

	config = function()
		require("indent_blankline").setup({
			show_end_of_line = true,
			show_current_context = true,
			show_current_context_start = true,
			filetype_exclude = { "lazy", "alpha" },
			buftype_exclude = {
				"terminal",
				"lspinfo",
				"help",
			},
		})
	end,
}

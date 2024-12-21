return {
	"akinsho/toggleterm.nvim",
	keys = {
		{
			"<leader>t",
			"<cmd>ToggleTerm direction=horizontal<CR>",
			desc = "ToggleTerm horizontal",
			mode = { "n" },
		},
		{
			"<leader>vt",
			"<cmd>ToggleTerm direction=vertical<CR>",
			desc = "ToggleTerm vertical",
			mode = { "n" },
		},
	},
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 8
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		start_in_insert = false,
		hide_numbers = true,
		shade_filetypes = { "none" },
		autochdir = false,
	},
}

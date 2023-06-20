require("toggleterm").setup({

	size = function(term)
		if term.direction == "horizontal" then
			return 8
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,

	hide_numbers = true,
	shade_filetypes = {},
	autochdir = true,

	shade_terminals = false,

	start_in_insert = false,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	persist_mode = true,

	close_on_exit = true,
	shell = vim.o.shell,
	auto_scroll = true,

	float_opts = {},
	winbar = {
		enabled = false,
		name_formatter = function(term)
			return term.name
		end,
	},
})

return {
	"2kabhishek/markit.nvim",
	event = { "LazyFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		cyclic = true,
		refresh_interval = 50,
		excluded_buftypes = {},
		default_mappings = true,
		force_write_shada = false,
		excluded_filetypes = { "NvimTree" },
		builtin_marks = { "'", ".", "<", ">", "^" },
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	},
}

return {
	"windwp/nvim-autopairs",
	event = { "LazyFile" },
	opts = {
		check_ts = true,
		fast_wrap = {
			map = "<A-w>",
			chars = { "{", "[", "(", '"', "'", "<" },
			pattern = [=[[%'%"%>%]%)%}%,]]=],
			end_key = "-",
			before_key = "z",
			after_key = "v",
			avoid_move_to_end = false,
			cursor_pos_before = true,
			keys = "aoeuidhtns',.pyfgcrl;qjkxbmwvz",
			manual_position = false,
			highlight = "Search",
			highlight_grey = "Comment",
			use_virt_lines = false,
		},
		enable_check_bracket_line = true,
	},
}

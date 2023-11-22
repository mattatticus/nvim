return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true,
		fast_wrap = {
			map = "<A-w>",
			chars = { "{", "[", "(", '"', "'", "<" },
			pattern = [=[[%'%"%)%>%]%)%}%,]]=],
			end_key = "-",
			keys = "htnsdaoeuigcrlf',.pybmwvz;",
			check_comma = true,
			highlight = "Search",
			highlight_grey = "Comment",
		},
		enable_check_bracket_line = true,
	},
}

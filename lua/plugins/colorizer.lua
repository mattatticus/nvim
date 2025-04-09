return {
	"catgoose/nvim-colorizer.lua",
	name = "colorizer",
	ft = { "css", "scss", "sass", "html" },
	cmd = "ColorizerToggle",
	opts = {
		filetypes = { "css", "scss", "sass", "html" },
		user_default_options = {
			RGB = true,
			RRGGBB = true,
			names = true,
			RRGGBBAA = true,
			rgb_fn = true,
			hsl_fn = true,
			css = true,
			css_fn = true,
		},
	},
}

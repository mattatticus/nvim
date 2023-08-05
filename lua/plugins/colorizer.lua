return {
	"norcalli/nvim-colorizer.lua",
	ft = "css",
	cmd = "ColorizerToggle",
	config = function()
		require("colorizer").setup({
			"*",
			css = {
				RGB = true,
				RRGGBB = true,
				names = true,
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,

				mode = "background",
			},
			html = { names = true },
		})
	end,
}

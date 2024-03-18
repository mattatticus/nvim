return {
	"NvChad/nvim-colorizer.lua",
	ft = { "css", "scss", "sass", "html" },
	cmd = "ColorizerToggle",
	config = function()
		require("colorizer").setup {
			filetypes = { "*" },
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
		}
		vim.cmd "ColorizerAttachToBuffer"
	end,
}

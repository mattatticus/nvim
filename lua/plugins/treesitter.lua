return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufNewFile", "BufReadPost" },

	build = function() vim.cmd "TSUpdate" end,

	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"fish",
				"go",
				"haskell",
				"html",
				"javascript",
				"lua",
				"python",
				"rust",
				"scss",
				"yuck",
				"zig",
			},
			playground = {
				enable = false,
			},
			sync_install = false,
			ignore_install = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
			},
		}
	end,
}

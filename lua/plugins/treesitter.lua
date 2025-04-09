return {
	"nvim-treesitter/nvim-treesitter",
	event = { "LazyFile" },
	build = ":TSUpdate",
	init = function(plugin)
		-- Straight outta LazyVim. Idk what it does.
		require("lazy.core.loader").add_to_rtp(plugin)
		require "nvim-treesitter.query_predicates"
	end,
	opts = {
		indent = { enable = true },
		highlight = { enable = true },
		incremental_selection = { enable = true },
		ensure_installed = require("config").parsers,
	},
	config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}

return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>f",
			function() require("conform").format { async = true, lsp_fallback = true } end,
			desc = "Trigger format",
			mode = { "n" },
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			javascript = { "js-beautify" },
			html = { "html-beautify" },
			haskell = { "fourmolu" },
			css = { "css-beautify" },
			rust = { "rustfmt" },
			go = { "gofmt" },
		},
	},
}

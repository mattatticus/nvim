return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>fo",
			function() require("conform").format { async = true, lsp_fallback = true } end,
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
			css = { "css-beautify" },
			rust = { "rustfmt" },
			go = { "gofmt" },
		},
	},
}

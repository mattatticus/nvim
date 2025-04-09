return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	keys = {
		{
			"<leader>f",
			function() require("conform").format { async = true, lsp_fallback = true } end,
			desc = "Trigger format",
			mode = { "n" },
		},
	},
	opts = {
		format_after_save = {
			timeout_ms = 200,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			javascript = { "prettier" },
			html = { "prettier" },
			haskell = { "fourmolu" },
			sass = { "prettier" },
			scss = { "prettier" },
			css = { "prettier" },
			rust = { "rustfmt" },
			go = { "gofmt" },
		},
	},
}

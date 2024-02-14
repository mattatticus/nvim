return {
	"mhartington/formatter.nvim",
	keys = {
		{ "<leader>f", function() vim.cmd "Format" end },
	},
	opts = {
		filetype = {
			lua = {
				function()
					return {
						exe = "stylua",
						args = {
							"--search-parent-directories",
							"--stdin-filepath",
							vim.fn.shellescape(vim.api.nvim_buf_get_name(0), true),
							"--",
							"-",
						},
						stdin = true,
					}
				end,
			},
			haskell = {
				function()
					return {
						exe = "fourmolu",
						args = { "--no-cabal" },
						stdin = true,
					}
				end,
			},
			javascript = {
				function()
					return {
						exe = "js-beautify",
						stdin = true,
						try_node_modules = true,
					}
				end,
			},
			html = {
				function()
					return {
						exe = "html-beautify",
						stdin = 1,
					}
				end,
			},
			scss = {
				function()
					return {
						exe = "css-beautify",
						stdin = 1,
					}
				end,
			},
			css = {
				function()
					return {
						exe = "css-beautify",
						stdin = 1,
					}
				end,
			},
			cpp = {
				function()
					return {
						exe = "clang-format",
						args = { "--style='{BasedOnStyle: GNU, IndentWidth: 4}'" },
						stdin = true,
					}
				end,
			},
			c = {
				function()
					return {
						exe = "clang-format",
						args = {
							[[--style="{BasedOnStyle: GNU, IndentWidth: 4, AllowShortIfStatementsOnASingleLine: 'AllIfsAndElse'}"]],
						},
						stdin = true,
					}
				end,
			},
			rust = {
				function()
					return {
						exe = "rustfmt",
						stdin = true,
					}
				end,
			},
			go = {
				function()
					return {
						exe = "gofmt",
						stdin = true,
					}
				end,
			},
			zig = {
				function()
					return {
						exe = "zig",
						args = { "fmt", "--stdin" },
						stdin = true,
					}
				end,
			},
		},
	},
}

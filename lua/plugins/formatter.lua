return {
	"mhartington/formatter.nvim",
	cmd = { "FormatWrite", "Format" },
	config = function()
		local util = require("formatter.util")
		require("formatter").setup({
			filetype = {
				lua = {
					function()
						return {
							exe = "stylua",
							args = {
								"--search-parent-directories",
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
								"--",
								"-",
							},
							stdin = true,
						}
					end,
				},
				haskell = {
					function()
						-- return {
						-- 	exe = "stylish-haskell",
						-- 	args = {},
						-- 	stdin = true,
						-- }
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
							args = { "--style='{BasedOnStyle: GNU, IndentWidth: 4}'" },
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
		})
	end,
}

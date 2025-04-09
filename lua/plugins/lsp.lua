return {
	{
		"neovim/nvim-lspconfig",
		event = { "LazyFile" },
		dependencies = {
			"saghen/blink.cmp",

			{
				"nvimdev/lspsaga.nvim",
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
					"nvim-tree/nvim-web-devicons",
				},
				opts = {
					symbol_in_winbar = {
						delay = 200,
						show_file = false,
						hide_keyword = true,
						separator = " -> ",
					},
					lightbulb = {
						enable = false,
					},
					ui = {
						code_action = "",
					},
				},
			},

			{
				"rachartier/tiny-inline-diagnostic.nvim",
				event = { "LspAttach", "LazyFile" },
				opts = {
					preset = "ghost",
					options = {
						throttle = 0,
						enable_on_insert = true,
						multiple_diag_under_cursor = true,
						show_all_diags_on_cursorline = true,
					},
				},
			},
		},
		config = function()
			vim.diagnostic.config {
				underline = true,
				severity_sort = true,
				virtual_text = false,
				update_in_insert = true,
				signs = {
					text = require("config").diagnostic_icons,
				},
			}

			local lspconfig = require "lspconfig"
			local caps = vim.lsp.protocol.make_client_capabilities()
			caps = require("blink.cmp").get_lsp_capabilities(caps)

			lspconfig.emmet_ls.setup {
				capabilities = caps,
				filetypes = { "html" },
				root_dir = function(_) return vim.fn.getcwd() end,
			}

			lspconfig.lua_ls.setup {
				capabilities = caps,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = {
								"?.lua",
								"?/init.lua",
								vim.fn.expand "~/.luarocks/share/lua/5.4/?.lua",
								vim.fn.expand "~/.luarocks/share/lua/5.4/?/init.lua",
								"/usr/share/lua/5.4/?.lua",
								"/usr/share/lua/5.4/?/init.lua",
							},
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand "$VIMRUNTIME/lua"] = true,
								[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
							},
						},
					},
				},
			}

			lspconfig.clangd.setup {
				cmd = { "clangd", "--background-index=0" },
				capabilities = caps,
			}

			lspconfig.hls.setup {
				cmd = { "haskell-language-server-wrapper", "--lsp" },
				capabilities = caps,
				settings = {
					haskell = {
						formattingProvider = "stylish-haskell",
					},
				},
			}

			local servers = {
				"zls",
				"cssls",
				"gopls",
				"ts_ls",
				"asm_lsp",
				"pyright",
				"glsl_analyzer",
				"rust_analyzer",
			}

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					capabilities = caps,
				}
			end
		end,
	},
}

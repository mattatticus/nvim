return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = { "VeryLazy", "LspAttach" },
		priority = 1000,
		config = function() require("tiny-inline-diagnostic").setup() end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "LazyFile" },
		config = function()
			local lsp_flags = { debounce_text_changes = 150 }

			vim.diagnostic.config {
				virtual_text = false,
				update_in_insert = true,
				underline = true,
				severity_sort = true,
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
				flags = lsp_flags,
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
				"cssls",
				"pyright",
				"rust_analyzer",
				"gopls",
				"ts_ls",
				"zls",
			}

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					flags = lsp_flags,
					capabilities = caps,
				}
			end
		end,
	},
}

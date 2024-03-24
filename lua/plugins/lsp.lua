return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile", "BufReadPost" },
	dependencies = {
		"ray-x/lsp_signature.nvim",
	},

	config = function()
		local signature = require "lsp_signature"

		local cfg = {
			debug = false,
			log_path = "/tmp/lsp_signature.log",
			verbose = false,
			bind = true,
			doc_lines = 12,
			max_height = 15,
			max_width = 80,
			noice = false,
			wrap = true,
			floating_window = true,
			floating_window_above_cur_line = true,
			floating_window_off_x = 1,
			floating_window_off_y = 0,
			close_timeout = 1000,
			fix_pos = true,
			hint_enable = true,
			hint_prefix = " ",
			hint_scheme = "String",
			hi_parameter = "LspSignatureActiveParameter",
			handler_opts = {
				border = "none",
			},

			always_trigger = false,

			auto_close_after = nil,
			extra_trigger_chars = {},
			zindex = 1000,

			padding = "  ",

			transparency = nil,
			shadow_blend = 36,
			shadow_guibg = "Black",
			timer_interval = 200,
			toggle_key = nil,
			toggle_key_flip_floatwin_setting = false,

			select_signature_key = nil,
			move_cursor_key = nil,
		}
		signature.setup(cfg)

		local on_attach = function(_, bufnr)
			vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

			signature.on_attach(cfg, bufnr)
		end

		local lsp_flags = {
			debounce_text_changes = 150,
		}

		vim.diagnostic.config {
			virtual_text = false,
			update_in_insert = true,
			underline = true,
			severity_sort = true,
		}

		local lspconfig = require "lspconfig"
		local caps = vim.lsp.protocol.make_client_capabilities()
		caps = require("cmp_nvim_lsp").default_capabilities(caps)

		lspconfig.emmet_ls.setup {
			capabilities = caps,
			filetypes = { "html" },
			root_dir = function(_) return vim.uv.cwd() end,
		}

		lspconfig.lua_ls.setup {
			on_attach = on_attach,
			capabilities = caps,
			flags = lsp_flags,
			settings = {
				Lua = {
					runtime = {
						version = "Lua 5.4",
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
			on_attach = on_attach,
			capabilities = caps,
		}

		local servers = {
			"cssls",
			"pyright",
			"rust_analyzer",
			"gopls",
			"tsserver",
			"hls",
			"zls",
		}

		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = caps,
			}
		end

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			callback = function() vim.diagnostic.open_float(nil, { focus = false }) end,
		})
	end,
}

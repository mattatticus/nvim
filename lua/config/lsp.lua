return function()
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
	-- caps = require("cmp_nvim_lsp").default_capabilities(caps)

	lspconfig.emmet_ls.setup {
		capabilities = caps,
		filetypes = { "html" },
		root_dir = function(_) return vim.fn.getcwd() end,
	}

	lspconfig.lua_ls.setup {
		on_attach = on_attach,
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
		on_attach = on_attach,
		capabilities = caps,
	}

	lspconfig.hls.setup {
		cmd = { "haskell-language-server-wrapper", "--lsp" },
		on_attach = on_attach,
		capabilities = caps,
		settings = {
			haskell = {
				formattingProvider = "stylish-haskell",
			},
		},
	}

	for _, lsp in ipairs(M.servers) do
		lspconfig[lsp].setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = caps,
		}
	end
end

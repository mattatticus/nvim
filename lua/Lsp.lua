local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

local cfg = {
	debug = false,
	log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
	verbose = false,
	bind = true,
	doc_lines = 10,
	max_height = 12,
	max_width = 80,
	noice = false,
	wrap = true,
	floating_window = true,
	floating_window_above_cur_line = true,
	floating_window_off_x = 1,
	floating_window_off_y = 0,
	close_timeout = 4000,
	fix_pos = false,
	hint_enable = true,
	hint_prefix = " ",
	hint_scheme = "String",
	hint_inline = function()
		return false
	end,
	hi_parameter = "LspSignatureActiveParameter",
	handler_opts = {
		border = "none",
	},

	always_trigger = false,

	auto_close_after = nil,
	extra_trigger_chars = {},
	zindex = 200,

	padding = "",

	transparency = nil,
	shadow_blend = 36,
	shadow_guibg = "Black",
	timer_interval = 200,
	toggle_key = nil,
	toggle_key_flip_floatwin_setting = false,

	select_signature_key = nil,
	move_cursor_key = nil,
}
require("lsp_signature").setup(cfg)

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	require("lsp_signature").on_attach(cfg, bufnr)
end

local lsp_flags = {
	debounce_text_changes = 150,
}

local lspconfig = require("lspconfig")
local caps = vim.lsp.protocol.make_client_capabilities()
caps = require("cmp_nvim_lsp").default_capabilities(caps)

lspconfig.emmet_ls.setup({
	capabilities = caps,
	filetypes = { "html" },
	root_dir = function(_)
		return vim.loop.cwd()
	end,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim", "awesome", "root", "client" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					["/usr/share/awesome/lib/"] = true,
				},
			},
		},
	},
})

local servers = {
	"cssls",
	"clangd",
	"pyright",
	"emmet_ls",
	"rust_analyzer",
	"gopls",
	"jsonnet_ls",
	"tsserver",
	"hls",
	"zls",
}

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
})

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		flags = lsp_flags,
	})
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

local options = {
	autochdir = true,
	autoindent = true,
	clipboard = "unnamedplus",
	conceallevel = 0,
	cursorline = true,
	expandtab = true,
	hidden = true,
	laststatus = 3,
	lazyredraw = true,
	number = true,
	relativenumber = true,
	ruler = true,
	scrolloff = 8,
	shadafile = "NONE",
	shiftwidth = 4,
	showmode = false,
	sidescrolloff = 10,
	signcolumn = "yes",
	smartindent = true,
	smarttab = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 4,
	termguicolors = true,
	updatecount = 0,
	updatetime = 400,
	wrap = false,
	fsync = false,
	mouse = "nvi",
	mousescroll = "ver:0,hor:0",
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.timeout = true
vim.o.timeoutlen = 500

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.lsp.log.set_level(vim.log.levels.OFF)

local options = {
	updatecount = 0,
	relativenumber = true,
	number = true,
	ruler = true,
	laststatus = 3,
	signcolumn = "yes",
	hidden = true,
	autochdir = true,
	showmode = false,
	splitright = true,
	splitbelow = true,
	clipboard = "unnamedplus",
	wrap = false,
	conceallevel = 0,
	tabstop = 4,
	scrolloff = 8,
	sidescrolloff = 10,
	shiftwidth = 4,
	smarttab = true,
	expandtab = true,
	smartindent = true,
	autoindent = true,
	updatetime = 200,
	timeoutlen = 400,
	cursorline = true,
	termguicolors = true,
	lazyredraw = true,
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.timeout = true
vim.o.timeoutlen = 500

for k, v in pairs(options) do
	vim.opt[k] = v
end

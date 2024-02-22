-- vim.loader.enable()
require "config.options"
require "config.keymaps"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
	install = { colorscheme = { "catppuccin" } },
	defaults = { lazy = true },
	ui = {
		border = "none",
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
	git = {
		timeout = 500,
	},
	checker = { enabled = true },
	debug = false,
})

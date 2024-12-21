vim.loader.enable()

require "config"

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

local Event = require "lazy.core.handler.event"
Event.mappings.LazyFile = {
	id = "LazyFile",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
}
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

require("lazy").setup("plugins", {
	install = { colorscheme = { "catppuccin" } },
	dashboard = { enabled = true },
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
	checker = { enabled = false },
	debug = false,
})

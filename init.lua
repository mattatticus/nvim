vim.loader.enable()

require("config.options")
require("config.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- load lazy
require("lazy").setup("plugins", {
	install = { colorscheme = { "catppuccin" } },
	defaults = { lazy = true },
	ui = {
		border = "none",
	},
	checker = { enabled = true },
	debug = false,
})

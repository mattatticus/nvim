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

local function lazy_file()
	local use_lazy_file = vim.fn.argc(-1) > 0

	-- Add support for the LazyFile event
	local Event = require "lazy.core.handler.event"

	if use_lazy_file then
		-- We'll handle delayed execution of events ourselves
		Event.mappings.LazyFile = { id = "LazyFile", event = "User", pattern = "LazyFile" }
		Event.mappings["User LazyFile"] = Event.mappings.LazyFile
	else
		-- Don't delay execution of LazyFile events, but let lazy know about the mapping
		Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
		Event.mappings["User LazyFile"] = Event.mappings.LazyFile
		return
	end

	local events = {}

	local done = false
	local function load()
		if #events == 0 or done then return end
		done = true
		vim.api.nvim_del_augroup_by_name "lazy_file"

		local skips = {}
		for _, event in ipairs(events) do
			skips[event.event] = skips[event.event] or Event.get_augroups(event.event)
		end

		vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
		for _, event in ipairs(events) do
			if vim.api.nvim_buf_is_valid(event.buf) then
				Event.trigger {
					event = event.event,
					exclude = skips[event.event],
					data = event.data,
					buf = event.buf,
				}
				if vim.bo[event.buf].filetype then
					Event.trigger {
						event = "FileType",
						buf = event.buf,
					}
				end
			end
		end
		vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
		events = {}
	end

	-- schedule wrap so that nested autocmds are executed
	-- and the UI can continue rendering without blocking
	load = vim.schedule_wrap(load)

	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePre" }, {
		group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
		callback = function(event)
			table.insert(events, event)
			load()
		end,
	})
end

lazy_file()

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

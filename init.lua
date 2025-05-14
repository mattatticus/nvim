vim.loader.enable()

require "config"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

require("lazy").setup(
    "plugins",
    {
        install = { colorscheme = { "catppuccin" } },
        dashboard = { enabled = true },
        defaults = { lazy = true },
        concurrency = 4,
        ui = {
            border = "none",
        },
        change_detection = {
            enabled = true,
            notify = true,
        },
        git = {
            timeout = 500,
        },
        checker = { enabled = true },
        debug = false,
    }
)

vim.api.nvim_create_autocmd(
    "User",
    {
        pattern = { "VeryLazy" },
        callback = function()
            if vim.fn.argc(-1) == 0 then
                require "snacks".explorer()
            end
        end
    }
)

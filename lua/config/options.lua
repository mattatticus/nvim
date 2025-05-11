local options = {
    autoindent = true,

    clipboard = "unnamedplus",
    complete = "",
    conceallevel = 0,
    cursorline = true,

    expandtab = true,
    fsync = false,

    guifont = "Maple Mono NF:h14",

    hidden = true,

    laststatus = 3,

    mouse = "nv",

    mousescroll = "ver:0,hor:0",

    number = true,
    relativenumber = true,
    ruler = true,

    scrolloff = 8,
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

    -- linespace = 8,
    -- lazyredraw = true,
    -- shadafile = "NONE",
    -- updatecount = 0,
    -- updatetime = 400,

    wrap = false,
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.timeout = true
vim.o.timeoutlen = 500

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- vim.lsp.log.set_level(vim.log.levels.OFF)

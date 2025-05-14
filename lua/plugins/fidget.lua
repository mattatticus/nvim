local M = {
    lazy = false,
    "j-hui/fidget.nvim",
}

M.opts = {
    progress = {
        display = {
            progress_icon = { "dots_pulse" },
        },
    },

    notification = {
        override_vim_notify = true,
        window = {
            winblend = 0,
        },
    },
}

return M

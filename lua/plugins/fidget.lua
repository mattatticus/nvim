local M = {
    "j-hui/fidget.nvim",
    lazy = false,
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
            max_width = 60,
        },
    },
}

return M

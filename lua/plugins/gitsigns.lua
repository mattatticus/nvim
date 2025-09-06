local M = {
    "lewis6991/gitsigns.nvim",
    event = { "LazyFile" },
}

M.opts = {
    sign_priority = 100,
}

M.keys = {
    {
        '<leader>gi',
        mode = { 'n' },
        desc = "Show git hunk inline",
        function()
            local gitsigns = require "gitsigns"
            gitsigns.preview_hunk_inline()
        end,
    }
}

return M

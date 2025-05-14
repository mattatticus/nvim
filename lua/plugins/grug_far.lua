local M = {
    'MagicDuck/grug-far.nvim',
    event = { "VeryLazy" }
}

M.opts = {}

M.keys = {
    {
        mode = { "n" },
        desc = "Open Grug far",

        "<leader>/",
        function()
            require('grug-far').toggle_instance({})
        end
    }
}

return M

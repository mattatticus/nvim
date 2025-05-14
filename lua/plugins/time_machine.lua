local M = {
    "y3owk1n/time-machine.nvim",
    event = { "VeryLazy" },
}

M.opts = {
    split_opts = {
        split = "right",
        width = 50,
    }
}

M.keys = {
    {
        "<leader>u",
        function()
            require "time-machine".actions.toggle()
        end,
        mode = { "n", "v" },
        desc = "Power the Time Machine!!",
    },
}

return M

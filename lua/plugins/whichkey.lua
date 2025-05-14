local M = {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    opts = {},
}

M.keys = {
    {
        mode = { "n" },
        desc = "Buffer Local Keymaps (which-key)",

        "<leader>?",
        function()
            require("which-key").show { global = false }
        end,
    },
}

return M

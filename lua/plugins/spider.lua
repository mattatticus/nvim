local M = {
    "chrisgrieser/nvim-spider",
}

M.keys = {
    {
        "w",
        function()
            require "spider".motion("w")
        end,
        mode = { "n", "o", "x" }
    },
    {
        "e",
        function()
            require "spider".motion("e")
        end,
        mode = { "n", "o", "x" }
    },
    {
        "b",
        function()
            require "spider".motion("b")
        end,
        mode = { "n", "o", "x" }
    },
}

return M

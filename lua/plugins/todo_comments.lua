local M = {
    "folke/todo-comments.nvim",
    event = { "LazyFile" },
}

M.opts = {}

M.keys = {
    {
        mode = { "n" },
        desc = "Jump to prev diagnostic or todo comment",

        "<leader>p",
        function()
            if #vim.diagnostic.get(0) == 0 then
                require "todo-comments".jump_prev()
                return
            end

            vim.diagnostic.jump { count = -1 }
        end
    },

    {
        mode = { "n" },
        desc = "Jump to next diagnostic or todo comment",

        "<leader>n",
        function()
            if #vim.diagnostic.get(0) == 0 then
                require "todo-comments".jump_next()
                return
            end

            vim.diagnostic.jump { count = 1 }
        end
    },

}

return M

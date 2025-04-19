local M = {
    "stevearc/conform.nvim",
    event = { "LazyFile" },
}

M.keys = {
    {
        mode = { "n" },
        desc = "Trigger format",

        "<leader>f",
        function()
            require("conform").format {
                async = true,
                lsp_fallback = true
            }
        end,
    },
}

M.opts = {
    format_after_save = {
        timeout_ms = 200,
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettier" },
        html = { "prettier" },
        sass = { "prettier" },
        scss = { "prettier" },
        css = { "prettier" },
        rust = { "rustfmt" },
        go = { "gofmt" },
    },
}

return M

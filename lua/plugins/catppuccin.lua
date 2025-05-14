local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
}

function M.init()
    require("catppuccin").load()
end

M.opts = {
    term_colors = true,
    no_bold = true,

    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "italic" },
        keywords = { "italic" },
        booleans = { "italic" },
        types = { "italic" },
    },

    integrations = {
        nvimtree = true,
        blink_cmp = true,
        treesitter = true,
        which_key = true,
        lsp_saga = true,

        snacks = {
            enabled = true,
            indent_scope_color = "blue",
        },

        fidget = true,
        native_lsp = {
            enabled = true,
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },
    },
}

return M

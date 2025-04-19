local M = {
    "nvim-tree/nvim-tree.lua",
    init = function()
        _ = #vim.fn.argv() == 0 and require("nvim-tree.api").tree.toggle()
    end,

    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "j-hui/fidget.nvim",
    },
}

M.keys = {
    {
        mode = { "n" },
        desc = "Open NvimTree",

        "<C-s>",
        function()
            require("nvim-tree.api").tree.toggle()
        end,
    },
}

M.opts = {
    sort_by = "case_sensitive",
    prefer_startup_root = true,
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
        update_root = {
            enable = false,
            ignore_list = {},
        },
        exclude = false,
    },
    view = {
        side = "right",
        width = {
            min = 35,
            max = 40,
            padding = 2,
        },
        cursorline = true,
    },
    git = {
        enable = true,
    },
    renderer = {
        hidden_display = "simple",
        icons = {
            padding = "  ",
            show = {
                folder_arrow = true,
            },

            symlink_arrow = " -> ",
            git_placement = "right_align",
            modified_placement = "right_align",
            glyphs = {
                modified = "󱦹",
                default = "󰈚",
                git = {
                    -- added = "✚",
                    deleted = "✖",
                    -- dirty = "",
                    renamed = "󰁕",
                    unmerged = "",
                    untracked = "⚝",
                    ignored = "~",
                    unstaged = "",
                    staged = "",
                },
            },
        },
        root_folder_label = ":~",

        group_empty = true,
        indent_markers = {
            enable = true,
            inline_arrows = true,
        },
    },
    modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            error = "󰈸",
            warning = "",
            hint = "",
            info = "",
        },
    },
    filters = {
        dotfiles = true,
    },
}

return M

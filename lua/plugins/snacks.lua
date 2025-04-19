local M = {
    "folke/snacks.nvim",
    lazy = false,
    -- event = { "LazyFile" },
}

M.opts = {
    dashboard = {
        enabled = true,
    },

    scope = {
        enabled = true,
        cursor = false,

        treesitter = {
            blocks = {
                enabled = true,
            },
        },

        keys = {
            textobject = {
                is = {
                    min_size = 2, -- minimum size of the scope
                    edge = false, -- inner scope
                    cursor = false,
                    treesitter = { blocks = { enabled = false } },
                    desc = "inner scope",
                },

                as = {
                    cursor = false,
                    min_size = 2, -- minimum size of the scope
                    treesitter = { blocks = { enabled = false } },
                    desc = "full scope",
                },
            },

            jump = {
                ["<C-t>"] = {
                    min_size = 1,
                    bottom = false,
                    cursor = false,
                    edge = true,
                    desc = "jump to top edge of scope",
                },

                ["<C-b>"] = {
                    min_size = 1,
                    bottom = true,
                    cursor = false,
                    edge = true,
                    desc = "jump to bottom edge of scope",
                },
            },
        },
    },

    scroll = {
        enabled = not vim.g.neovide,
        animate = {
            easing = "inOutQuad",
            duration = { step = 20, total = 500 },
        },
    },

    indent = {
        enabled = true,

        chunk = {
            enabled = true,
            char = {
                corner_top = "╭",
                corner_bottom = "╰",
                arrow = ">",
            },
        },
    },

    terminal = {
        win = {
            wo = {
                winbar = "",
            },
        },

        start_insert = false,
        auto_insert = false,
    },

    image = { enabled = true },

    picker = {
        prompt = "  ",
        layout = { preset = "telescope" },
    },
}

M.keys = {
    {
        mode = { "n" },
        desc = "Toggle Terminal",

        "<leader>t",
        function() require("snacks").terminal.toggle() end,
    },


    {
        mode = { "n" },
        desc = "Toggle Scratch Buffer",

        "<leader>.",
        function() require("snacks").scratch() end,
    },


    {
        mode = { "n" },
        desc = "Telescope find_files",

        "<leader>o",
        function() require("snacks").picker.files() end,
    },
    {
        mode = { "n" },
        desc = "Telescope live_grep",

        "<leader>rg",
        function() require("snacks").picker.grep() end,
    },
}

return M

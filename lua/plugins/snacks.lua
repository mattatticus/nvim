local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
}

M.dependencies = { "nvim-tree/nvim-web-devicons" }

M.opts = {}

M.opts.lazygit = {
    enabled = true,
}

M.opts.scope = {
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
                treesitter = { blocks = { enabled = true } },
                desc = "inner scope",
            },

            as = {
                cursor = false,
                min_size = 2, -- minimum size of the scope
                treesitter = { blocks = { enabled = true } },
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
}

M.opts.indent = {
    chunk = {
        enabled = true,
        char = {
            corner_top = "╭",
            corner_bottom = "╰",
            arrow = ">",
        },
    },
}

M.opts.terminal = {
    win = {
        wo = {
            winbar = "",
        },
    },

    start_insert = false,
    auto_insert = false,
}

M.opts.image = {
    enabled = true
}

M.opts.picker = {
    prompt = "  ",
    layout = { preset = "telescope" },
    icons = {
        tree = {
            middle = "│ ",
        },
        diagnostics = {
            Error = "󰈸 ",
            Warn  = " ",
            Hint  = " ",
            Info  = " ",
        },
    },

    sources = {
        explorer = {
            diagnostics_open = true,
            win = {
                list = {
                    -- Xplr like key bindings
                    keys = {
                        ["h"] = "explorer_up",
                        ["l"] = "explorer_focus",
                    },

                    on_buf = function()
                        require "fidget.notification.window".set_x_offset(41)
                    end,
                    on_close = function()
                        require "fidget.notification.window".set_x_offset(0)
                    end
                }
            },
            layout = {
                layout = {
                    backdrop = true,
                    width = 40,
                    min_width = 40,
                    height = 0,
                    position = "right",
                    border = "none",
                    box = "vertical",
                    { win = "list", border = "none" },
                },
            },
        }
    }
}

M.opts.scroll = {
    enabled = true,
    animate = {
        easing = "inOutQuad",
        duration = { step = 20, total = 500 },
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

    {
        mode = { "n" },
        desc = "Open Snacks Explorer",

        "<C-e>",
        function()
            require "snacks".explorer.open()
        end,
    },

    {
        mode = { "n" },
        desc = "Pick help pages",

        "<leader>help",
        function()
            require "snacks".picker.help()
        end
    },

    {
        mode = { "n" },
        desc = "Pick man pages",

        "<leader>man",
        function()
            require "snacks".picker.man()
        end
    },

    {
        mode = { "n" },
        desc = "Open LazyGit",

        "<leader>g",
        function()
            require "snacks".lazygit()
        end
    }
}

return M

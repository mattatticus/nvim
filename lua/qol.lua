vim.pack.add {
    "https://github.com/folke/snacks.nvim",
    "https://github.com/folke/which-key.nvim",
}

local opts = {}

opts.scope = {
    enabled = true,
    cursor = false,

    treesitter = {
        enabled = false,
        -- blocks = {
        --     enabled = true,
        -- },
    },

    keys = {
        textobject = {
            is = {
                min_size = 2,
                edge = false,
                cursor = false,
                desc = "inner scope",
                treesitter = { blocks = { enabled = true } },
            },

            as = {
                min_size = 2,
                cursor = false,
                desc = "full scope",
                treesitter = { blocks = { enabled = true } },
            },
        },

        jump = {
            ["<C-t>"] = {
                edge = true,
                min_size = 1,
                bottom = false,
                cursor = false,
                desc = "jump to top edge of scope",
            },

            ["<C-b>"] = {
                edge = true,
                min_size = 1,
                bottom = true,
                cursor = false,
                desc = "jump to bottom edge of scope",
            },
        },
    },
}

opts.indent = {
    enabled = true,
}

opts.terminal = {
    win = {
        wo = {
            winbar = "",
        },
    },

    start_insert = false,
    auto_insert = false,
}

opts.image = {
    enabled = true,
    math = {
        enabled = false,
    },
}

opts.picker = {
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

require "snacks".setup(opts)

vim.keymap.set(
    { "n" },
    "<c-e>",
    function()
        require "snacks".explorer()
    end,
    {
        silent = true,
        noremap = true,
        desc = "Toggle file explorer",
    }
)

vim.keymap.set(
    { "n" },
    "<c-/>",
    function()
        require "snacks".terminal.toggle()
    end,
    {
        silent = true,
        noremap = true,
        desc = "Toggle terminal",
    }
)

vim.keymap.set(
    { "n" },
    "<leader>o",
    function()
        require "snacks".picker.files()
    end,
    {
        silent = true,
        noremap = true,
        desc = "Pick files",
    }
)

vim.keymap.set(
    { "n" },
    "<leader>rg",
    function()
        require("snacks").picker.grep()
    end,
    {
        silent = true,
        noremap = true,
        desc = "Live grep on files",
    }
)

if vim.fn.argc(-1) == 0 then
    require "snacks".explorer()
end

require "which-key".setup()

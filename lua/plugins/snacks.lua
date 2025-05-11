local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
}

M.opts = {}

-- M.opts.scope = {
--     enabled = true,
--     cursor = false,
--
--     treesitter = {
--         blocks = {
--             enabled = true,
--         },
--     },
--
--     keys = {
--         textobject = {
--             is = {
--                 min_size = 2, -- minimum size of the scope
--                 edge = false, -- inner scope
--                 cursor = false,
--                 treesitter = { blocks = { enabled = false } },
--                 desc = "inner scope",
--             },
--
--             as = {
--                 cursor = false,
--                 min_size = 2, -- minimum size of the scope
--                 treesitter = { blocks = { enabled = false } },
--                 desc = "full scope",
--             },
--         },
--
--         jump = {
--             ["<C-t>"] = {
--                 min_size = 1,
--                 bottom = false,
--                 cursor = false,
--                 edge = true,
--                 desc = "jump to top edge of scope",
--             },
--
--             ["<C-b>"] = {
--                 min_size = 1,
--                 bottom = true,
--                 cursor = false,
--                 edge = true,
--                 desc = "jump to bottom edge of scope",
--             },
--         },
--     },
-- }

M.opts.indent = {
    enabled = true,

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
}

M.opts.scroll = {
    -- enabled = false,
    enabled = true,
    animate = {
        easing = "inOutQuad",
        duration = { step = 20, total = 500 },
    },
}

local function explorer()
    require "snacks".picker.explorer {
        diagnostics_open = true,
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
end

function M.init()
    if vim.fn.argc(-1) == 0 then
        explorer()
    end
end

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
        explorer,
    },
}

return M

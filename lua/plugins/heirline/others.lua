local M = {}

local conditions = require "heirline.conditions"

local align = { provider = "%=" }

local header = {
    provider = " 󰄛  ",
    hl = {
        fg = "mantle",
        bg = "blue",
    },
}

M.terminal = {
    condition = function()
        return conditions.buffer_matches { buftype = { "terminal" } }
    end,

    hl = { bg = "mantle" },

    header,
    align,
    {
        provider = function()
            return " Terminal #" .. (vim.b.toggle_number or 0) .. " "
        end,

        hl = {
            fg = "mantle",
            bg = "teal",
        },
    },
}

M.special = {
    condition = function()
        return conditions.buffer_matches {
            buftype = { "help", "quickfix" },
            filetype = { "alpha", "lazy", "snacks_*", "fyler" },
        }
    end,

    header,
    align,
    {
        provider = function()
            local str = vim.bo.buftype == "nofile" and vim.bo.filetype:gsub("^%l", string.upper)
                or vim.bo.buftype:gsub("^%l", string.upper)
            return " " .. str .. " "
        end,
        hl = {
            fg = "mantle",
            bg = "blue",
        },
    },
}

return M

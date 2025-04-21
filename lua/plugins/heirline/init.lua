local M = {
    "rebelot/heirline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    lazy = false,
}

function M.opts()
    return {
        opts = {
            colors = require("catppuccin.palettes").get_palette "mocha",
        },

        statusline = {
            hl = { bg = "mantle" },
            fallthrough = false,

            require "plugins.heirline.others".terminal,
            require "plugins.heirline.others".special,
            require "plugins.heirline.statusline",
        },

        tabline = require "plugins.heirline.bufferline",
    }
end

return M

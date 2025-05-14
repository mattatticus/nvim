local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "LazyFile" },
    build = ":TSUpdate",
}

M.opts = {
    indent = { enable = true },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    ensure_installed = require("config").parsers,
}

function M.config(_, opts)
    require("nvim-treesitter.configs").setup(opts)
end

return M

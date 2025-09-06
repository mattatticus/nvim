local M = {
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    "nvim-treesitter/nvim-treesitter",
}

M.parsers = {
    "c",
    "go",
    "cpp",
    "css",
    "lua",
    "zig",
    "bash",
    "glsl",
    "fish",
    "html",
    "rust",
    "scss",
    "query",
    "python",
    "javascript",
}

M.dependencies = {
    "catppuccin/nvim",
    "OXY2DEV/markview.nvim",
}

function M.config()
    local ts = require "nvim-treesitter"
    ts.install(M.parsers)

    vim.api.nvim_create_autocmd(
        'FileType',
        {
            pattern = M.parsers,
            callback = function()
                vim.treesitter.start()
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        }
    )
end

return M

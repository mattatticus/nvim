local M = {
    "echasnovski/mini.nvim",
    priority = 1000,
    lazy = false,
}

function M.config()
    require "mini.ai".setup()
    require "mini.cursorword".setup()
    require "mini.trailspace".setup()

    require "mini.icons".setup()
    MiniIcons.mock_nvim_web_devicons()

    vim.api.nvim_create_autocmd(
        { "BufWritePre" },
        {
            pattern = { "*" },
            callback = function()
                MiniTrailspace.trim()
                MiniTrailspace.trim_last_lines()
            end
        }
    )
end

return M

vim.pack.add {
    {
        name = "catppuccin",
        src = "https://github.com/catppuccin/nvim",
    },
    {
        version = "main",
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
    }
}

require "catppuccin".setup {
    term_colors = true,
    no_bold = true,

    styles = {
        loops = { "italic" },
        types = { "italic" },
        comments = { "italic" },
        keywords = { "italic" },
        booleans = { "italic" },
        functions = { "italic" },
        conditionals = { "italic" },
    },

    integrations = {
        -- blink_cmp = { enabled = true, },
        treesitter = true,

        which_key = true,

        snacks = {
            enabled = true,
            indent_scope_color = "blue",
        },

        fidget = true,
        native_lsp = {
            enabled = true,
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },
    },
}

require "catppuccin".load()

local parsers = {
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

local ts = require "nvim-treesitter"
ts.install(parsers)

vim.api.nvim_create_augroup("Treesitter", {})
vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = parsers,
        group = "Treesitter",
        callback = function()
            vim.treesitter.start()
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    }
)

require('vim._extui').enable {
    enable = true,
    msg = {
        target = 'cmd',
        timeout = 4000,
    },
}

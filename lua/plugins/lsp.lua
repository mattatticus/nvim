local M = {
    "neovim/nvim-lspconfig",
    event = { "LazyFile" },
}

local lazydev = {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}

lazydev.dependencies = {
    "saghen/blink.cmp",
    opts = {
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    },
}

M.dependencies = {
    lazydev,

    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<leader>[",
                ":Lspsaga diagnostic_jump_prev<CR>",
                mode = { "n" },
                desc = "Jump to previous diagnostic",
            },
            {
                "<leader>]",
                ":Lspsaga diagnostic_jump_next<CR>",
                mode = { "n" },
                desc = "Jump to next diagnostic",
            },
        },
        opts = {
            symbol_in_winbar = {
                delay = 100,
                show_file = false,
                hide_keyword = true,
                separator = " -> ",
            },
            lightbulb = {
                enable = false,
            },
        },
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        opts = {
            preset = "ghost",
            options = {
                throttle = 0,
                enable_on_insert = true,
                multiple_diag_under_cursor = true,
                show_all_diags_on_cursorline = true,
            },
        },
    },
}

function M.config()
    vim.diagnostic.config {
        underline = true,
        severity_sort = true,
        virtual_text = false,
        update_in_insert = true,
        signs = {
            text = require("config").diagnostic_icons,
        },
    }

    local lspconfig = require "lspconfig"
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps = require("blink.cmp").get_lsp_capabilities(caps)

    local servers = {
        "zls",
        "cssls",
        "clangd",
        "gopls",
        "ts_ls",
        "asm_lsp",
        "pyright",
        "lua_ls",
        "fish_lsp",
        "glsl_analyzer",
        "rust_analyzer",
    }

    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            capabilities = caps,
        }
    end
end

return M

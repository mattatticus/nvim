vim.pack.add {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
}

vim.diagnostic.config {
    underline = true,
    severity_sort = true,
    virtual_text = false,
    update_in_insert = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰈸",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
}

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

vim.opt.completeopt = { "menuone", "noinsert", "preview", "fuzzy", "popup" }
vim.opt.wildoptions = { "fuzzy", "pum" }

for _, server in pairs(servers) do
    require "lspconfig"[server].setup {
        on_attach = function(client, bufnr)
            vim.lsp.completion.enable(true, client.id, bufnr, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub("%b()", "") }
                end,
            })
            -- vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
        end
    }
end

vim.api.nvim_create_augroup("AutoFormatting", {})
vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = "*",
        group = "AutoFormatting",
        callback = function()
            vim.lsp.buf.format { timeout_ms = 500 }
        end,
    }
)

vim.keymap.set(
    { "n" },
    "<leader>f",
    function()
        vim.lsp.buf.format()
    end,
    {
        silent = true,
        noremap = true,
        desc = "Lsp format buffer",
    }
)

local tc = require "todo-comments"
tc.setup()

vim.keymap.set(
    { "n" },
    "<leader>[",
    function()
        if #vim.diagnostic.get(0) == 0 then
            tc.jump_prev()
            return
        end

        vim.diagnostic.jump { count = -1 }
    end,
    {
        silent = true,
        noremap = true,
        desc = "Jump to previous diagnostic",
    }
)

vim.keymap.set(
    { "n" },
    "<leader>]",
    function()
        if #vim.diagnostic.get(0) == 0 then
            tc.jump_next()
            return
        end

        vim.diagnostic.jump { count = 1 }
    end,
    {
        silent = true,
        noremap = true,
        desc = "Jump to next diagnostic",
    }
)

-- Tiny inline diagnostic

require "tiny-inline-diagnostic".setup {
    preset = "ghost",
    options = {
        throttle = 0,
        enable_on_insert = true,
        multiple_diag_under_cursor = true,
        show_all_diags_on_cursorline = true,
    },
}

local M = {
    "saghen/blink.cmp",
    event = { "CmdlineEnter", "LazyFile" },
    version = "*",

    dependencies = {
        "L3MON4D3/LuaSnip",
        "xzbdmw/colorful-menu.nvim",
        "rafamadriz/friendly-snippets",
    },
}

function M.opts()
    local function complete_on_last_item(cmp)
        if not cmp.is_visible() then return false end

        local list = require "blink.cmp.completion.list"
        if #list.items == 1 then
            cmp.select_and_accept()
            return true
        end
    end

    return {
        snippets = { preset = "luasnip" },
        fuzzy = { implementation = "lua" },
        signature = { enabled = true },

        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
            kind_icons = require("config").kind_icons,
        },

        keymap = {
            preset = "none",
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },

            ["<C-n>"] = { "snippet_forward", "fallback" },
            ["<C-p>"] = { "snippet_backward", "fallback" },

            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-c>"] = { "cancel", "fallback" },

            ["<C-e>"] = { "show" },
            ["<CR>"] = { complete_on_last_item, "accept", "fallback" },
        },

        cmdline = {
            completion = {
                list = { selection = { auto_insert = true, preselect = false } },
                menu = { auto_show = true },
            },
            keymap = {
                preset = "none",
                ["<C-c>"] = { "cancel", "fallback" },
                ["<Tab>"] = { complete_on_last_item, "select_next", "fallback" },
                ["<S-Tab>"] = { complete_on_last_item, "select_prev", "fallback" },
            },
        },

        completion = {
            accept = { auto_brackets = { enabled = true } },
            list = { selection = { auto_insert = true, preselect = true } },
            menu = {
                draw = {
                    padding = 2,
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = require("colorful-menu").blink_components_text,
                            highlight = require("colorful-menu").blink_components_highlight,
                        },
                    },
                },
            },
            documentation = { auto_show_delay_ms = 0, auto_show = true },
            ghost_text = { enabled = true, show_without_selection = true },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer", "markdown" },
            providers = {
                markdown = {
                    name = "RenderMarkdown",
                    module = "render-markdown.integ.blink",
                    fallbacks = { "lsp" },
                },
            },
        },
    }
end

return M

return {
	"saghen/blink.cmp",
	event = { "CmdlineEnter", "LazyFile" },
	build = "cargo build --release",
	opts = function()
		local function complete_on_last_item(cmp)
			if not cmp.is_visible() then return false end

			local list = require "blink.cmp.completion.list"
			if #list.items == 1 then
				cmp.select_and_accept()
				return true
			end
		end

		return {
			keymap = {
				preset = "default",
				["<Tab>"] = { complete_on_last_item, "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { complete_on_last_item, "select_prev", "snippet_backward", "fallback" },
				cmdline = {
					preset = "default",
					["<Tab>"] = { complete_on_last_item, "select_next", "snippet_forward", "fallback" },
					["<S-Tab>"] = { complete_on_last_item, "select_prev", "snippet_backward", "fallback" },
				},
			},
			signature = { enabled = true },

			completion = {
				accept = { auto_brackets = { enabled = true } },
				list = { selection = "auto_insert" },
				documentation = {
					auto_show_delay_ms = 0,
					auto_show = true,
				},
				ghost_text = { enabled = true },
			},

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
				kind_icons = require("config").kind_icons,
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		}
	end,
}

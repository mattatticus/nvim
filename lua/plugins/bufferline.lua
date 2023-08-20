return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.no_bold,
				themable = true,
				numbers = "none",

				close_command = "bdelete! %d",

				buffer_close_icon = "󰅖",
				modified_icon = "",

				close_icon = "󰅖",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15,
				truncate_names = true,
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = true,
				diagnostics_indicator = function(count, _, _, _)
					return "󱩖 " .. count
				end,

				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},

				color_icons = true,
				get_element_icon = function(element)
					local icon, hl =
						require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
					return icon, hl
				end,

				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				persist_buffer_sort = true,
				move_wraps_at_ends = false,
				separator_style = "slope",
				enforce_regular_tabs = true,
				always_show_bufferline = false,

				highlights = require("catppuccin.groups.integrations.bufferline").get(),
			},
		})
	end,
}

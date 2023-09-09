return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			theme = "catppuccin",
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_z = { "mode" },
			lualine_y = {
				{
					"filename",
					file_status = true,
					newfile_status = false,
					path = 0,
					shorting_target = 40,
					symbols = {
						modified = "",
						readonly = "",
						unnamed = "_",
						newfile = "寧",
					},
				},
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					on_click = function(_, b, _)
						if b == "l" then
							vim.cmd("cope")
						end
					end,
				},
				{
					function()
						return next(vim.lsp.get_clients()) ~= nil and [[󰒋]] or [[]]
					end,
					color = { fg = "#d19a66" },
				},
			},
			lualine_c = { "filetype" },
			lualine_b = { "location" },
			lualine_a = {
				function()
					return [[󰈸]]
				end,
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			-- lualine_a = {header}
		},
		extensions = { "lazy", "trouble", "toggleterm", "quickfix", "nvim-tree" },
	},
}

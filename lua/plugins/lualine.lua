return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPre", "BufNewFile", "FileType NvimTree", "FileType alpha" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local function lsp()
			return next(vim.lsp.get_clients()) ~= nil and [[力]] or [[]]
		end

		local function header()
			return [[󰈸]]
		end

		require("lualine").setup({
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
					{ lsp, color = { fg = "#d19a66" } },
				},
				lualine_c = { "filetype" },
				lualine_b = { "location" },
				lualine_a = { header },
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
		})
	end,
}

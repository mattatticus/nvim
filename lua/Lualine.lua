local function lsp()
	if next(vim.lsp.buf_get_clients()) ~= nil then
		return [[力]]
	else
		return [[]]
	end
end

require("lualine").setup({
	options = {
		theme = "catppuccin",
		component_separators = "|",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
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
		lualine_c = {
			{ lsp, color = { fg = "#d19a66" } },
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				on_click = function(_, b, _)
					if b == "l" then
						vim.cmd("cope")
					end
				end,
			},
		},
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = { "lazy", "trouble", "toggleterm", "quickfix", "nvim-tree" },
})

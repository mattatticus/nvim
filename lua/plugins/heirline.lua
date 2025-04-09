local slice = function(comp, hl)
	local default = { fg = "crust", bg = "mantle" }
	return {
		{
			provider = "",
			hl = hl or default,
		},
		comp,
		{
			provider = "",
			hl = hl or default,
		},
	}
end

return {
	"rebelot/heirline.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local icon = require("nvim-web-devicons").get_icon_color_by_filetype
		local conditions = require "heirline.conditions"
		local utils = require "heirline.utils"

		local align = { provider = "%=" }

		local header = {
			provider = " 󰄛 ",
			hl = {
				fg = "mantle",
				bg = "blue",
			},
		}

		local mode = {
			static = { mode_map = require("config").mode_map },
			init = function(self)
				local mode = vim.fn.mode()
				self.mode, self.color = (unpack or table.unpack)(self.mode_map[mode])
			end,

			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
			},

			provider = function(self) return " " .. self.mode .. " " end,
			hl = function(self)
				return {
					bg = self.color,
					fg = "mantle",
				}
			end,
		}

		local ruler = slice {
			provider = function() return string.format(" %3d:%-2d ", vim.fn.line ".", vim.fn.col ".") end,
			hl = {
				fg = "surface2",
				bg = "crust",
			},
		}

		local filetype = slice {
			init = function(self)
				self.ft = vim.bo.filetype
				self.icon, self.color = icon(self.ft)

				if self.icon == nil then
					self.icon, self.color = icon "txt"
				end
			end,

			provider = function(self) return " " .. self.icon end,

			hl = function(self)
				return {
					fg = self.color,
					bg = "crust",
				}
			end,

			{
				provider = function(self) return " " .. self.ft .. " " end,
				hl = {
					fg = "surface2",
					bg = "crust",
				},
			},
		}
		filetype.condition = function() return vim.bo.filetype ~= "" end

		local lsp = {
			init = function(self) self.attached = conditions.lsp_attached() end,
			provider = " 󰒋 ",
			hl = function(self)
				return {
					fg = "mantle",
					bg = self.attached and "peach" or "crust",
				}
			end,
		}

		local filename = slice {
			provider = function()
				local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
				return " " .. (file == "" and "_" or file) .. " "
			end,
			hl = {
				fg = "surface2",
				bg = "crust",
			},
			{
				condition = function() return vim.bo.modified end,
				provider = "󱦹 ",
				hl = { fg = "green" },
			},
			{
				condition = function() return vim.bo.readonly or not vim.bo.modifiable end,
				provider = "󰌾 ",
				hl = { fg = "green" },
			},
		}
		filename.condition = function() return vim.bo.filetype ~= "" end

		local function chip(var, i, col)
			local c = slice({
				provider = function(self) return " " .. i .. " " .. tostring(self[var]) .. " " end,
				hl = {
					bg = col,
					fg = "mantle",
				},
			}, {
				fg = col,
				bg = "mantle",
			})
			c.condition = function(self) return self[var] > 0 end
			return c
		end

		local diag_icons = require("config").diagnostic_icons
		local diagnostics = {
			condition = conditions.has_diagnostics,
			update = { "DiagnosticChanged", "BufEnter" },

			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,

			chip("hints", diag_icons[4], "teal"),
			chip("info", diag_icons[3], "mauve"),
			chip("warnings", diag_icons[2], "yellow"),
			chip("errors", diag_icons[1], "red"),
		}

		local mainStatusline = {
			header,
			ruler,
			filetype,
			align,
			diagnostics,
			filename,
			lsp,
			mode,
		}

		local termStatusline = {
			condition = function() return conditions.buffer_matches { buftype = { "terminal" } } end,
			hl = { bg = "mantle" },

			header,
			align,
			{
				provider = function() return " Terminal #" .. (vim.b.toggle_number or 0) .. " " end,
				hl = {
					fg = "mantle",
					bg = "teal",
				},
			},
		}

		local specialStatusline = {
			condition = function()
				return conditions.buffer_matches {
					buftype = { "help", "quickfix" },
					filetype = { "alpha", "lazy", "NvimTree" },
				}
			end,

			header,
			align,
			{
				provider = function()
					local str = vim.bo.buftype == "nofile" and vim.bo.filetype:gsub("^%l", string.upper)
						or vim.bo.buftype:gsub("^%l", string.upper)
					return " " .. str .. " "
				end,
				hl = {
					fg = "mantle",
					bg = "blue",
				},
			},
		}

		local statusline = {
			hl = { bg = "mantle" },
			fallthrough = false,

			specialStatusline,
			termStatusline,
			mainStatusline,
		}

		local buflist = {}

		vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
			callback = vim.schedule_wrap(function()
				local buffers = vim.tbl_filter(
					function(bufnr) return vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) end,
					vim.api.nvim_list_bufs()
				)

				for i, v in ipairs(buffers) do
					buflist[i] = v
				end
				for i = #buffers + 1, #buflist do
					buflist[i] = nil
				end

				vim.o.showtabline = #buflist > 1 and 2 or 0
			end),
		})

		local bufElement = slice({
			init = function(self)
				self.ft = vim.api.nvim_get_option_value("filetype", { buf = self.bufnr })
				self.icon, self.color = icon(self.ft)

				if self.icon == nil then
					self.icon, self.color = icon "txt"
				end

				self.errors = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.INFO })
			end,
			{
				update = { "DiagnosticChanged", "BufEnter" },
				condition = function(self) return self.hints > 0 end,
				provider = function(self) return diag_icons[4] .. " " .. self.hints .. " " end,
				hl = function(self)
					return {
						fg = "teal",
						bg = self.is_active and "surface0" or "crust",
					}
				end,
			},
			{
				update = { "DiagnosticChanged", "BufEnter" },
				condition = function(self) return self.info > 0 end,
				provider = function(self) return diag_icons[3] .. " " .. self.info .. " " end,
				hl = function(self)
					return {
						fg = "mauve",
						bg = self.is_active and "surface0" or "crust",
					}
				end,
			},
			{
				update = { "DiagnosticChanged", "BufEnter" },
				condition = function(self) return self.warnings > 0 end,
				provider = function(self) return diag_icons[2] .. " " .. self.warnings .. " " end,
				hl = function(self)
					return {
						fg = "yellow",
						bg = self.is_active and "surface0" or "crust",
					}
				end,
			},
			{
				update = { "DiagnosticChanged", "BufEnter" },
				condition = function(self) return self.errors > 0 end,
				provider = function(self) return diag_icons[1] .. " " .. self.errors .. " " end,
				hl = function(self)
					return {
						fg = "red",
						bg = self.is_active and "surface0" or "crust",
					}
				end,
			},
			{
				provider = function(self) return " " .. self.icon end,
				hl = function(self)
					return {
						fg = self.color,
						bg = self.is_active and "surface0" or "crust",
					}
				end,
			},
			{
				provider = function(self)
					return " " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t") .. " "
				end,

				hl = function(self)
					return {
						fg = self.is_active and "text" or "surface2",
						bg = self.is_active and "surface0" or "crust",
					}
				end,
			},
		}, function(self)
			return {
				bg = "mantle",
				fg = self.is_active and "surface0" or "crust",
			}
		end)

		local buffers = utils.make_buflist(bufElement)

		local tabline = {
			buffers,
		}

		require("heirline").setup {
			statusline = statusline,
			tabline = tabline,
			opts = {
				colors = require("catppuccin.palettes").get_palette "mocha",
			},
		}
	end,
}

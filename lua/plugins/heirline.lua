return {
	"rebelot/heirline.nvim",
	priority = 1000,
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local get_icon = require("nvim-web-devicons").get_icon_color_by_filetype
		local conditions = require "heirline.conditions"
		local utils = require "heirline.utils"

		local surround = function(delims, hl, com, cond)
			return {
				condition = cond,
				{ provider = delims[1], hl = hl },
				com,
				{ provider = delims[2], hl = hl },
			}
		end

		local slice = function(com, cond) return surround({ "", "" }, { fg = "crust", bg = "mantle" }, com, cond) end

		local header = {
			provider = " 󰄛 ",
			hl = {
				fg = "mantle",
				bg = "maroon",
			},
		}

		local ruler = slice {
			provider = function() return string.format(" %3d:%-2d ", vim.fn.line ".", vim.fn.col ".") end,
			hl = {
				fg = "surface2",
				bg = "crust",
			},
		}

		local filetype = slice({
			init = function(self)
				self.ft = vim.bo.filetype
				self.icon, self.color = get_icon(self.ft)

				if self.icon == nil then
					self.icon, self.color = get_icon "txt"
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
		}, function() return vim.bo.filetype ~= "" end)

		local lsp = {
			init = function(self) self.attached = conditions.lsp_attached() end,
			{
				provider = "",
				hl = function(self)
					return {
						fg = self.attached and "peach" or "crust",
						bg = "mantle",
					}
				end,
			},
			{
				provider = " 󰒋 ",
				hl = function(self)
					return {
						bg = self.attached and "peach" or "crust",
						fg = self.attached and "mantle" or "surface1",
					}
				end,
			},
			{
				provider = "",
				hl = function(self)
					return {
						fg = self.attached and "peach" or "crust",
						bg = "mantle",
					}
				end,
			},
		}

		local chip = function(var, icon, col)
			return {
				condition = function(self) return self[var] > 0 end,
				provider = function(self) return " " .. icon .. " " .. tostring(self[var]) .. " " end,

				hl = {
					bg = col,
					fg = "mantle",
				},
			}
		end

		local diagnostics = {
			condition = conditions.has_diagnostics,

			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,

			update = { "DiagnosticChanged", "BufEnter" },

			chip("hints", "", "teal"),
			chip("info", "", "mauve"),
			chip("warnings", "", "yellow"),
			chip("errors", "", "red"),
		}

		local filename = slice({
			provider = function() return " " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t") .. " " end,
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
		}, function() return vim.api.nvim_buf_get_name(0) ~= "" end)

		local vimode = {
			static = {
				mode_map = {
					["n"] = "Normal",
					["no"] = "O-Pending",
					["nov"] = "O-Pending",
					["noV"] = "O-Pending",
					["no\22"] = "O-Pending",
					["niI"] = "Normal",
					["niR"] = "Normal",
					["niV"] = "Normal",
					["nt"] = "Normal",
					["ntT"] = "Normal",
					["v"] = "Visual",
					["vs"] = "Visual",
					["V"] = "V-Line",
					["Vs"] = "V-Line",
					["\22"] = "V-Block",
					["\22s"] = "V-Block",
					["s"] = "Select",
					["S"] = "S-Line",
					["\19"] = "S-Block",
					["i"] = "Insert",
					["ic"] = "Insert",
					["ix"] = "Insert",
					["R"] = "Replace",
					["Rc"] = "Replace",
					["Rx"] = "Replace",
					["Rv"] = "V-Replace",
					["Rvc"] = "V-Replace",
					["Rvx"] = "V-Replace",
					["c"] = "Command",
					["cv"] = "Ex-Mode",
					["ce"] = "Ex-Mode",
					["r"] = "Replace",
					["rm"] = "More",
					["r?"] = "Confirm",
					["!"] = "Shell",
					["t"] = "Terminal",
				},
				color_map = {
					n = "teal",
					no = "teal",
					nov = "teal",
					noV = "teal",
					["no\22"] = "teal",
					niI = "teal",
					niR = "teal",
					niV = "teal",
					nt = "teal",
					v = "maroon",
					vs = "maroon",
					V = "maroon",
					Vs = "maroon",
					["\22"] = "maroon",
					["\22s"] = "maroon",
					s = "mauve",
					S = "mauve",
					["\19"] = "mauve",
					i = "green",
					ic = "green",
					ix = "green",
					R = "lavender",
					Rc = "lavender",
					Rx = "lavender",
					Rv = "lavender",
					Rvc = "lavender",
					Rvx = "lavender",
					r = "lavender",
					rm = "flamingo",
					c = "red",
					cv = "red",
					["r?"] = "red",
					["!"] = "peach",
					t = "peach",
				},
			},

			init = function(self)
				local mode = vim.fn.mode()
				self.mode = self.mode_map[mode]
				self.color = self.color_map[mode]
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

		local align = { provider = "%=" }

		local specials = {
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
					if vim.bo.buftype == "nofile" then
						return " " .. vim.bo.filetype:gsub("^%l", string.upper) .. " "
					else
						return " " .. vim.bo.buftype:gsub("^%l", string.upper) .. " "
					end
				end,
				hl = {
					fg = "mantle",
					bg = "teal",
				},
			},
		}

		local terminalst = {
			condition = function() return conditions.buffer_matches { buftype = { "terminal" } } end,
			hl = { bg = "mantle" },

			header,
			align,
			{
				provider = function() return " Toggleterm #" .. vim.b.toggle_number .. " " end,
				hl = {
					fg = "mantle",
					bg = "teal",
				},
			},
		}

		local mainst = {
			header,
			ruler,
			filetype,
			align,
			diagnostics,
			filename,
			lsp,
			vimode,
		}

		local st = {
			hl = { bg = "mantle" },
			fallthrough = false,

			specials,
			terminalst,
			mainst,
		}

		local bufferelement = surround(
			{ "", "" },
			function(self)
				return {
					bg = "mantle",
					fg = self.is_active and "surface0" or "crust",
				}
			end,
			{
				init = function(self)
					self.ft = vim.api.nvim_get_option_value("filetype", { buf = self.bufnr })
					self.icon, self.color = get_icon(self.ft)

					if self.icon == nil then
						self.icon, self.color = get_icon "txt"
					end
				end,
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
				{
					provider = "",
					hl = function(self)
						return {
							fg = "text",
							bg = self.is_active and "surface0" or "crust",
						}
					end,
					on_click = {
						callback = vim.schedule_wrap(function(_, minwid)
							vim.api.nvim_buf_delete(minwid, { force = false })
							vim.cmd.redrawtabline()
						end),
						minwid = function(self) return self.bufnr end,
						name = "heirline_tabline_close_buffer_callback",
					},
				},
			}
		)

		local buflist_cache = {}

		vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
			callback = vim.schedule_wrap(function()
				local buffers = vim.tbl_filter(
					function(bufnr) return vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) end,
					vim.api.nvim_list_bufs()
				)

				for i, v in ipairs(buffers) do
					buflist_cache[i] = v
				end
				for i = #buffers + 1, #buflist_cache do
					buflist_cache[i] = nil
				end

				vim.o.showtabline = #buflist_cache > 1 and 2 or 0
			end),
		})

		local buffers = utils.make_buflist(bufferelement, nil, nil, function() return buflist_cache end, false)

		local tabelement = surround(
			{ "", "" },
			function(self)
				return {
					bg = "mantle",
					fg = self.is_active and "surface0" or "crust",
				}
			end,

			{
				provider = function(self) return " " .. self.tabnr .. " " end,

				hl = function(self)
					return {
						fg = self.is_active and "text" or "surface2",
						bg = self.is_active and "surface0" or "crust",
					}
				end,
			}
		)

		local tabs = utils.make_tablist(tabelement)

		local offset = {
			condition = function()
				return #vim.tbl_filter(
					function(winid) return vim.bo[vim.api.nvim_win_get_buf(winid)].filetype == "NvimTree" end,
					vim.api.nvim_tabpage_list_wins(0)
				) >= 1
			end,
			provider = "        File Explorer         ",
			hl = {
				fg = "text",
				bg = "crust",
			},
		}

		local tb = {
			hl = { bg = "mantle" },
			buffers,
			align,
			tabs,
			offset,
		}

		require("heirline").setup {
			statusline = st,
			tabline = tb,
			opts = {
				colors = require("catppuccin.palettes").get_palette "mocha",
			},
		}
	end,
}

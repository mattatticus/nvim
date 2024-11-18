return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		init = function() require("catppuccin").load() end,
		opts = {
			term_colors = true,
			no_bold = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = { "italic" },
				functions = { "italic" },
				keywords = { "italic" },
				booleans = { "italic" },
				types = { "italic" },
			},
			integrations = {
				cmp = true,
				nvimtree = true,
				telescope = true,
				treesitter = true,
				lsp_trouble = true,
				indent_blankline = {
					enabled = true,
					scope_color = "blue",
				},
				fidget = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function() _ = #vim.fn.argv() == 0 and require("nvim-tree.api").tree.open() end,
		keys = {
			{
				"<A-s>",
				function() require("nvim-tree.api").tree.toggle() end,
				mode = { "n" },
			},
		},
		opts = {
			sort_by = "case_sensitive",
			view = {
				side = "right",
				width = 30,
				cursorline = false,
			},
			renderer = {
				root_folder_label = ":s?$?",
				group_empty = true,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "├",
						bottom = "─",
						none = " ",
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
			filters = {
				dotfiles = true,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
			exclude = {
				filetypes = {
					"lazy",
					"lspinfo",
					"checkhealth",
					"help",
					"man",
					"gitcommit",
					"TelescopePrompt",
					"TelescopeResults",
				},
				buftypes = {
					"terminal",
					"lspinfo",
					"help",
					"nofile",
				},
			},
			scope = { enabled = true },
		},
	},

	{
		"j-hui/fidget.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-tree.lua",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			notification = {
				window = {
					winblend = 0,
                    zindex = 250
				},
			},
		},
	},

	{
		"rebelot/heirline.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local icon = require("nvim-web-devicons").get_icon_color_by_filetype
			local conditions = require "heirline.conditions"
			local utils = require "heirline.utils"

			local header = {
				provider = " 󰄛 ",
				hl = {
					fg = "mantle",
					bg = "maroon",
				},
			}

			local ruler = {
				{
					provider = "",
					hl = { fg = "crust", bg = "mantle" },
				},
				{
					provider = function() return string.format(" %3d:%-2d ", vim.fn.line ".", vim.fn.col ".") end,
					hl = {
						fg = "surface2",
						bg = "crust",
					},
				},
				{
					provider = "",
					hl = { fg = "crust", bg = "mantle" },
				},
			}

			local filetype = {
				condition = function() return vim.bo.filetype ~= "" end,
				{
					provider = "",
					hl = { fg = "crust", bg = "mantle" },
				},
				{
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
				},
				{
					provider = "",
					hl = { fg = "crust", bg = "mantle" },
				},
			}

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

			local chip = function(var, i, col)
				return {
					condition = function(self) return self[var] > 0 end,
					provider = function(self) return " " .. i .. " " .. tostring(self[var]) .. " " end,

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

			local filename = {
				condition = function() return vim.bo.filetype ~= "" end,
				{
					provider = "",
					hl = { fg = "crust", bg = "mantle" },
				},
				{
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
				},
				{
					provider = "",
					hl = { fg = "crust", bg = "mantle" },
				},
			}

			local vimode = {
				static = {
					mode_map = require("config").mode_map,
				},

				init = function(self)
					local mode = vim.fn.mode()
					self.mode = self.mode_map[mode].str
					self.color = self.mode_map[mode].col
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
					provider = function() return " Toggleterm #" .. (vim.b.toggle_number or 0) .. " " end,
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

			local surround = function(delims, hl, com, cond)
				return {
					condition = cond,
					{ provider = delims[1], hl = hl },
					com,
					{ provider = delims[2], hl = hl },
				}
			end

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
						self.icon, self.color = icon(self.ft)

						if self.icon == nil then
							self.icon, self.color = icon "txt"
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
							callback = vim.schedule_wrap(function(_, _)
								vim.cmd "bd|bp"
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
				provider = "                              ",
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
	},
}

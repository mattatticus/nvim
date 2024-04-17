return {
	{
		"windwp/nvim-autopairs",
		event = { "BufNewFile", "BufReadPre", "BufReadPost" },
		opts = {
			check_ts = true,
			fast_wrap = {
				map = "<A-t>",
				chars = { "{", '"', "'", "<" },
				pattern = [=[[%'%"%)%>%]%)%}%,]]=],
				end_key = "-",
				keys = "htnsdaoeuigcrlf',.pybmwvz;",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
			enable_check_bracket_line = true,
		},
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "CmdlineEnter", "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local function has_words_before()
				local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
			end
			local kind_icons = require("config").cmp_icons
			local cmp = require "cmp"

			cmp.setup {
				snippet = {
					expand = function(args) vim.snippet.expand(args.body) end,
				},

				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
						vim_item.menu = ({
							nvim_lsp = "Lsp",
							buffer = "Buffer",
							path = "Path",
						})[entry.source.name]
						return vim_item
					end,
				},

				mapping = cmp.mapping.preset.insert {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),

					["<CR>"] = cmp.mapping.confirm { select = true },

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							_ = #cmp.get_entries() == 1 and cmp.confirm { select = true } or cmp.select_next_item()
						elseif vim.snippet.jumpable(1) then
							vim.snippet.jump(1)
						elseif has_words_before() then
							cmp.complete()
							_ = #cmp.get_entries() == 1 and cmp.confirm { select = true }
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.snippet.jumpable(-1) then
							vim.snippet.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},

				sources = cmp.config.sources {
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				},

				experimental = {
					ghost_text = true,
				},
			}

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufNewFile", "BufReadPre", "BufReadPost" },

		build = function() vim.cmd "TSUpdate" end,

		opts = {
			ensure_installed = require("config").treesitter_parsers,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
			},
		},
	},

	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>fo",
				function() require("conform").format { async = true, lsp_fallback = true } end,
				mode = { "n" },
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "js-beautify" },
				html = { "html-beautify" },
				css = { "css-beautify" },
				rust = { "rustfmt" },
				go = { "gofmt" },
			},
		},
	},
}

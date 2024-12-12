return function()
	local function has_words_before()
		local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
	end

	local cmp = require "cmp"

	cmp.setup {
		window = {
			completion = { zindex = 250 },
			documentation = { zindex = 250 },
		},

		snippet = {
			expand = function(args) vim.snippet.expand(args.body) end,
		},

		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s", require("config").kind_icons[vim_item.kind])
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
				elseif vim.snippet.active { direction = 1 } then
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
				elseif vim.snippet.active { direction = -1 } then
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
			{ name = "nvim_lsp_signature_help" },
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
end

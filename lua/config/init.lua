require "config.options"

local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.command = ""

function Cmd(s)
	return function() vim.cmd(s) end
end

M.keymap = {
	{ "", "<Space>", "<Nop>" },

	{ "n", "<leader>n", "<C-w>w" },
	{ "n", "<leader>c", Cmd "bd|bp" },

	{ "n", "<A-.>", Cmd "bnext" },
	{ "n", "<A-,>", Cmd "bprev" },

	{ "n", "<A-<>", Cmd "tabprevious" },
	{ "n", "<A->>", Cmd "tabnext" },

	{ "t", "<esc>", "<C-\\><C-n>" },
	{ "t", "<C-[>", "<C-\\><C-n>" },
}

M.cmp_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = " ",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = " ",
	Misc = " ",
}

M.treesitter_parsers = {
	"bash",
	"c",
	"cpp",
	"css",
	"fish",
	"go",
	"haskell",
	"html",
	"javascript",
	"lua",
	"python",
	"rust",
	"scss",
	"yuck",
	"zig",
}

for _, v in pairs(M.keymap) do
	local a, b, c = v[1], v[2], v[3]
	vim.keymap.set(a, b, c, { noremap = true, silent = true })
end

return M

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

for _, v in pairs(M.keymap) do
	local a, b, c = v[1], v[2], v[3]
	vim.keymap.set(a, b, c, { noremap = true, silent = true })
end

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

M.mode_map = {
	["n"] = { str = "Normal", col = "teal" },
	["no"] = { str = "O-Pending", col = "teal" },
	["nov"] = { str = "O-Pending", col = "teal" },
	["noV"] = { str = "O-Pending", col = "teal" },
	["no\22"] = { str = "O-Pending", col = "teal" },
	["niI"] = { str = "Normal", col = "teal" },
	["niR"] = { str = "Normal", col = "teal" },
	["niV"] = { str = "Normal", col = "teal" },
	["nt"] = { str = "Normal", col = "teal" },
	["ntT"] = { str = "Normal", col = "teal" },
	["v"] = { str = "Visual", col = "maroon" },
	["vs"] = { str = "Visual", col = "maroon" },
	["V"] = { str = "V-Line", col = "maroon" },
	["Vs"] = { str = "V-Line", col = "maroon" },
	["\22"] = { str = "V-Block", col = "maroon" },
	["\22s"] = { str = "V-Block", col = "maroon" },
	["s"] = { str = "Select", col = "mauve" },
	["S"] = { str = "S-Line", col = "mauve" },
	["\19"] = { str = "S-Block", col = "mauve" },
	["i"] = { str = "Insert", col = "green" },
	["ic"] = { str = "Insert", col = "green" },
	["ix"] = { str = "Insert", col = "green" },
	["R"] = { str = "Replace", col = "lavender" },
	["Rc"] = { str = "Replace", col = "lavender" },
	["Rx"] = { str = "Replace", col = "lavender" },
	["Rv"] = { str = "V-Replace", col = "lavender" },
	["Rvc"] = { str = "V-Replace", col = "lavender" },
	["Rvx"] = { str = "V-Replace", col = "lavender" },
	["r"] = { str = "Replace", col = "lavender" },
	["rm"] = { str = "More", col = "flamingo" },
	["r?"] = { str = "Confirm", col = "red" },
	["c"] = { str = "Command", col = "red" },
	["cv"] = { str = "Ex-Mode", col = "red" },
	["ce"] = { str = "Ex-Mode", col = "red" },
	["!"] = { str = "Shell", col = "peach" },
	["t"] = { str = "Terminal", col = "peach" },
}

return M

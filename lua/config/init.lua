require "config.options"

M = {}

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

M.parsers = {
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

M.kind_icons = {
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

M.mode_map = {
	["n"] = { str = "Normal", col = "blue" },
	["niI"] = { str = "Normal", col = "blue" },
	["niR"] = { str = "Normal", col = "blue" },
	["niV"] = { str = "Normal", col = "blue" },
	["nt"] = { str = "Normal", col = "blue" },
	["ntT"] = { str = "Normal", col = "blue" },
	["no"] = { str = "O-Pending", col = "teal" },
	["nov"] = { str = "O-Pending", col = "teal" },
	["noV"] = { str = "O-Pending", col = "teal" },
	["no\22"] = { str = "O-Pending", col = "teal" },
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

M.servers = {
	"cssls",
	"pyright",
	"rust_analyzer",
	"kotlin_language_server",
	"gopls",
	"ts_ls",
	"zls",
}

return M

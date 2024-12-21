require "config.options"
require "config.mappings"

M = {}

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


return M

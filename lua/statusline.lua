vim.pack.add {
    "https://github.com/rebelot/heirline.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
}

local heirline = require "heirline"
local utils = require "heirline.utils"
local conditions = require "heirline.conditions"
local icon = require("nvim-web-devicons").get_icon_color_by_filetype

local diagnostic_icons = {
    infos = "",
    hints = "",
    warns = "",
    errors = "󰈸",
}

local arch = {
    provider = " 󰄛  ",
    hl = {
        fg = "mantle",
        bg = "blue",
    },
}

local align = { provider = "%=" }

local terminal = {
    condition = function()
        return conditions.buffer_matches { buftype = { "terminal" } }
    end,

    hl = { bg = "mantle" },

    arch,
    align,

    {
        provider = function()
            return " Terminal #" .. (vim.b.toggle_number or 0) .. " "
        end,

        hl = {
            fg = "mantle",
            bg = "blue",
        },
    },
}

local special = {
    condition = function()
        return conditions.buffer_matches {
            buftype = { "help", "quickfix" },
            filetype = { "alpha", "lazy", "snacks_*", "fyler" },
        }
    end,

    arch,
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

local mode_map = {
    ["n"] = { "Normal", "blue" },
    ["niI"] = { "Normal", "blue" },
    ["niR"] = { "Normal", "blue" },
    ["niV"] = { "Normal", "blue" },
    ["nt"] = { "Normal", "blue" },
    ["ntT"] = { "Normal", "blue" },
    ["no"] = { "O-Pending", "teal" },
    ["nov"] = { "O-Pending", "teal" },
    ["noV"] = { "O-Pending", "teal" },
    ["no\22"] = { "O-Pending", "teal" },
    ["v"] = { "Visual", "maroon" },
    ["vs"] = { "Visual", "maroon" },
    ["V"] = { "V-Line", "maroon" },
    ["Vs"] = { "V-Line", "maroon" },
    ["\22"] = { "V-Block", "maroon" },
    ["\22s"] = { "V-Block", "maroon" },
    ["s"] = { "Select", "mauve" },
    ["S"] = { "S-Line", "mauve" },
    ["\19"] = { "S-Block", "mauve" },
    ["i"] = { "Insert", "green" },
    ["ic"] = { "Insert", "green" },
    ["ix"] = { "Insert", "green" },
    ["R"] = { "Replace", "lavender" },
    ["Rc"] = { "Replace", "lavender" },
    ["Rx"] = { "Replace", "lavender" },
    ["Rv"] = { "V-Replace", "lavender" },
    ["Rvc"] = { "V-Replace", "lavender" },
    ["Rvx"] = { "V-Replace", "lavender" },
    ["r"] = { "Replace", "lavender" },
    ["rm"] = { "More", "flamingo" },
    ["r?"] = { "Confirm", "red" },
    ["c"] = { "Command", "red" },
    ["cv"] = { "Ex-Mode", "red" },
    ["ce"] = { "Ex-Mode", "red" },
    ["!"] = { "Shell", "peach" },
    ["t"] = { "Terminal", "peach" },
}

local slice = function(comp, hl)
    local default = { fg = "crust", bg = "mantle" }
    return {
        {
            provider = "",
            hl = hl or default,
            condition = comp.condition,
        },
        comp,
        {
            provider = "",
            hl = hl or default,
            condition = comp.condition,
        },
    }
end

local function chip(var, i, col)
    local c = slice({
        condition = function(self) return self[var] > 0 end,
        provider = function(self) return " " .. i .. " " .. tostring(self[var]) .. " " end,
        hl = {
            bg = col,
            fg = "mantle",
        },
    }, {
        fg = col,
        bg = "mantle",
    })
    return c
end

local main = {
    arch,

    -- ruler
    slice {
        provider = function() return string.format(" %3d:%-2d ", vim.fn.line ".", vim.fn.col ".") end,
        hl = {
            fg = "surface2",
            bg = "crust",
        },
    },

    -- filetype
    slice {
        condition = function() return vim.bo.filetype ~= "" end,
        init = function(self)
            self.ft = vim.bo.filetype
            self.icon, self.color = icon(self.ft)

            if self.icon == nil then
                self.icon, self.color = icon "txt"
            end
        end,

        provider = function(self)
            return " " .. (self.icon or "")
        end,

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


    align,

    -- diagnostics
    {
        condition = conditions.has_diagnostics,

        update = {
            "DiagnosticChanged",
            "BufEnter",
        },

        init = function(self)
            self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,

        chip("hints", diagnostic_icons.hints, "teal"),
        chip("info", diagnostic_icons.infos, "mauve"),
        chip("warnings", diagnostic_icons.warns, "yellow"),
        chip("errors", diagnostic_icons.errors, "red"),
    },

    -- filename
    slice {
        condition = function() return vim.bo.filetype ~= "" end,
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

    -- lsp
    {
        init = function(self) self.attached = conditions.lsp_attached() end,
        provider = " 󰒋  ",
        hl = function(self)
            return {
                fg = "mantle",
                bg = self.attached and "peach" or "crust",
            }
        end,
    },

    -- mode
    {
        static = { mode_map = mode_map },

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
}

local buflist = {}

local function fillBuflist()
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
end

vim.api.nvim_create_autocmd(
    { "VimEnter", "UIEnter", "BufAdd", "BufDelete" },
    {
        callback = vim.schedule_wrap(fillBuflist),
    }
)

local buffer = {
    init = function(self)
        self.ft = vim.api.nvim_get_option_value("filetype", { buf = self.bufnr })
        self.icon, self.color = icon(self.ft)

        if self.icon == nil then
            self.icon, self.color = icon "txt"
        end

        self.info = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.INFO })
        self.hints = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.HINT })
        self.errors = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(self.bufnr, { severity = vim.diagnostic.severity.WARN })
    end,
    {
        update = { "DiagnosticChanged", "BufEnter" },

        condition = function(self) return self.hints > 0 end,
        provider = function(self)
            return diagnostic_icons.hints .. " " .. self.hints .. " "
        end,

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
        provider = function(self)
            return diagnostic_icons.info .. " " .. self.info .. " "
        end,

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
        provider = function(self)
            return diagnostic_icons.warns .. " " .. self.warnings .. " "
        end,

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
        provider = function(self)
            return diagnostic_icons.errors .. " " .. self.errors .. " "
        end,

        hl = function(self)
            return {
                fg = "red",
                bg = self.is_active and "surface0" or "crust",
            }
        end,
    },
    {
        provider = function(self)
            return " " .. (self.icon or "")
        end,
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
}


local tabline = {
    utils.make_buflist(
        slice(buffer, function(self)
            return {
                bg = "mantle",
                fg = self.is_active and "surface0" or "crust",
            }
        end)
    )
}

heirline.setup {
    opts = {
        colors = require("catppuccin.palettes").get_palette "mocha",
    },

    statusline = {
        hl = { bg = "mantle" },
        fallthrough = false,

        terminal,
        special,
        main
    },

    tabline = tabline,
}

vim.keymap.set(
    { "n" },
    "<c-.>",
    function()
        vim.cmd("bnext")
    end,
    { silent = true, noremap = true }
)


vim.keymap.set(
    { "n" },
    "<c-,>",
    function()
        vim.cmd("bprev")
    end,
    { silent = true, noremap = true }
)

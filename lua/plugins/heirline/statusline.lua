local icon = require("nvim-web-devicons").get_icon_color_by_filetype
local conditions = require "heirline.conditions"
local diag_icons = require("config").diagnostic_icons

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

local diagnostics = {
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

    chip("hints", diag_icons[4], "teal"),
    chip("info", diag_icons[3], "mauve"),
    chip("warnings", diag_icons[2], "yellow"),
    chip("errors", diag_icons[1], "red"),
}

return {
    header,
    ruler,
    filetype,
    align,
    diagnostics,
    filename,
    lsp,
    mode,
}

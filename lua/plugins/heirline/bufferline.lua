local utils = require "heirline.utils"
local diag_icons = require "config".diagnostic_icons
local icon = require("nvim-web-devicons").get_icon_color_by_filetype

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
            return diag_icons[4] .. " " .. self.hints .. " "
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
            return diag_icons[3] .. " " .. self.info .. " "
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
            return diag_icons[2] .. " " .. self.warnings .. " "
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
            return diag_icons[1] .. " " .. self.errors .. " "
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

return {
    utils.make_buflist(
        slice(buffer, function(self)
            return {
                bg = "mantle",
                fg = self.is_active and "surface0" or "crust",
            }
        end)
    )
}

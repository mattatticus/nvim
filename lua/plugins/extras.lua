return {
    {
        "NvChad/nvim-colorizer.lua",
        name = "colorizer",
        ft = { "css", "scss", "sass", "html" },
        cmd = "ColorizerToggle",
        opts = {
            filetypes = { "css", "scss", "sass", "html" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
            },
        },
    },

    {
        "max397574/colortils.nvim",
        ft = { "css", "scss", "sass", "html" },
        cmd = "Colortils",
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        keys = {
            {
                "<leader>fu",
                Cmd "Telescope undo",
                mode = { "n" },
            },
            {
                "<leader>ff",
                function() require("telescope.builtin").find_files() end,
                mode = { "n" },
            },
            {
                "<leader>fg",
                function() require("telescope.builtin").live_grep() end,
                mode = { "n" },
            },
        },
        config = function()
            require("telescope").setup {
                extensions = {
                    undo = {},
                },
            }
            require("telescope").load_extension "undo"
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        keys = {
            {
                "<leader>t",
                Cmd "ToggleTerm direction=horizontal",
                mode = { "n" },
            },
            {
                "<leader>vt",
                Cmd "ToggleTerm direction=vertical",
                mode = { "n" },
            },
        },
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 8
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            start_in_insert = false,
            hide_numbers = true,
            shade_filetypes = { "none" },
            autochdir = true,
        },
    },

    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {},
    },
}

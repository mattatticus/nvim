local M = {
    "windwp/nvim-autopairs",
    enabled = false,
    event = { "LazyFile" },
}

M.opts = {
    disable_in_macro = false,
    check_ts = true,
    enable_check_bracket_line = false,
    map_c_w = true,
    fast_wrap = {
        map = "<A-w>",
        chars = { "{", "[", "(", '"', "'", "<" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "-",
        before_key = "z",
        after_key = "v",
        avoid_move_to_end = true,
        cursor_pos_before = true,
        keys = "aoeuidhtns',.pyfgcrl;qjkxbmwvz",
        manual_position = false,
        highlight = "Search",
        highlight_grey = "Comment",
        use_virt_lines = true,
    },
}

return M

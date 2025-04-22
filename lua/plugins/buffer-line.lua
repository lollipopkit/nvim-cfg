-- ~/.config/nvim/lua/plugins/bufferline.lua
return {
    "akinsho/bufferline.nvim",                        -- bufferline 插件
    event = "BufReadPost",                            -- 延迟加载
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 图标依赖
    opts = {
        options = {
            numbers                 = "ordinal", -- buffer 前显示序号
            indicator               = { icon = "▎", style = "icon" },
            -- buffer_close_icon       = "",
            modified_icon           = "●",
            close_icon              = "",
            -- left_trunc_marker       = "",
            -- right_trunc_marker      = "",
            max_name_length         = 30,
            tab_size                = 20,
            show_buffer_close_icons = true,
            show_buffer_icons       = true,
            show_close_icon         = false,
            diagnostics             = "nvim_lsp",
            diagnostics_indicator   = function(count, level, _)
                return "(" .. count .. ")"
            end,
            offsets                 = {
                {
                    filetype   = "NvimTree",
                    text       = "File Explorer",
                    text_align = "center",
                    separator  = true,
                },
            },
            sort_by                 = "insert_after_current",
        },
    },
}

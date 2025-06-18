return {
    -- 快速跳转
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                char = { enabled = false }, -- 禁用 f/F/t/T 模式
            },
        },
        keys = {
            { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
            { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
        },
    },
    
    -- 包围操作
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
}
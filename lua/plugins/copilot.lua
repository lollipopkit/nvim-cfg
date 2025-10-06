return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        opts = {
            suggestion = {
                enabled = true,       -- 启用行内建议
                auto_trigger = true,  -- 自动触发
                keymap = {
                    accept = "<Tab>", -- 接受建议键位
                    next = "<C-]>",
                    prev = "<C-[>",
                    dismiss = "<C-/>",
                },
            },
            panel = {
                enabled = true, -- 启用 Copilot 面板
                auto_refresh = true,
                keymap = {
                    open = "<M-CR>",
                    jump_prev = "[[",
                    jump_next = "]]",
                    refresh = "gr",
                    close = "q",
                },
            },
        },
        config = function(_, opts)
            require("copilot").setup(opts)
        end,
    },
    -- nvim-cmp 加上这段来把 Copilot 建议接入到补全列表
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        opts = {
            method = "getCompletionsCycling",
        },
        config = function(_, opts)
            local ok, copilot_cmp = pcall(require, "copilot_cmp")
            if ok then
                copilot_cmp.setup(opts)
            end
        end,
    },
}

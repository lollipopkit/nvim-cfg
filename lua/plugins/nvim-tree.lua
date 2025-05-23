return { {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- 想要打开 nvim 自动加载文件树，就用 VimEnter 触发
    event = "VimEnter",
    opts = {
        view = {
            width = 37
        },
        filters = {
            dotfiles = false
        },
        hijack_directories = {
            enable = true,
            auto_open = true -- 打开 nvim 时如果是目录就自动展开树
        },
        update_focused_file = {
            enable = true,
            update_root = true
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        renderer = {
            group_empty = true
        },
        -- 关闭对 .gitignore 中声明文件的隐藏
        git = {
            enable  = true, -- 保持开启 Git 状态显示
            ignore  = false, -- 不隐藏 Git 忽略的文件
            timeout = 500, -- 可选：Git 状态查询超时
        },
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
        -- VimEnter 时只有在恢复会话（session）后才打开树，避免闪烁
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function(data)
                -- data.file == "" 说明是空白文件缓冲区，打开树
                if data.file == "" then
                    require("nvim-tree.api").tree.open()
                end
            end
        })
    end
} }

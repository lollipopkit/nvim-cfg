return { {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "folke/neodev.nvim",
        "hrsh7th/cmp-nvim-lsp" },
    config = function()
        require("neodev").setup({})

        require("mason").setup({
            ui = {
                border = "rounded"
            }
        })
        require("mason-lspconfig").setup({
            ensure_installed = { "gopls", "rust_analyzer", "ts_ls", "bashls", "dockerls", "lua_ls", "marksman" },
            automatic_installation = true
        })

        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    silent = true,
                    buffer = bufnr,
                    desc = desc
                })
            end

            -- 导航
            map("n", "gd", vim.lsp.buf.definition, "跳转到定义")
            map("n", "gD", vim.lsp.buf.declaration, "跳转到声明")
            map("n", "gr", vim.lsp.buf.references, "查找引用")
            map("n", "gi", vim.lsp.buf.implementation, "跳转到实现")
            map("n", "K", vim.lsp.buf.hover, "悬停信息")

            -- 编辑
            map("n", "<Leader>rn", vim.lsp.buf.rename, "重命名")
            map("n", "<Leader>ca", vim.lsp.buf.code_action, "代码操作")
            map("n", "<Leader>f", function()
                vim.lsp.buf.format({
                    async = true
                })
            end, "格式化")

            -- 诊断
            map("n", "[d", vim.diagnostic.goto_prev, "上一个诊断")
            map("n", "]d", vim.diagnostic.goto_next, "下一个诊断")
            map("n", "<Leader>d", vim.diagnostic.open_float, "显示诊断")
            map("n", "<Leader>dl", vim.diagnostic.setloclist, "诊断列表")
        end

        -- 针对各语言的差异化设置
        local servers = {
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            },
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = true,
                        cargo = {
                            loadOutDirsFromCheck = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            },
            dartls = {
                settings = {
                    dart = {
                        showTodos = true,
                        completeFunctionCalls = true,
                    },
                },
            },
            bashls = {},
            dockerls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false
                        },
                        telemetry = {
                            enable = false
                        },
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            },
            marksman = {},
            sourcekit = {},
            ts_ls = {
                on_attach = function(client, bufnr)
                    -- 若仍用 prettier 格式化，这里同样禁用 LSP 自带 formatter
                    client.server_capabilities.documentFormattingProvider = false
                    on_attach(client, bufnr)
                end
            }
        }
        for name, cfg in pairs(servers) do
            cfg.capabilities = capabilities
            cfg.on_attach = cfg.on_attach or on_attach
            lspconfig[name].setup(cfg)
        end
    end
} }

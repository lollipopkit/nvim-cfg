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
            ensure_installed = {
                "gopls",
                "rust_analyzer",
                "tsserver",
                "bashls",
                "dockerls",
                "lua_ls",
                "marksman",
                --"dartls",
            },
            automatic_installation = true,
        })

        local lspconfig = require("lspconfig")
        local lsp = require("configs.lsp")
        local capabilities = lsp.get_capabilities()

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
        }
        for name, cfg in pairs(servers) do
            local extra_on_attach = cfg.on_attach
            cfg.capabilities = capabilities
            cfg.on_attach = lsp.with_on_attach(extra_on_attach)
            lspconfig[name].setup(cfg)
        end
    end
} }

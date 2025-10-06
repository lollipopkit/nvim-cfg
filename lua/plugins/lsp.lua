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
                -- "tsserver",
                "bashls",
                "dockerls",
                "lua_ls",
                "marksman",
                --"dartls",
            },
            automatic_installation = true,
        })

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
        local configured_servers = {}
        local has_native_config = vim.fn.has("nvim-0.11") == 1 and vim.lsp and vim.lsp.config and vim.lsp.enable
        local legacy_lspconfig
        if not has_native_config then
            local ok, mod = pcall(require, "lspconfig")
            if ok then
                legacy_lspconfig = mod
            else
                vim.notify("nvim-lspconfig is not available", vim.log.levels.WARN)
                return
            end
        end

        for name, cfg in pairs(servers) do
            local extra_on_attach = cfg.on_attach
            cfg.capabilities = capabilities
            cfg.on_attach = lsp.with_on_attach(extra_on_attach)
            if has_native_config then
                vim.lsp.config(name, cfg)
                table.insert(configured_servers, name)
            elseif legacy_lspconfig and legacy_lspconfig[name] then
                legacy_lspconfig[name].setup(cfg)
            end
        end

        if has_native_config and #configured_servers > 0 then
            vim.lsp.enable(configured_servers)
        end
    end
} }

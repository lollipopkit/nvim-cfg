-- ~/.config/nvim/lua/plugins/lsp.lua
return {
    {
        "neovim/nvim-lspconfig",
        event        = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config       = function()
            require("neodev").setup({})

            require("mason").setup({ ui = { border = "rounded" } })
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls", "rust_analyzer", "ts_ls",
                    "bashls", "dockerls", "lua_ls", "marksman",
                },
                automatic_installation = true,
            })

            local lspconfig    = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach    = function(_, bufnr)
                local map = function(mode, lhs, rhs)
                    vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr })
                end
                map("n", "gd", vim.lsp.buf.definition)
                map("n", "gD", vim.lsp.buf.declaration)
                map("n", "gr", vim.lsp.buf.references)
                map("n", "K", vim.lsp.buf.hover)
                map("n", "<Leader>rn", vim.lsp.buf.rename)
                map("n", "<Leader>ca", vim.lsp.buf.code_action)
                map("n", "<Leader>f", function() vim.lsp.buf.format({ async = true }) end)
            end

            -- 针对各语言的差异化设置
            local servers      = {
                gopls         = {},
                rust_analyzer = {},
                dartls        = {},
                bashls        = {},
                dockerls      = {},
                lua_ls        = {
                    settings = {
                        Lua = {
                            workspace   = { checkThirdParty = false },
                            telemetry   = { enable = false },
                            diagnostics = { globals = { "vim" } },
                        },
                    },
                },
                marksman      = {},
                sourcekit     = {},
                ts_ls         = {
                    on_attach = function(client, bufnr)
                        -- 若仍用 prettier 格式化，这里同样禁用 LSP 自带 formatter
                        client.server_capabilities.documentFormattingProvider = false
                        on_attach(client, bufnr)
                    end,
                },
            }
            for name, cfg in pairs(servers) do
                cfg.capabilities = capabilities
                cfg.on_attach    = cfg.on_attach or on_attach
                lspconfig[name].setup(cfg)
            end
        end,
    },
}

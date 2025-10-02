return {
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = { "rust" },
        dependencies = { "neovim/nvim-lspconfig" },
        init = function()
            local lsp = require("configs.lsp")
            vim.g.rustaceanvim = {
                server = {
                    on_attach = lsp.with_on_attach(function(_, bufnr)
                        local map = function(lhs, rhs, desc)
                            vim.keymap.set("n", lhs, rhs, {
                                buffer = bufnr,
                                silent = true,
                                desc = desc,
                            })
                        end
                        map("<Leader>rr", "<cmd>RustLsp runnables<CR>", "Rust runnables")
                        map("<Leader>rk", "<cmd>RustLsp expandMacro<CR>", "Rust expand macro")
                    end),
                    capabilities = lsp.get_capabilities(),
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                            },
                            check = {
                                command = "clippy",
                            },
                            procMacro = {
                                enable = true,
                            },
                        },
                    },
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                        border = "rounded",
                    },
                    inlay_hints = {
                        auto = true,
                    },
                },
            }
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function()
            local lsp = require("configs.lsp")
            return {
                capabilities = lsp.get_capabilities(),
                on_attach = lsp.on_attach,
                settings = {
                    tsserver_file_preferences = {
                        includeCompletionsForModuleExports = true,
                        includeInlayParameterNameHints = "all",
                        includeInlayVariableTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                    },
                    tsserver_format_options = {
                        allowIncompleteCompletions = false,
                        allowRenameOfImportPath = true,
                    },
                    complete_function_calls = true,
                },
            }
        end,
    },
    {
        "ray-x/go.nvim",
        ft = { "go", "gomod", "gowork", "gosum" },
        dependencies = { "ray-x/guihua.lua" },
        config = function()
            require("go").setup({
                gofmt = "goimports",
                lsp_cfg = false,
                lsp_keymaps = false,
                lsp_inlay_hints = {
                    enable = true,
                },
                test_runner = "go",
                run_in_floaterm = true,
            })
        end,
    },
    {
        "akinsho/flutter-tools.nvim",
        ft = { "dart" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            local lsp = require("configs.lsp")
            require("flutter-tools").setup({
                widget_guides = {
                    enabled = true,
                },
                closing_tags = {
                    highlight = "Comment",
                    prefix = "// ",
                },
                dev_tools = {
                    auto_open_browser = false,
                },
                lsp = {
                    on_attach = lsp.on_attach,
                    capabilities = lsp.get_capabilities(),
                    settings = {
                        dart = {
                            completeFunctionCalls = true,
                            showTodos = true,
                        },
                    },
                },
            })
        end,
    },
}

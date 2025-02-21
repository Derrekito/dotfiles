return {
    -- Mason configuration for LSP server management
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        lazy = false,
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { 'clangd', 'rust_analyzer', 'bashls', 'lua_ls', 'marksman', 'pylsp', 'jsonls', 'texlab' },
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        local opts = {} -- Initialize server-specific options
                        if server_name == "clangd" then
                            opts.cmd = {
                                "clangd",
                                "--background-index",
                                "--suggest-missing-includes",
                                "--clang-tidy",
                                "--header-insertion=iwyu",
                                "--header-insertion-decorators"
                            }
                        elseif server_name == "lua_ls" then
                            -- Special setup for lua_ls
                            opts.settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = {'vim', 'bufnr'},
                                    },
                                },
                            }
                            elseif server_name == "pylsp" then
                                opts.settings = {
                                    pylsp = {
                                        configurationSources = { "pycodestyle" }, -- Ensure pycodestyle is the source
                                        plugins = {
                                            pycodestyle = {
                                                enabled = true,
                                                ignore = {'W391'},
                                                maxLineLength = 140
                                            },
                                            flake8 = { enabled = false},
                                            pylint = { enabled = false }, -- Disable others to isolate pycodestyle
                                            pyflakes = { enabled = false },
                                        },
                                    },
                                }
                                opts.on_attach = function(client, bufnr)
                                    vim.diagnostic.config({
                                        virtual_text = true,
                                        signs = true,
                                        underline = true,
                                    })
                                end
                        end
                        require("lspconfig")[server_name].setup(opts)
                    end,
                }
            }

        end,
    },

    -- LuaSnip configuration
    {
        "L3MON4D3/LuaSnip",
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    -- nvim-lspconfig for setting up LSP servers
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
        },
        lazy = false,
        config = function()
            -- Key mappings for LSP functionalities
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}

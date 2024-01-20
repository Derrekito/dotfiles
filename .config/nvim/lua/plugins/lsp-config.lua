return {
    -- Mason configuration for LSP server management
    {
        "williamboman/mason.nvim",
        lazy = false,  -- Adjust this based on your preference
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
            require("mason-lspconfig").setup({
                ensure_installed = {
                    'clangd', 'rust_analyzer', 'bashls', 'lua_ls', 'marksman', 'pylsp', 'jsonls', 'texlab'
                },
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        if server_name == "lua_ls" then
                            -- Special setup for lua_ls
                            require("lspconfig")[server_name].setup{
                                settings = {
                                    Lua = {
                                        diagnostics = {
                                            globals = {'vim', 'bufnr'},
                                        },
                                    },
                                },
                            }
                        else
                            -- Generic setup for other servers
                            require("lspconfig")[server_name].setup{}
                        end
                    end,
                }
            })
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

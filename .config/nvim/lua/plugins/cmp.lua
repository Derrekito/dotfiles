return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
        'hrsh7th/cmp-path',
        name = "path",
        lazy = false
    },
    {
        "hrsh7th/cmp-buffer",
        event = "InsertEnter",  -- This triggers loading when entering insert mode
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    {
                        name = 'buffer',
                        option = {
                            get_bufnrs = function()
                                local bufs = {}
                                for _, win in ipairs(vim.api.nvim_list_wins()) do
                                    bufs[vim.api.nvim_win_get_buf(win)] = true
                                end
                                return vim.tbl_keys(bufs)
                            end
                        }
                    }
                }
            })
        end
    },
    -- Configuration for cmp-cmdline (lazy loading)
    {
        'hrsh7th/cmp-cmdline',
        event = 'CmdlineEnter', -- Load this plugin when entering command line mode
        config = function()
            local cmp = require('cmp')

            -- `/` cmdline setup
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- `:` cmdline setup
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })
        end,
    },
    -- Configuration for cmp-nvim-lsp
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = false,
        config = function()
            -- Update capabilities for LSP servers
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Configure each LSP server
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup({
                capabilities = capabilities,
                -- Additional configuration for clangd
            })

            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                -- Additional configuration for rust_analyzer
            })

            lspconfig.bashls.setup({
                capabilities = capabilities,
                -- Additional configuration for bashls
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                -- Additional configuration for lua_ls
            })

            lspconfig.marksman.setup({
                capabilities = capabilities,
                -- Additional configuration for marksman
            })

            lspconfig.pylsp.setup({
                capabilities = capabilities,
                -- Additional configuration for pylsp
            })

            lspconfig.jsonls.setup({
                capabilities = capabilities,
                -- Additional configuration for jsonls
            })

            lspconfig.texlab.setup({
                capabilities = capabilities,
                -- Additional configuration for texlab
            })
        end,
    },
}

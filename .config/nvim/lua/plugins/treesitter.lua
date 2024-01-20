return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "javascript", "typescript", "c", "lua", "rust", "vim", "vimdoc", "query", "latex" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            }

            -- Using an autocommand to run :TSUpdate after plugin is loaded
            vim.api.nvim_create_autocmd("User", {
                pattern = "PluginLoaded",
                callback = function(args)
                    if args.match == "nvim-treesitter/nvim-treesitter" then
                        vim.cmd(":TSUpdate")
                    end
                end,
            })
        end
    }
}

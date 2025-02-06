return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- Add protection against startup errors
            local status_ok, configs = pcall(require, "nvim-treesitter.configs")
            if not status_ok then
                return
            end

            configs.setup({
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "c",
                    "lua",
                    "rust",
                    "vim",
                    "vimdoc",
                    "query",
                    "latex",
                    "markdown",
                    "make",
                    "cuda",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    -- Add disable list for problematic files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                indent = {
                    enable = true,
                    disable = {} -- Add any languages that have problematic indentation
                },
            })

            -- Add parser settings if needed
            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            -- Example of parser configuration if needed:
            -- parser_config.mylang = {
            --     install_info = {
            --         url = "...",
            --         files = {"..."}
            --     }
            -- }
        end
    }
}

return {
    "lukas-reineke/headlines.nvim",
    config = function()
        -- Define custom highlights
        --vim.cmd("highlight Headline1 guibg=#1e2718")
        --vim.cmd("highlight Headline2 guibg=#21262d")
        --vim.cmd("highlight CodeBlock guibg=#1c1c1c")
        --vim.cmd("highlight Dash guibg=#D19A66 gui=bold")

        -- Set up the plugin with configuration
        require("lazy").setup({
            dependencies = "nvim-treesitter/nvim-treesitter",
            config = true, -- or alternatively, you can specify `opts = {}`
            org = {
                headline_highlights = { "Headline1", "Headline2" },
            },
        })
    end
}

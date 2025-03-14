return {
  "lukas-reineke/headlines.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Tree-sitter is required
  ft = { "markdown", "org" },                           -- Lazy-load on Markdown and Org-mode files
  config = function()
    -- Define custom highlights
    vim.cmd("highlight Headline1 guibg=#1e2718")     -- Dark green for H1
    vim.cmd("highlight Headline2 guibg=#21262d")     -- Dark gray for H2
    vim.cmd("highlight CodeBlock guibg=#1c1c1c")     -- Near-black for code
    vim.cmd("highlight Dash guibg=#D19A66 gui=bold") -- Orange bold dashes

    -- Set up the plugin
    require("headlines").setup({
      markdown = {
        headline_highlights = { "Headline1", "Headline2" }, -- Apply to Markdown headings
        codeblock_highlight = "CodeBlock",                  -- Style code blocks
        dash_highlight = "Dash",                            -- Style dashes (---)
        fat_headlines = true,                               -- Optional: thicker headline borders
      },
      org = {                                               -- Assuming you meant Org-mode; skip if not needed
        headline_highlights = { "Headline1", "Headline2" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
      },
    })
  end,
}


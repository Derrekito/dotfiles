return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local none_ls = require("none-ls")
        none_ls.setup({
            debug = true,
            sources = {
                none_ls.builtins.diagnostics.checkmake,
            },
        })
    end,
}

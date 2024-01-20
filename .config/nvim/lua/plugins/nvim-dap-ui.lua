return  {
    "rcarriga/nvim-dap-ui",
    name = "dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
        require("dapui").setup()

        -- Correctly using the Lua require format for dap-ui commands
        vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require('dapui').open({reset = true})<CR>", { noremap = true, silent = true })
    end,
    after = "nvim-dap" -- Load nvim-dap-ui after nvim-dap
}

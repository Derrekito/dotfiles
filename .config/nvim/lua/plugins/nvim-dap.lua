return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            -- Setting keymaps for nvim-dap
            vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true })
        end,
        event = "BufReadPre" -- You can set this to an appropriate event for lazy loading
    },
    {
        "rcarriga/nvim-dap-ui",
        name = "dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()

            vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require('dapui').open({reset = true})<CR>", { noremap = true, silent = true })
        end,
        after = "nvim-dap" -- Load nvim-dap-ui after nvim-dap
    }
}

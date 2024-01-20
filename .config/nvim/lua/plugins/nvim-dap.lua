return {
    "mfussenegger/nvim-dap",
    config = function()
        -- Setting keymaps for nvim-dap
        vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true })
    end,
    event = "BufReadPre" -- You can set this to an appropriate event for lazy loading
}

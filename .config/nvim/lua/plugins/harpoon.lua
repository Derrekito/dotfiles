return {
    {
        "ThePrimeagen/harpoon",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require('harpoon').setup() -- if there are specific setup options, include them here
            vim.keymap.set("n", "<leader>a", require('harpoon.mark').add_file)
            vim.keymap.set("n", "<C-e>", require('harpoon.ui').toggle_quick_menu)
        end,
        keys = {
            "<leader>a",
            "<C-e>"
        }
    }
}

return {
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('harpoon').setup({
        menu = {
          width = 80, -- Wider menu for longer filenames
        },
      })
      -- Keymaps
      vim.keymap.set("n", "<leader>a", require('harpoon.mark').add_file, { desc = "Harpoon: Add file" })
      vim.keymap.set("n", "<C-e>", require('harpoon.ui').toggle_quick_menu, { desc = "Harpoon: Toggle menu" })
      -- Direct jumps to first 4 files
      vim.keymap.set("n", "<leader>1", function() require('harpoon.ui').nav_file(1) end, { desc = "Harpoon: File 1" })
      vim.keymap.set("n", "<leader>2", function() require('harpoon.ui').nav_file(2) end, { desc = "Harpoon: File 2" })
      vim.keymap.set("n", "<leader>3", function() require('harpoon.ui').nav_file(3) end, { desc = "Harpoon: File 3" })
      vim.keymap.set("n", "<leader>4", function() require('harpoon.ui').nav_file(4) end, { desc = "Harpoon: File 4" })
    end,
    keys = {
      "<leader>a", "<C-e>", "<leader>1", "<leader>2", "<leader>3", "<leader>4"
    },
  }
}


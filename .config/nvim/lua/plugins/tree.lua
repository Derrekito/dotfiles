-- ~/.config/nvim/lua/plugins/tree.lua

return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",                   -- Optional: pins to latest version
    lazy = false,                    -- Load immediately to overwrite <leader>pv
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Optional: for file icons
    },
    keys = {
      -- Overwrite <leader>pv with nvim-tree toggle
      { "<leader>pv", "<cmd>NvimTreeToggle<CR>", desc = "Toggle Project View (nvim-tree)" },
    },
    config = function()
      -- Disable netrw to avoid conflicts
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Configure nvim-tree
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end,
  },
}

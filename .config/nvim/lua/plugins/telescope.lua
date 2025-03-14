-- plugins/telescope.lua:
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require("telescope").setup {
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      vim.keymap.set("n", "<leader>ph", require('telescope.builtin').help_tags)
      vim.keymap.set("n", "<leader>pf", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<leader>en", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
      vim.keymap.set("n", "<leader>ep", function()
        local data_path = vim.fn.stdpath("data")
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath(data_path), "lazy")
        }
      end)

      --require "config.telescope.multigrep".setup()
      vim.keymap.set("n", "<leader>mg", require("config.telescope.multigrep").live_multigrep, { desc = "Multi Grep" })
    end
  }
}

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional but recommended
  config = function()
    require("trouble").setup({
      icons = false,                 -- Your original setting
      auto_open = false,             -- Don’t open on new diagnostics
      auto_close = false,            -- Don’t close when diagnostics clear
      auto_preview = true,           -- Preview diagnostic location
      debug = false,                 -- Disable debug mode
      -- Add other useful options
      mode = "document_diagnostics", -- Default mode (can be toggled)
      padding = true,                -- Add padding around the window
      indent = true,                 -- Indent folded items
    })

    -- Your keybindings
    vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Trouble" })
    vim.keymap.set("n", "<leader>[d", function()
      require("trouble").next({ skip_groups = true, jump = true })
    end, { desc = "Next diagnostic" })
    vim.keymap.set("n", "]d", function()
      require("trouble").previous({ skip_groups = true, jump = true })
    end, { desc = "Previous diagnostic" })
  end
}


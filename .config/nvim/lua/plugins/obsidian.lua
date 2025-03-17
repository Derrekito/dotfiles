return {
  "epwalsh/obsidian.nvim",
  version = "*", -- Use the latest version
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp", -- Add this since you're using nvim-cmp
  },
  opts = {
    workspaces = {
      { name = "vaults", path = "~/vaults" },
    },
    completion = {
      nvim_cmp = true,                    -- Enable nvim-cmp integration
      min_chars = 2,                      -- Minimum characters to trigger completion
      new_notes_location = "current_dir", -- Where new notes are created
      -- Remove deprecated options and replace with wiki_link_func
    },
    -- Remove mappings from opts; we'll handle them manually
  },
  config = function(_, opts)
    -- Define wiki_link_func to replace deprecated options
    opts.completion.wiki_link_func = function(options)
      -- Replicate prepend_note_id = true behavior
      if options.id then
        return string.format("[[%s]]", options.id)
      elseif options.path then
        return string.format("[[%s]]", options.path)
      else
        return string.format("[[%s]]", options.label)
      end
    end

    -- Setup the plugin with updated opts
    require("obsidian").setup(opts)

    -- Custom function to check if current buffer is in a vault
    local function is_in_vault()
      local current_file = vim.api.nvim_buf_get_name(0)
      local normalized_file = vim.fn.fnamemodify(current_file, ":p")
      for _, workspace in ipairs(opts.workspaces) do
        local vault_path = vim.fn.expand(workspace.path) -- Expand ~ to full path
        if normalized_file:find(vault_path, 1, true) == 1 then
          return true
        end
      end
      return false
    end

    -- Set mappings only for buffers in vaults
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.md",
      callback = function()
        if is_in_vault() then
          vim.keymap.set("n", "gf", function()
            return require("obsidian").util.gf_passthrough()
          end, { noremap = false, expr = true, buffer = true })

          vim.keymap.set("n", "<leader>ch", function()
            return require("obsidian").util.toggle_checkbox()
          end, { buffer = true })
        end
      end,
    })
  end,
}

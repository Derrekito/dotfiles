return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      { name = "personal",  path = "~/vaults/personal" },
      { name = "work",      path = "~/vaults/work" },
      { name = "templates", path = "~/vaults/Templates" },
    },
    -- Moved from completion to top-level
    new_notes_location = "current_dir", -- Create new notes in current directory
    preferred_link_style = "markdown",  -- Use Markdown-style links (e.g., [note](path))
    completion = {
      nvim_cmp = true,                  -- Enable nvim-cmp integration
      min_chars = 2,                    -- Trigger completion after 2 characters
      wiki_link_func = function(opts)
        -- Mimics prepend_note_id = true behavior
        return require("obsidian").util.wiki_link_id_prefix(opts)
      end,
    },
    -- Remove mappings from opts; we'll handle them manually
  },
  config = function(_, opts)
    -- Setup the plugin with opts
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


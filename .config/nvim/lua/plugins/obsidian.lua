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
      { name = "personal", path = "~/vaults/personal" },
      { name = "work",     path = "~/vaults/work" },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
      new_notes_location = "current_dir",
      preferred_link_style = "markdown",
      prepend_note_id = true,
      prepend_note_path = false,
      use_path_only = false,
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


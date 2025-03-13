return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      -- Check for fd (a fast file search tool)
      local has_fd = vim.fn.executable("fd") == 1

      -- List of file extensions considered as "text files"
      local text_extensions = {
        "txt", "md", "rst", "c", "cpp", "cc", "cxx", "h", "hpp", "hh",
        "py", "rb", "rs", "go", "js", "ts", "lua", "sh", "bash", "zsh",
        "fish", "conf", "cfg", "ini", "yaml", "yml", "toml", "json", "vim",
        "el", "css", "html", "xml"
      }

      local find_command = {}
      if has_fd then
        -- Build the fd command with specified extensions
        find_command = { "fd", "--type", "f", "--hidden", "--follow" }
        for _, ext in ipairs(text_extensions) do
          table.insert(find_command, "-e")
          table.insert(find_command, ext)
        end
      else
        -- Fallback to find if fd is not available
        find_command = { "find", vim.fn.getcwd(), "-type", "f", "(" }
        local first = true
        for _, ext in ipairs(text_extensions) do
          if not first then
            table.insert(find_command, "-o")
          end
          first = false
          table.insert(find_command, "-name")
          table.insert(find_command, "*." .. ext)
        end
        table.insert(find_command, ")")
      end

      -- Determine search directory:
      -- If the current buffer is netrw, use its directory (vim.b.netrw_curdir).
      -- Otherwise, use the current working directory.
      local search_dir = vim.fn.getcwd()
      local cur_ft = vim.api.nvim_buf_get_option(0, "filetype")
      if cur_ft == "netrw" and vim.b.netrw_curdir then
        search_dir = vim.b.netrw_curdir
      end

      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = "> ",
          selection_caret = "> ",
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-u>"] = false, -- Allow clearing the prompt
            },
          },
        },
        pickers = {
          find_files = {
            search_dirs = { search_dir },
            hidden = true,
            find_command = find_command,
          },
        },
      })

      -- Load the native fuzzy sorter for performance
      require("telescope").load_extension("fzy_native")

      -- Keybindings
      vim.keymap.set("n", "<leader>pf", require("telescope.builtin").find_files, { desc = "Find text files" })
      vim.keymap.set("n", "<leader>pg", require("telescope.builtin").live_grep, { desc = "Fuzzy grep" })
      vim.keymap.set("n", "<leader>pb", require("telescope.builtin").buffers, { desc = "List buffers" })
      vim.keymap.set("n", "<leader>ph", require("telescope.builtin").help_tags, { desc = "Help tags" })
    end,
  },
}


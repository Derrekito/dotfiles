return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Python setup
      dap.adapters.python = {
        type = "executable",
        command = "python", -- Adjust if your Python binary is different (e.g., "python3")
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch Python file",
          program = "${file}",   -- Current file
          pythonPath = "python", -- Adjust if needed (e.g., "/usr/bin/python3")
        },
      }

      -- C/C++ and CUDA setup (using cpptools)
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.fn.expand("~/.vscode/extensions/ms-vscode.cpptools-*/debugAdapters/bin/OpenDebugAD7"), -- Adjust path
        options = {
          detached = false,
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch C/C++/CUDA",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.expand("%:p:r"), "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "Enable pretty-printing for gdb",
              ignoreFailures = true,
            },
          },
        },
      }
      -- Reuse C++ config for C and CUDA
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.cuda = dap.configurations.cpp -- CUDA uses same debugger (gdb/lldb via cpptools)

      -- Keymaps
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { noremap = true, silent = true }) -- Extra: step over
      vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true, silent = true }) -- Extra: step into
      vim.keymap.set("n", "<leader>do", dap.step_out, { noremap = true, silent = true })  -- Extra: step out
    end,
    event = "BufReadPre",
  },
  {
    "rcarriga/nvim-dap-ui",
    name = "dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
      vim.keymap.set("n", "<leader>dt", require("dapui").toggle, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>dr", function() require("dapui").open({ reset = true }) end,
        { noremap = true, silent = true })
    end,
  },
  { "nvim-neotest/nvim-nio" },
}


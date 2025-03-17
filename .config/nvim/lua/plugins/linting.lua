return {
  'dense-analysis/ale',
  config = function()
    local g = vim.g

    -- Linters for all filetypes, including CUDA
    g.ale_linters = {
      -- Lua
      lua = { 'luacheck' },

      -- Make
      make = { 'checkmake' },

      -- CMake
      cmake = { 'cmakelint' },

      -- C/C++
      c = { 'cppcheck', 'clang' },
      cpp = { 'cppcheck', 'clang' },

      -- CUDA
      cuda = { 'nvcc', 'clang' }, -- nvcc for CUDA-specific, clang for extra checks

      -- Python
      python = { 'flake8', 'pylint' },

      -- Ruby
      ruby = { 'rubocop', 'ruby' },

      -- JavaScript/TypeScript
      javascript = { 'eslint' },
      typescript = { 'eslint', 'tsserver' },

      -- Bash/Shell
      sh = { 'shellcheck' },

      -- Markdown
      markdown = { 'markdownlint' },

      -- Rust
      rust = { 'cargo' },

      -- Go
      go = { 'golangci-lint' },

      -- Java
      java = { 'checkstyle' },
    }

    -- Customize nvcc for CUDA linting
    g.ale_cuda_nvcc_options = '-Xcompiler -Wall -Wextra' -- Extra warnings

    -- Your triggers
    g.ale_lint_on_insert_leave = 1
    g.ale_lint_on_text_changed = 'always'

    -- Fixers (no CUDA-specific fixer, reusing C++)
    g.ale_fixers = {
      python = { 'black', 'isort' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      cuda = { 'clang-format' }, -- Works if clang supports CUDA
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      markdown = { 'prettier' },
      rust = { 'rustfmt' },
      go = { 'gofmt' },
    }
    g.ale_fix_on_save = 1
  end,
}


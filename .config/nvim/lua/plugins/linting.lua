return {
  'dense-analysis/ale', -- ALE plugin for linting and fixing
  config = function()
    local g = vim.g     -- Alias for vim.g to keep things concise

    -- Linters for all filetypes, including CUDA
    g.ale_linters = {
      -- Lua linting
      lua = { 'luacheck' },
      -- Makefile linting
      make = { 'checkmake' },
      -- CMake linting
      cmake = { 'cmakelint' },
      -- C linting with multiple tools
      c = { 'cppcheck', 'clang' },
      -- C++ linting with multiple tools
      cpp = { 'cppcheck', 'clang' },
      -- CUDA linting: nvcc for CUDA-specific checks, clang for extra C++-style checks
      cuda = { 'nvcc', 'clang' },
      -- Python linting with flake8 and pylint
      python = { 'flake8', 'pylint' },
      -- Ruby linting
      ruby = { 'rubocop', 'ruby' },
      -- JavaScript linting
      javascript = { 'eslint' },
      -- TypeScript linting with ESLint and TypeScript server
      typescript = { 'eslint', 'tsserver' },
      -- Bash/Shell script linting
      sh = { 'shellcheck' },
      -- Markdown linting
      markdown = { 'markdownlint' },
      -- Rust linting via cargo
      rust = { 'cargo' },
      -- Go linting
      go = { 'golangci-lint' },
      -- Java linting
      java = { 'checkstyle' },
    }

    -- Customize nvcc options for CUDA linting
    g.ale_cuda_nvcc_options = '-Xcompiler -Wall -Wextra' -- Enable extra warnings for CUDA files

    -- Python linter options to enforce 140-character line length
    g.ale_python_flake8_options = '--max-line-length=140' -- Set flake8 line length to 140
    g.ale_python_pylint_options = '--max-line-length=140' -- Set pylint line length to 140

    -- Linting triggers
    g.ale_lint_on_insert_leave = 1        -- Lint when leaving insert mode
    g.ale_lint_on_text_changed = 'always' -- Lint continuously as text changes

    -- Fixers for various filetypes (no CUDA-specific fixer, reusing C++)
    g.ale_fixers = {
      -- Python fixing with black (formatter) and isort (import sorter)
      python = { 'black', 'isort' },
      -- C code formatting
      c = { 'clang-format' },
      -- C++ code formatting
      cpp = { 'clang-format' },
      -- CUDA formatting (using clang-format, works if CUDA support is enabled)
      cuda = { 'clang-format' },
      -- JavaScript formatting
      javascript = { 'prettier' },
      -- TypeScript formatting
      typescript = { 'prettier' },
      -- Markdown formatting
      markdown = { 'prettier' },
      -- Rust formatting
      rust = { 'rustfmt' },
      -- Go formatting
      go = { 'gofmt' },
    }
    -- Enable fixing on save for all configured fixers
    g.ale_fix_on_save = 1
  end,
}

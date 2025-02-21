return {
  {
    'dense-analysis/ale',
    lazy = false,
    config = function()
      local g = vim.g
      g.ale_linters = {
        ruby = { 'rubocop', 'ruby' },
        lua = { 'lua_language_server' },
        make = { 'checkmake' },
        python = { 'flake8', 'pylint' },
      }
      -- Set flake8 max-line-length to 140
      g.ale_python_flake8_options = '--max-line-length=140'
      g.ale_lint_on_insert_leave = 1
      g.ale_lint_on_text_changed = 'always'
    end,
  },
}

return {
  {
    'dense-analysis/ale',
    lazy = false,  -- Force loading on startup
    config = function()
      local g = vim.g

      -- Configure ALE linters for different filetypes
      g.ale_linters = {
        ruby = { 'rubocop', 'ruby' },
        lua = { 'lua_language_server' },
        make = { 'checkmake' },  -- Use checkmake for Makefiles
      }

      -- Optional: run linting when leaving insert mode and on text changes
      g.ale_lint_on_insert_leave = 1
      g.ale_lint_on_text_changed = 'always'
    end,
  },
}

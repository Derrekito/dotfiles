return {
  'rose-pine/neovim',
  config = function()
    local palette = require('rose-pine.palette')  -- Grab the palette for access to colors

    require('rose-pine').setup({
      variant = 'moon',
      dark_variant = 'main',
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = true,  -- Keeps transparency/terminal background
      disable_float_background = false,
      disable_italics = false,
      groups = {
        background = 'base',                -- Active pane background (rose-pine's "base")
        background_nc = '_experimental_nc',   -- Inactive pane background (set via NormalNC)
        panel = 'surface',
        panel_nc = 'base',
        border = 'highlight_med',
        comment = 'muted',
        link = 'iris',
        punctuation = 'subtle',
        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',
        headings = {
          h1 = 'iris',
          h2 = 'foam',
          h3 = 'rose',
          h4 = 'gold',
          h5 = 'pine',
          h6 = 'foam',
        },
      },
      highlight_groups = {
        -- These initial values will be overridden in the active window.
        ColorColumn = { bg = palette.base, blend = 0 },
        CursorLine  = { bg = palette.base, blend = 0 },
        StatusLine  = { fg = 'love', bg = 'love', blend = 10 },
        Search      = { bg = 'gold', inherit = false },
        NormalNC    = { bg = "#1f1d2e" },  -- Inactive pane remains unchanged
      }
    })

    vim.cmd('colorscheme rose-pine')

    local active_color = "#1f1d2e"  -- Both active cursor line and active column will use this color

    -- Define highlight groups for the active window
    vim.api.nvim_set_hl(0, "ActiveCursorLine", { bg = active_color, blend = 0 })
    vim.api.nvim_set_hl(0, "ActiveColorColumn", { bg = active_color, blend = 0 })

    -- Immediately set winhl for the current window so it applies even if there's only one pane.
    vim.wo.winhl = "CursorLine:ActiveCursorLine,ColorColumn:ActiveColorColumn"

    -- Autocommands to update these overrides when switching windows.
    vim.api.nvim_create_autocmd("WinEnter", {
      pattern = "*",
      callback = function()
        vim.wo.winhl = "CursorLine:ActiveCursorLine,ColorColumn:ActiveColorColumn"
      end,
    })

    vim.api.nvim_create_autocmd("WinLeave", {
      pattern = "*",
      callback = function()
        vim.wo.winhl = ""
      end,
    })
  end,
}

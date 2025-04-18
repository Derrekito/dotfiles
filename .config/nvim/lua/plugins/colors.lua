return {
  'rose-pine/neovim',
  config = function()
    require('rose-pine').setup({
      variant = 'moon',
      dark_variant = 'main',
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = true, -- Keeps transparency or terminal background
      disable_float_background = false,
      disable_italics = false,
      groups = {
        background = 'base',
        background_nc = '_experimental_nc', -- For inactive panes
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
        ColorColumn = { bg = 'love', blend = 1 },
        CursorLine = { bg = 'foam', blend = 1 },
        StatusLine = { fg = 'love', bg = 'love', blend = 10 },
        Search = { bg = 'gold', inherit = false },
        -- Make inactive window background darker
        -- NormalNC = { bg = "#1a1826" },  -- Darker for inactive panes
        NormalNC = { bg = "#1f1d2e" }, -- Actually darker than active background
      }
    })
    vim.cmd('colorscheme rose-pine')
  end
}

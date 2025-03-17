-- ~/.config/nvim/after/ftplugin/pandoc-latex.lua
local ext = vim.fn.expand("%:e")
if ext == "latex" then
  vim.bo.filetype = "pandoc-latex"
  -- Load tex syntax as a base
  vim.api.nvim_buf_call(0, function()
    vim.cmd("syntax enable")
    vim.cmd("set syntax=tex")
  end)
  -- Clear tex math zones
  vim.api.nvim_buf_call(0, function()
    vim.cmd("syntax clear texMathZoneX")
    vim.cmd("syntax clear texMathZoneY")
  end)
  -- Define custom highlight groups with Rosé Pine Moon colors (buffer-local)
  vim.api.nvim_set_hl(0, "PandocVariable", { fg = "#f6c177" })                               -- Gold for $title$
  vim.api.nvim_set_hl(0, "PandocFunction", { fg = "#9ccfd8" })                               -- Foam for ${whatever()}
  vim.api.nvim_set_hl(0, "PandocConditional", { fg = "#c4a7e7" })                            -- Iris for $if(foo)$
  vim.api.nvim_set_hl(0, "PandocLoop", { fg = "#31748f" })                                   -- Pine for $for(bar)$
  vim.api.nvim_set_hl(0, "PandocDelimiter", { fg = "#eb6f92" })                              -- Rose for $
  -- Define Pandoc macro highlighting (buffer-local)
  vim.fn.matchadd("PandocVariable", [[\$[a-zA-Z0-9._-]\+\$]], 10, -1, { buffer = 0 })        -- $title$
  vim.fn.matchadd("PandocFunction", [[\${[a-zA-Z0-9._-]\+([^)]*)}]], 10, -1, { buffer = 0 }) -- ${whatever()}
  vim.fn.matchadd("PandocConditional", [[\$if([a-zA-Z0-9._-]\+)\$]], 10, -1, { buffer = 0 }) -- $if(foo)$
  vim.fn.matchadd("PandocConditional", [[\$else\$]], 10, -1, { buffer = 0 })                 -- $else$
  vim.fn.matchadd("PandocConditional", [[\$endif\$]], 10, -1, { buffer = 0 })                -- $endif$
  vim.fn.matchadd("PandocLoop", [[\$for([a-zA-Z0-9._-]\+)\$]], 10, -1, { buffer = 0 })       -- $for(bar)$
  vim.fn.matchadd("PandocLoop", [[\$endfor\$]], 10, -1, { buffer = 0 })                      -- $endfor$
  vim.fn.matchadd("PandocDelimiter", [[\$]], 10, -1, { buffer = 0 })                         -- Standalone $
  -- Clear gutter signs (like "I")
  vim.fn.sign_unplace("*", { buffer = vim.api.nvim_get_current_buf() })
end

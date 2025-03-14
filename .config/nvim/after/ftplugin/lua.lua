-- Set buffer-local indentation settings
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Auto-format on save with 2-space indentation
--vim.api.nvim_create_autocmd("BufWritePre", {
--  buffer = 0, -- Apply to current Lua buffer
--  callback = function()
--  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--  local formatted = {}
--  for _, line in ipairs(lines) do
--    local trimmed = line:gsub("^%s+", "") -- Remove leading whitespace
--    local indent = line:match("^%s+") or "" -- Get original indent
--    local level = math.floor(#indent / 4) -- Guess indent level (assuming 4-space input)
--    if #indent % 4 > 0 then level = level + 1 end -- Handle odd spacing
--    table.insert(formatted, string.rep("  ", level) .. trimmed)
--  end
--  vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)
--  end,
--})

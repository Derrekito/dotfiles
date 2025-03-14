local setkey = vim.keymap.set

vim.g.mapleader = " "

-- Prevent <CR> from doing anything unexpected globally
vim.keymap.set("n", "<CR>", "<nop>", { desc = "Disable default <CR>" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    print("Help filetype detected!")
    vim.keymap.set("n", "<CR>", "<C-]>", { buffer = true, desc = "Jump to tag under cursor" })
  end,
})


-- Increase font size
setkey("n", "<leader>+", ":hi! Normal guifont+=1<CR>")

-- In visual mode, move the selected block of text one line up or down and
-- reselect the block.
setkey("v", "J", ":m '>+1<CR>gv=gv")
setkey("v", "K", ":m '<-2<CR>gv=gv")

setkey("i", "<C-c>", "<Esc>")

setkey("n", "<leader>pv", vim.cmd.Ex)

-- Join lines without changing the cursor position.
setkey("n", "J", "mzJ`z")

-- Scroll down half a page and center the screen on the cursor.
setkey("n", "<C-d>", "<C-d>zz")

-- Scroll up half a page and center the screen on the cursor.
setkey("n", "<C-u>", "<C-u>zz")

-- Repeat the last search, center the screen on the found item, and reselect
-- the last visual selection.
setkey("n", "n", "nzzzv")

-- Repeat the last search in the opposite direction, center the screen on the
-- found item, and reselect the last visual selection.
setkey("n", "N", "Nzzzv")

-- In Visual mode, replace the selected text with the last yanked text.
-- This binding uses the "black hole" register "_" to delete "d" the selected
-- text without affecting the clipboard or other registers, then pastes "P" the
-- previously yanked text in its place. Useful for quick text swaps.
setkey("x", "<leader>p", [["_dP]])

-- Map <leader>y to copy the current line (in Normal mode) or the selected text
-- (in Visual mode) directly to the system clipboard. This vim.keymap utilizes the
-- "+ register, which is Vim's way of accessing the system clipboard. It allows
-- for easy copying of text from Vim to other applications outside of Vim.
setkey({ "n", "v" }, "<leader>y", [["+y]])

-- In Normal mode, map <leader>Y to copy from the cursor position to the end of
-- the line directly to the system clipboard. This uses the "+ register, which
-- allows for interaction with the system clipboard, facilitating text transfer
-- from Vim to external applications.
setkey("n", "<leader>Y", [["+Y]])

-- Map <leader>d in normal and visual modes to delete without affecting the clipboard.
setkey({ "n", "v" }, "<leader>d", [["_d]])

-- Disable the default functionality of 'Q' in normal mode.
setkey("n", "Q", "<nop>")

-- Map <leader>f in normal mode to format the buffer using the configured LSP.
setkey("n", "<leader>f", vim.lsp.buf.format)

-- Map Ctrl+k in normal mode to go to the next item in the quickfix list and center it on screen.
setkey("n", "<C-k>", "<cmd>cnext<CR>zz")

-- Map Ctrl+j in normal mode to go to the previous item in the quickfix list and center it on screen.
setkey("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Map <leader>k in normal mode to go to the next item in the location list and center it on screen.
setkey("n", "<leader>k", "<cmd>lnext<CR>zz")

-- Map <leader>j in normal mode to go to the previous item in the location list and center it on screen.
setkey("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitute the word under the cursor throughout the file, case-insensitive
setkey("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- substitute the word under the cursor throughout the file, case-sensitive
setkey("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left><Left>]])
-- make the current file executable using chmod +x
setkey("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- source file
--setkey("n", "<leader><leader>", function()
--    vim.cmd("so")
--end)

local function setNetrwKeymap()
  if vim.bo.filetype == "netrw" then
    vim.keymap.set("n", "<leader><leader>", ":TypeAnim<CR>", { buffer = true })
  else
    -- source file
    vim.keymap.set("n", "<leader><leader>", function()
      vim.cmd("so")
    end)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = setNetrwKeymap
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = setNetrwKeymap
})
-- Select All
setkey("n", "<C-a>", "gg<S-v>G")

-- Split Window
setkey("n", "<leader>-", ":split<Return>", opts)
setkey("n", "<leader>|", ":vsplit<Return>", opts)

-- Move to Window
setkey("n", "sh", "<C-w>h")
setkey("n", "sk", "<C-w>k")
setkey("n", "sj", "<C-w>j")
setkey("n", "sl", "<C-w>l")


-- Move the current window to the far left of the screen.
setkey("n", "Sh", "<C-w>H")
-- Move the current window to the bottom of the screen.
setkey("n", "Sj", "<C-w>J")
-- Move the current window to the top of the screen.
setkey("n", "Sk", "<C-w>K")
-- Move the current window to the far right of the screen.
setkey("n", "Sl", "<C-w>L")

-- Resize Window
setkey("n", "<C-left>", "<C-w><")
setkey("n", "<C-right>", "<C-w>>")
setkey("n", "<C-up>", "<C-w>+")
setkey("n", "<C-down>", "<C-w>-")

-- Set highlight on search, but clear on pressing <esc> in normal mode
vim.opt.hlsearch = true
setkey("n", "<esc>", ":nohlsearch<CR>")

-- Diagnostic Keymaps
setkey("n", "<leader>dn", vim.diagnostic.goto_next, {desc="Go to next diagnostic"})
setkey("n", "<leader>dp", vim.diagnostic.goto_prev, {desc="Go to previous diagnostic"})
setkey("n", "<leader>e", vim.diagnostic.open_float, {desc="Open diagnostics [E]rror message"})
setkey("n", "<leader>q", vim.diagnostic.setloclist, {desc="Open diagnostics [Q]uickfix list"})

-- OSC 52 function to copy to local clipboard
local function osc52_yank()
  -- Get the yanked text from register 0
  local yanked_text = vim.fn.getreg('0')
  if not yanked_text or yanked_text == '' then
    print("Nothing to yank to clipboard")
    return
  end

  -- Base64 encode it
  local buffer = vim.fn.system('base64 -w0', yanked_text)
  if vim.v.shell_error ~= 0 or not buffer then
    print("Error: base64 failed or not installed")
    return
  end

  -- Trim trailing newlines from base64 output
  buffer = buffer:gsub('%s+$', '')

  -- Build OSC 52 sequence
  local osc52 = '\x1b]52;c;' .. buffer .. '\x07'

  -- Write to stdout instead of /dev/tty
  io.stdout:write(osc52)
  io.stdout:flush() -- Ensure it sends immediately
end

-- Keep your autocommand as-is
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('Osc52Clipboard', { clear = true }),
  callback = function()
    if vim.v.event.operator == 'y' then
      osc52_yank()
    end
  end,
})

-- Optional: Map + register to clipboard
vim.opt.clipboard:append('unnamedplus')

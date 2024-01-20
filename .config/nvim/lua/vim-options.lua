
-- Function to setup smarter indentation with word wrapping
local function setup_smart_indentation_wrapping()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.wo.breakindentopt = "shift:2"
end

-- Call the function to apply settings
setup_smart_indentation_wrapping()

vim.wo.cursorline = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.o.scrolloff = 999

vim.wo.wrap = false

vim.g.mapleader = " "

-- Enable clipboard integration
vim.opt.clipboard:append("unnamedplus")

-- Makefile tabs
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
      vim.opt_local.tabstop = 8
      vim.opt_local.shiftwidth = 8
      vim.opt_local.expandtab = false
  end,
})

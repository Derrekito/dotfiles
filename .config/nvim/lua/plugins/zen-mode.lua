return {
    "folke/zen-mode.nvim",
    vim.keymap.set("n", "<leader>zz", function()
        require("zen-mode").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            window = {
                backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                -- height and width can be:
                -- * an absolute number of cells when > 1
                -- * a percentage of the width / height of the editor when <= 1
                -- * a function that returns the width or the height
                width = 95, -- width of the Zen window
                height = 1, -- height of the Zen window
                -- by default, no options are changed for the Zen window
                -- uncomment any of the options below, or add other vim.wo options you want to apply
                options = {
                    -- signcolumn = "no", -- disable signcolumn
                    number = true, -- disable number column
                    relativenumber = true, -- disable relative numbers
                    -- cursorline = false, -- disable cursorline
                    -- cursorcolumn = false, -- disable cursor column
                    -- foldcolumn = "0", -- disable fold column
                    -- list = false, -- disable whitespace characters
                },
            },
            plugins = {
                -- disable some global vim options (vim.o...)
                -- comment the lines to not apply the options
                options = {
                    enabled = true,
                    ruler = false, -- disables the ruler text in the cmd line area
                    showcmd = false, -- disables the command in the last line of the screen
                    -- you may turn on/off statusline in zen mode by setting 'laststatus'
                    -- statusline will be shown only if 'laststatus' == 3
                    laststatus = 0, -- turn off the statusline in zen mode
                },
                twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
                gitsigns = { enabled = false }, -- disables git signs
                tmux = { enabled = true }, -- enables the tmux statusline handling
                -- this will change the font size on kitty when in zen mode
                -- to make this work, you need to set the following kitty options:
                -- - allow_remote_control socket-only
                -- - listen_on unix:/tmp/kitty
                kitty = {
                    enabled = false,
                    font = "+4", -- font size increment
                },
                -- this will change the font size on alacritty when in zen mode
                -- requires  Alacritty Version 0.10.0 or higher
                -- uses `alacritty msg` subcommand to change font size
                alacritty = {
                    enabled = true,
                    font = "12", -- font size
                },
                -- this will change the font size on wezterm when in zen mode
                -- See alse also the Plugins/Wezterm section in this projects README
                wezterm = {
                    enabled = false,
                    -- can be either an absolute font size or the number of incremental steps
                    font = "+4", -- (10% increase per step)
                },
            },
            -- callback where you can add custom code when the Zen window opens
            on_open = function(win)
                -- Store the current colorcolumn setting
                vim.g.zenmode_save_colorcolumn = vim.wo.colorcolumn
                -- Disable the colorcolumn
                vim.wo.colorcolumn = ""

                -- Store the current word wrap setting
                vim.g.zenmode_save_wrap = vim.wo.wrap
                -- Enable word wrap
                vim.wo.wrap = true

                -- Keybindings to increase/decrease width
                vim.api.nvim_buf_set_keymap(0, 'n', 'C-<left>', ':lua IncreaseZenWidth()<CR>', { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(0, 'n', 'C-<right>', ':lua DecreaseZenWidth()<CR>', { noremap = true, silent = true })
            end,
            -- callback where you can add custom code when the Zen window closes
            on_close = function()
                -- Restore the colorcolumn setting
                vim.wo.colorcolumn = vim.g.zenmode_save_colorcolumn
                -- Restore the wordwrap setting
                vim.wo.wrap = vim.g.zenmode_save_wrap

                -- Remove keybindings if necessary
                vim.api.nvim_buf_del_keymap(0, 'n', 'C-<left>')
                vim.api.nvim_buf_del_keymap(0, 'n', 'C-<right>')
            end,   -- refer to the configuration section below
        }
        require("zen-mode").toggle()
    end)
}

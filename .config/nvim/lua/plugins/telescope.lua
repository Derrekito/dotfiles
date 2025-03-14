-- plugins/telescope.lua:
return {
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function ()
        require("telescope").setup {
            pickers = {
                find_files = {
                    theme = "ivy"
                }
            },
            extensions = {
                fzf = {}
            }
        }

        require('telescope').load_extension('fzf')

        vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
        vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files)
        vim.keymap.set("n", "<leader>en", function()
            require('telescope.builtin').find_files {
                cwd = vim.fn.stdpath("config")
            }
        end)
        vim.keymap.set("n", "<leader>ep", function()
            require('telescope.builtin').find_files {
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            }
        end)

        --require "config.telescope.multigrep".setup()
        vim.keymap.set("n", "<leader>mg", require("config.telescope.multigrep").live_multigrep, { desc = "Multi Grep" })
    end
    }
}

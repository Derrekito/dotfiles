return {
    'Derrekito/nvim-type-anim',
    lazy = true,
    config = function()
        require("type-anim").setup({
            AnimToggleKey="<space>",
            AnimKillKey="<C-C>"
        })
    end
}

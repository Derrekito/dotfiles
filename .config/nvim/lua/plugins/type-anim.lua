return {
  'Derrekito/nvim-type-anim',
  lazy = false,
  config = function()
    require("type-anim").setup({
      AnimToggleKey = "<space>",
      AnimKillKey = "<C-C>"
    })
  end
}

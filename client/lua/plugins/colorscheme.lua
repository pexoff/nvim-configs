-- Active colorscheme: tokyodark (loaded on startup).
-- All others are only loaded when you call :colorscheme <name>.
-- To switch: set the desired scheme to lazy = false + priority = 1000
-- and move the config block from tokyodark over to it.

return {
  {
    "tiagovla/tokyodark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyodark").setup()
      vim.cmd("colorscheme tokyodark")
    end,
  },

  { "navarasu/onedark.nvim", lazy = true },
  { "Yagua/nebulous.nvim", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "ficcdaf/ashen.nvim", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "sho-87/kanagawa-paper.nvim", lazy = true },
  { "mofiqul/vscode.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "water-sucks/darkrose.nvim", lazy = true },
  { "ray-x/starry.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
}

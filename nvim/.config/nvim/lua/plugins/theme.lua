return {
  -- Add the gruvbox colorscheme
  { "ellisonleao/gruvbox.nvim" },

  -- Tell LazyVim to load it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}

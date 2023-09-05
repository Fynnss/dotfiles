return {
  -- add gruvbox
  { "navarasu/onedark.nvim", lazy = true, opts = { style = "dark" } },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}

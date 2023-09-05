return {
  {
    "nvim-telescope/telescope.nvim",
    -- install fzf native
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      -- change a keymap
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      -- add a keymap to browse plugin files
      --       <cmd>Telescope lsp_document_symbols<cr>z
      { "<leader>ff", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find Document symbols" },
    },
  },
}

return {
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvzone/volt",
    lazy = true,
  },
  {
    "nvchad/ui",
    event = "UiEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvchad/base46",
      "nvzone/volt",
    },
    config = function()
      require "nvchad"
    end,
  },
}
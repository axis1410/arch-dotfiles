return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      delay = 0,
      duration = 80,
    },
    indent = {
      enable = true,
    },
    line_num = {
      enable = false,
      use_treesitter = false,
    },
    blank = {
      enable = false,
    },
  },
}
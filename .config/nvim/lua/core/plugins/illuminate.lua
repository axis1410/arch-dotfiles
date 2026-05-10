return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 50,
    min_count = 2,
    filetypes_denylist = {
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "oil",
      "lazy",
      "mason",
      "Trouble",
      "TelescopePrompt",
      "fzf",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
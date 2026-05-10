return {
  "folke/flash.nvim",
  lazy = true,
  opts = {
    modes = {
      search = {
        enabled = false,
      },
      treesitter = {
        enabled = true,
        jump = {
          pos = "range",
        },
      },
      treesitter_search = {
        jump = {
          pos = "range",
        },
      },
    },
    label = {

      uppercase = false,
      rainbow = {
        enabled = true,
        shade = 5,
      },
    },
    jump = {
      autojump = true,
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter({
          jump = {
            autojump = false,
          },
        })
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
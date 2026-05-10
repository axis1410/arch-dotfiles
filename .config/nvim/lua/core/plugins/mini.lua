return {

  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.bracketed").setup()
    end,
  },

  {
    "echasnovski/mini.tabline",
    enabled = false,
    opts = {
      show_icons = true,
      format = function(buf_id, label)
        return " " .. require("mini.tabline").default_format(buf_id, label) .. " "
      end,
      tabpage_section = "right",
    },
  },

  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.move").setup {
        mappings = {
          left = "<S-h>",
          right = "<S-l>",
          up = "<S-k>",
          down = "<S-j>",
          line_left = "<S-h>",
          line_right = "<S-l>",
          line_down = "<S-j>",
          line_up = "<S-k>",
        },
      }
    end,
  },

  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    version = false,
    opts = {},
  },

  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    enabled = false,
    opts = {
      draw = {
        delay = 50,
      },
      -- symbol = "|",
    },
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    version = false,
    opts = {},
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.surround").setup {
        mappings = {
          add = "<leader>sa",
          delete = "<leader>sd",
          find = "<leader>sf",
          find_left = "<leader>sF",
          highlight = "<leader>sh",
          replace = "<leader>sr",
          update_n_lines = "<leader>sn",
        },
      }
    end,
    opts = {
      mappings = {
        add = "<leader>sa",
        delete = "<leader>sd",
        find = "<leader>sf",
        find_left = "<leader>sF",
        highlight = "<leader>sh",
        replace = "<leader>sr",
        update_n_lines = "<leader>sn",
      },
    },
  },

  {
    "echasnovski/mini.bufremove",
    version = false,
    keys = {
      { "<leader>bd", desc = "Delete buffer (keep window)" },
      { "<leader>bD", desc = "Force delete buffer" },
    },
    config = function()
      require("mini.bufremove").setup()
      vim.keymap.set("n", "<leader>bd", function()
        require("mini.bufremove").delete(0, false)
      end, { desc = "Delete buffer (keep window)" })

      vim.keymap.set("n", "<leader>bD", function()
        require("mini.bufremove").delete(0, true)
      end, { desc = "Force delete buffer" })
    end,
  },
}
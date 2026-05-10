return {
  "folke/noice.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    {
      "<leader>nl",
      function()
        require("noice").cmd "last"
      end,
      desc = "Noice: last message",
    },
    {
      "<leader>nh",
      function()
        require("noice").cmd "history"
      end,
      desc = "Noice: history",
    },
    {
      "<leader>nd",
      function()
        require("noice").cmd "dismiss"
      end,
      desc = "Noice: dismiss",
    },
  },
  opts = {
    cmdline = { enabled = false },
    messages = {
      enabled = false,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },
    popupmenu = {
      enabled = false,
      backend = "nui",
    },
    notify = {
      enabled = true,
      view = "notify",
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
      hover = {
        enabled = true,
        silent = false,
        opts = {},
      },
      signature = { enabled = false },
      progress = {
        enabled = true,
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        throttle = 1000 / 30,
        view = "mini",
      },
      message = {
        enabled = true,
        view = "notify",
        opts = {},
      },
      documentation = {
        view = "hover",
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = { concealcursor = "n", conceallevel = 3 },
        },
      },
    },
    markdown = {
      hover = {
        ["|(%S-)|"] = vim.cmd.help,
        ["%[.-%]%((%S-)%)"] = function(url)
          require("noice.util").open(url)
        end,
      },
      highlights = {
        ["|%S-|"] = "@text.reference",
        ["@%S+"] = "@parameter",
        ["^%s*(Parameters:)"] = "@text.title",
        ["^%s*(Return:)"] = "@text.title",
        ["^%s*(See also:)"] = "@text.title",
        ["{%S-}"] = "@parameter",
      },
    },
    health = {
      checker = true,
    },
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    throttle = 1000 / 30,
    routes = {
      {
        filter = { event = "msg_show", kind = "", find = "%d+L, %d+B" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "%d+ more lines" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "%d+ fewer lines" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "%d+ lines yanked" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "; before #%d+" },
        opts = { skip = true },
      },
      {
        filter = { event = "msg_show", find = "; after #%d+" },
        opts = { skip = true },
      },
    },
    views = {
      mini = {
        align = "message-right",
        position = {
          row = -1,
          col = "100%",
        },
        size = {
          max_height = 12,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winblend = 14,
          winhighlight = {
            Normal = "NoiceMini",
            IncSearch = "",
            CurSearch = "",
            Search = "",
          },
        },
      },
      hover = {
        border = {
          style = "rounded",
          padding = { 0, 2 },
        },
        size = { max_width = 0.88, max_height = 0.72 },
      },
      popup = {
        border = {
          style = "rounded",
          padding = { 0, 2 },
        },
      },
      confirm = {
        border = {
          style = "rounded",
          padding = { 0, 2 },
        },
        text = {
          top = "  ",
        },
      },
    },
    format = {
      level = {
        icons = {
          error = "✖",
          warn = "▼",
          info = "●",
        },
      },
    },
  },
  config = function(_, opts)
    vim.cmd "cabbrev message Noice history"
    vim.cmd "cabbrev messages Noice history"

    require("notify").setup {
      fps = 60,
      render = "compact",
      stages = "fade",
      timeout = 3200,
      top_down = false,
      background_colour = "#000000",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
      max_height = function()
        return math.floor(vim.o.lines * 0.7)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.44)
      end,
    }
    require("noice").setup(opts)

    vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true, desc = "Noice: scroll doc forward" })

    vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true, desc = "Noice: scroll doc back" })
  end,
}
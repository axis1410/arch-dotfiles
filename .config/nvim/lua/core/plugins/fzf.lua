return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    {
      "<leader>fh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "[S]earch [H]elp",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "[S]earch [K]eymaps",
    },
    {
      "<leader>fo",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Search [O]ld [F]iles",
    },
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "[S]earch [F]iles",
    },
    {
      "<leader>fs",
      function()
        require("fzf-lua").builtin()
      end,
      desc = "[S]earch [S]elect FZF",
    },
    {
      "<leader>fw",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "[S]earch current [W]ord",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep_native()
      end,
      desc = "[S]earch by [G]rep",
    },
    {
      "<leader>fd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "[S]earch [D]iagnostics",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").resume()
      end,
      desc = "[S]earch [R]esume",
    },
    {
      "<leader><leader>",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "[ ] Find existing buffers",
    },
    {
      "<leader>/",
      function()
        require("fzf-lua").blines()
      end,
      desc = "[/] Fuzzily search in current buffer",
    },
    {
      "<leader>th",
      function()
        require("nvchad.themes").open { style = "bordered" }
      end,
      desc = "Open NvUI themes",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-mini/mini.nvim" },
  config = function()
    local fzf = require "fzf-lua"

    fzf.setup {
      defaults = {
        prompt = "    ",
        file_ignore_patterns = { "node_modules", "venv", ".git" },
        winopts = {
          height = 0.84,
          width = 0.9,
          row = 0.5,
          col = 0.5,
          border = "rounded",
          preview = {
            border = [[rounded]],
            layout = [[flex]],
            flex = [[row]],
            vertical = [[right:55%]],
            horizontal = [[down:45%]],
          },
        },
      },
      keymap = {
        builtin = {
          ["<C-k>"] = "preview-page-up",
          ["<C-j>"] = "preview-page-down",
          ["<C-l>"] = "select",
        },
      },
      files = {
        file_icons = true,
        hidden = true,
        git_icons = true,
        file_ignore_patterns = { [[node_modules]], [[venv]] },
        previewer = false,
        color_icons = true,

        winopts = {
          height = 0.6,
          width = 0.6,
          row = 0.5,
          col = 0.5,
          border = "rounded",

          -- preview = {
          --   layout = "flex",
          --   flex = "column",
          --   vertical = "right:55%",
          --   horizontal = "down:45%",
          -- },
        },
      },
      buffers = {
        file_icons = true,
        color_icons = true,
        previewer = false,
        winopts = {
          height = 0.5,
          width = 0.75,
          row = 0.5,
          col = 0.5,
          border = "rounded",
        },
      },
      grep = {
        prompt = "Rg❯ ",
        file_ignore_patterns = { "node_modules", ".git", ".venv" },
        rg_opts = table.concat({
          "--column",
          "--line-number",
          "--no-heading",
          "--color=always",
          "--smart-case",
          "--max-columns=4096",
          "--glob '!**/.git/*'",
          "--glob '!**/*.{mo,pot,po,csv}'",
          "--glob '!**/*env/*'",
          "--glob '!**/*venv/*'",
          "--glob '!**/*.lock*'",
          "-e",
        }, " "),
        git_icons = true,
      },
      fzf_colors = {
        true,
      },
      fzf_opts = {
        ["--layout"] = "default",
        ["--info"] = "right",
        ["--pointer"] = "▌",
        ["--marker"] = "●",
        ["--cycle"] = "",
      },
      hls = {
        border = "FloatBorder",
        title = "Title",
        preview_title = "Title",
        cursorline = "CursorLine",
        cursorlinenr = "CursorLineNr",
        search = "IncSearch",
      },
    }
  end,
}
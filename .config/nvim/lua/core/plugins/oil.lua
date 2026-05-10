return {
  {
    "stevearc/oil.nvim",
    opts = {},
    enabled = true,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    cmd = "Oil",
    keys = {
      {
        "<leader>e",
        function()
          require("oil").open_float(nil, { preview = { vertical = true } })
        end,
        desc = "Open Oil file explorer",
      },
    },
    config = function()
      local oil = require "oil"

      oil.setup {
        preview = {
          enabled = true,
        },
        default_file_explorer = true,
        columns = {
          "icon",
        },
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        win_options = {
          wrap = false,
          signcolumn = "yes:2",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        delete_to_trash = false,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        lsp_file_methods = {
          enabled = false,
          timeout_ms = 1000,
          autosave_changes = false,
        },
        constrain_cursor = "editable",
        watch_for_changes = false,
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        use_default_keymaps = true,
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, _)
            return name:match "^%." ~= nil
          end,
          is_always_hidden = function(name, _)
            local hidden_patterns = {
              "^node_modules$",
              "^__pycache__$",
              "^%.DS_Store$",
              "%.egg%-info$",
            }

            for _, pattern in ipairs(hidden_patterns) do
              if name:match(pattern) then
                return true
              end
            end

            return false
          end,
          natural_order = "fast",
          case_insensitive = false,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
          highlight_filename = function(_, _, _, _)
            return nil
          end,
        },
        extra_scp_args = {},
        git = {
          add = function(_)
            return false
          end,
          mv = function(_, _)
            return false
          end,
          rm = function(_)
            return false
          end,
        },
        float = {
          padding = 2,
          max_width = 0.85,
          max_height = 0.8,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          get_win_title = nil,
          preview_split = "auto",
          override = function(conf)
            return conf
          end,
        },
        preview_win = {
          update_on_cursor_moved = true,
          preview_method = "fast_scratch",
          disable_preview = function(_)
            return false
          end,
          win_options = {},
        },
        confirmation = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = 0.9,
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
        ssh = {
          border = "rounded",
        },
        keymaps_help = {
          border = "rounded",
        },
      }
    end,
  },

  {
    "refractalize/oil-git-status.nvim",
    dependencies = {
      "stevearc/oil.nvim",
    },
    ft = "oil",
    config = true,
  },
}
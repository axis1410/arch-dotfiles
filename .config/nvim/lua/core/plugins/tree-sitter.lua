return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cmd = {
    "TSInstall",
    "TSInstallFromGrammar",
    "TSUpdate",
    "TSUninstall",
    "TSInstallInfo",
    "TSLog",
    "TsInstall",
    "TsInstallInfo",
    "TsUpdate",
    "TsUninstall",
  },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "json",
      "yaml",
      "python",
      "javascript",
      "typescript",
      "sql",
    },
    auto_install = true,
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    local ts = require("nvim-treesitter")

    local aliases = {
      TsInstall = "TSInstall",
      TsUpdate = "TSUpdate",
      TsUninstall = "TSUninstall",
    }

    for from, to in pairs(aliases) do
      vim.api.nvim_create_user_command(from, function(command_opts)
        vim.cmd(to .. " " .. command_opts.args)
      end, {
        nargs = "*",
        complete = function(_, line)
          return vim.fn.getcompletion(line, "command")
        end,
      })
    end

    vim.api.nvim_create_user_command("TSInstallInfo", function()
      local config = require("nvim-treesitter.config")
      local installed = config.get_installed()
      local available = config.get_available()
      local missing = vim.tbl_filter(function(parser)
        return not vim.tbl_contains(installed, parser)
      end, available)

      table.sort(installed)
      table.sort(missing)

      local lines = {
        "nvim-treesitter parser info",
        "",
        "Installed:",
      }

      vim.list_extend(lines, #installed > 0 and installed or { "(none)" })
      vim.list_extend(lines, {
        "",
        "Available but not installed:",
      })
      vim.list_extend(lines, #missing > 0 and missing or { "(none)" })

      vim.cmd.new()
      local buf = vim.api.nvim_get_current_buf()
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      vim.bo[buf].modifiable = true
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modifiable = false
      vim.bo[buf].filetype = "markdown"
      vim.api.nvim_buf_set_name(buf, "TSInstallInfo")
    end, {
      desc = "Show treesitter parser install info",
    })

    vim.api.nvim_create_user_command("TsInstallInfo", function()
      vim.cmd.TSInstallInfo()
    end, {
      desc = "Show treesitter parser install info",
    })

    local ensure_installed = vim.list_extend(vim.deepcopy(opts.ensure_installed or {}), {
      "toml",
      "html",
      "css",
      "go",
      "rust",
      "tsx",
      "jsx",
      "jinja",
      "vue",
    })

    vim.defer_fn(function()
      ts.install(ensure_installed)
    end, 5000)

    local group = vim.api.nvim_create_augroup("user_treesitter_start", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
      group = group,
      callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then
          return
        end

        local ok_stat, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok_stat and stat and stat.size > 512 * 1024 then
          return
        end

        pcall(vim.treesitter.start, args.buf)

        if opts.indent and opts.indent.enable then
          pcall(function()
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end)
        end
      end,
    })
  end,
}
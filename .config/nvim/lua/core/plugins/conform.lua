return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters = {
      html_prettier = {
        inherit = "prettier",
        condition = function(self, ctx)
          -- skip Jinja2 templates — prettier mangles {% %} tags
          local first = vim.api.nvim_buf_get_lines(ctx.buf, 0, 1, false)[1] or ""
          return not first:match("{%%")
        end,
      },
    },

    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff", "ruff_organize_imports", "ruff_format" },
      go = { "golines", "gofumpt", "goimports" },
      rust = { "rust_analyzer" },
      json = { "prettier" },
      yaml = { "prettier" },
      toml = { "taplo" },
      html = { "html_prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      sql = { "sleek" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
    },

    format_on_save = function(bufnr)
      -- disable all formatting for Jinja templates
      local first = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
      if first:match("{%%") then
        return false
      end
      return { timeout_ms = 5000, lsp_format = "fallback" }
    end,
  },
}
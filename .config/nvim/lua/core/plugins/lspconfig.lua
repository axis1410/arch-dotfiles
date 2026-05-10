return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
    "ibhagwan/fzf-lua",
  },
  config = function()
    local fzf = require "fzf-lua"
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local function toggle_inlay_hints(bufnr)
      if not (vim.lsp and vim.lsp.inlay_hint) then
        return
      end

      local enabled = false
      local ok_state, state = pcall(vim.lsp.inlay_hint.is_enabled, { bufnr = bufnr })
      if ok_state and type(state) == "boolean" then
        enabled = state
      end

      local ok = pcall(vim.lsp.inlay_hint.enable, not enabled, { bufnr = bufnr })
      if not ok then
        pcall(vim.lsp.inlay_hint.enable, bufnr, not enabled)
      end
    end

    vim.diagnostic.config {
      virtual_text = {
        prefix = "●",
        source = "if_many",
      },
      severity_sort = true,
      underline = true,
      update_in_insert = false,
      float = {
        border = "rounded",
        source = true,
      },
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("core-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
        end

        map("n", "gd", fzf.lsp_definitions, "LSP definitions")
        map("n", "gr", fzf.lsp_references, "LSP references")
        map("n", "gI", fzf.lsp_implementations, "LSP implementations")
        map("n", "gy", fzf.lsp_typedefs, "LSP type definitions")
        map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
        map("n", "gh", vim.lsp.buf.hover, "LSP hover")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP code actions")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
        map("n", "<leader>ds", fzf.lsp_document_symbols, "LSP document symbols")
        map("n", "<leader>ws", function()
          local query = vim.fn.input "Workspace symbols: "
          if query == nil or query == "" then
            fzf.lsp_live_workspace_symbols()
            return
          end
          fzf.lsp_workspace_symbols { lsp_query = query }
        end, "LSP workspace symbols")
        map("n", "<leader>wS", fzf.lsp_live_workspace_symbols, "LSP live workspace symbols")
        map("n", "<leader>uh", function()
          toggle_inlay_hints(event.buf)
        end, "Toggle inlay hints")
        map("n", "<leader>lr", vim.lsp.codelens.enable, "LSP codelens refresh")
        map("n", "<leader>lR", vim.lsp.codelens.run, "LSP codelens run")
      end,
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
          library = {
            vim.fn.stdpath "data" .. "/lazy/base46",
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    vim.lsp.config("marksman", {
      filetypes = { "markdown" },
    })

    vim.lsp.config("hydra_lsp", { filetypes = { "yaml" } })
    vim.lsp.config("bashls", { filetypes = { "sh", "zsh" } })
    vim.lsp.config("html", { filetypes = { "html", "htmldjango", "jinja" } })
    vim.lsp.config("just-lsp", { filetypes = { "just" } })
    vim.lsp.config("cssls", { filetypes = { "css" } })
    vim.lsp.config("mbake", { filetypes = { "makefile" } })
    vim.lsp.config(
      "taplo",
      {
        schema = {
          associations = {
            [".*sesh\\.toml$"] = "https://github.com/joshmedeski/sesh/raw/main/sesh.schema.json",
          },
        },
      }
    )

    local mason_packages = vim.fn.stdpath "data" .. "/mason/packages"
    local vue_ts_plugin = mason_packages .. "/vue-language-server/node_modules/@vue/typescript-plugin"
    local tsdk = mason_packages .. "/typescript-language-server/node_modules/typescript/lib"

    vim.lsp.config("ts_ls", {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_ts_plugin,
            languages = { "vue" },
          },
        },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    })

    vim.lsp.config("vue_ls", {
      init_options = {
        typescript = {
          tsdk = tsdk,
        },
      },
    })

    vim.lsp.config("sqls", {
      on_attach = function(client, bufnr)
        -- disable sqls formatter (it breaks Postgres $1 → $ 1)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })

    require("mason-lspconfig").setup {
      automatic_enable = true,
    }
  end,
}
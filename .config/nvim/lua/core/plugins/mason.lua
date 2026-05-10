local ensure_installed = {
  -- "hydra_lsp",
  "stylua",
  "css-lsp",
  "html-lsp",
  "ruff",
  "pyright",
  "prettier",
  "eslint_d",
  "typescript-language-server",
  "lua-language-server",
  "taplo",
  "vue-language-server",
  "sqlls",
}

local function do_install_all()
  local registry = require "mason-registry"
  local pending = {}

  for _, name in ipairs(ensure_installed) do
    local ok, pkg = pcall(registry.get_package, name)
    if not ok then
      vim.notify("[Mason] unknown package: " .. name, vim.log.levels.ERROR)
      goto continue
    end

    if pkg:is_installed() then
      goto continue
    end

    table.insert(pending, name)
    pkg:install():once(
      "closed",
      vim.schedule_wrap(function()
        if pkg:is_installed() then
          vim.notify("[Mason] installed: " .. name, vim.log.levels.INFO)
        else
          vim.notify("[Mason] failed: " .. name, vim.log.levels.ERROR)
        end
      end)
    )

    ::continue::
  end

  if #pending == 0 then
    vim.notify("[Mason] everything already installed", vim.log.levels.INFO)
  else
    vim.notify("[Mason] installing " .. #pending .. " package(s)...", vim.log.levels.INFO)
  end
end

return {
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonLog",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonUpdate",
    },
    config = function()
      require("mason").setup {}
      local registry = require "mason-registry"
      registry.refresh(function(success)
        if not success then
          vim.notify("Mason registry update failed. Run :MasonUpdate then restart.", vim.log.levels.WARN)
        end
      end)

      vim.api.nvim_create_user_command("MasonInstallAll", do_install_all, { desc = "Install all Mason packages" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = ensure_installed,
      start_delay = 3000,
      debounce_hours = 1,
      run_on_start = true,
    },
  },
}
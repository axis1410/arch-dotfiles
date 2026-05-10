local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = { import = "core.plugins" },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "rrhelper",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zipPlugin",
      },
    },
  },
}

local cache_dir = vim.g.base46_cache
local fs = vim.uv or vim.loop

if type(cache_dir) == "string" and not fs.fs_stat(cache_dir .. "tbline") then
  pcall(function()
    require("base46").compile()
  end)
end

if type(cache_dir) == "string" and fs.fs_stat(cache_dir) then
  for _, file in ipairs(vim.fn.readdir(cache_dir)) do
    local path = cache_dir .. file
    if fs.fs_stat(path) then
      dofile(path)
    end
  end
end
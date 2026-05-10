return {
  "kdheepak/lazygit.nvim",
  enabled = true,
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    {
      "<leader>gg",
      "<cmd>LazyGit<CR>",
      desc = "Open LazyGit",
    },
  },

  init = function()
    if vim.v.servername == "" then
      vim.fn.serverstart()
    end

    vim.env.NVIM = vim.v.servername
    vim.env.NVIM_LISTEN_ADDRESS = vim.v.servername
    vim.g.lazygit_floating_window_winblend = 1
    vim.g.lazygit_use_custom_config_file_path = 1
    vim.g.lazygit_config_file_path = vim.fn.expand("~/.config/lazygit/config.yml")
  end,
}
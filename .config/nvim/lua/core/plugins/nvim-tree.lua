return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = false,
  config = function()
    require("nvim-tree").setup {
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
    }

    vim.keymap.set("n", "<leader>e", '<CMD>:lua require("nvim-tree.api").tree.toggle()<CR>', { desc = "Open NvimTree" })
  end,
}
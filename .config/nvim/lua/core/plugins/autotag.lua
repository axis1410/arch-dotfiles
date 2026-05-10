return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "xml", "tsx", "jsx" },
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
    per_filetype = {
      html = {
        enable_close = false,
      },
    },
  },
}
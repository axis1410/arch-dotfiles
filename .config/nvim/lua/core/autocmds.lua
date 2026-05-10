vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "jb",
  callback = function()
    require("core.jb_palette").apply()
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "jb" then
      require("core.jb_palette").apply()
    end
  end,
})
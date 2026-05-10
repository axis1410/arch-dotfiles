return {
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",
  build = "bash ./build.sh",
  keys = {
    {
      "<leader>S",
      function()
        require("spectre").toggle()
      end,
      desc = "Toggle Spectre",
    },
  },
}
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "TodoFzfLua", "TodoLocList", "TodoQuickFix", "TodoTrouble" },
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>td", "<cmd>TodoFzfLua keywords=TODO,FIX<CR>", desc = "Find TODO/FIX comments" },
  },
  opts = {},
}
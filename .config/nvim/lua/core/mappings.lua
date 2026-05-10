local map = vim.keymap.set
local unmap = vim.keymap.del
local opts = { silent = true, noremap = true }

-- Buffer movement
map("n", "<Tab>", function()
  local ok, tabufline = pcall(require, "nvchad.tabufline")
  if ok then
    tabufline.next()
    return
  end
  vim.cmd.bnext()
end, vim.tbl_extend("force", opts, { desc = "Next buffer" }))

map("n", "<S-Tab>", function()
  local ok, tabufline = pcall(require, "nvchad.tabufline")
  if ok then
    tabufline.prev()
    return
  end
  vim.cmd.bprev()
end, vim.tbl_extend("force", opts, { desc = "Previous buffer" }))

-- Clear highlight
map("n", "<Esc>", "<Esc><Cmd>nohlsearch<CR>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("c", "<CR>", function()
  local cmdtype = vim.fn.getcmdtype()
  if cmdtype == "/" or cmdtype == "?" then
    return "<CR><Cmd>nohlsearch<CR>"
  end
  return "<CR>"
end, { expr = true, noremap = true, silent = true })

map("n", "Q", "<nop>")

-- Delete without yank
map({ "n", "v" }, "d", '"_d', opts)
map({ "n", "v" }, "D", '"_D', opts)

-- Change without yank
map({ "n", "v" }, "c", '"_c', opts)
map({ "n", "v" }, "C", '"_C', opts)

map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

map("i", "jj", "<ESC>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>v", "<cmd>vsplit<CR>")

map("n", "<leader>th", function()
  require("nvchad.themes").open { style = "bordered" }
end, { desc = "Open NvUI themes" })

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Open cheatsheet" })

-- Close all buffers
map("n", "<leader>ba", function()
  local bufremove = require "mini.bufremove"
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      bufremove.delete(buf, false)
    end
  end
end, { desc = "Close all buffers" })

map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
-- local ok_outline, _ = pcall(require, "outline")
-- if ok_outline then
-- end

map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end)
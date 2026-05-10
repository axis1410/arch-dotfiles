local o = vim.o
local wo = vim.wo
local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = " "

o.relativenumber = true
o.nu = true
o.cursorlineopt = "both"
o.cursorline = true
o.hlsearch = false
o.smartcase = true
o.ignorecase = true
o.termguicolors = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:block"
opt.isfname:append "@-@"
opt.updatetime = 200
opt.redrawtime = 1500
opt.synmaxcol = 240
opt.colorcolumn = "120"
opt.cmdheight = 1
opt.clipboard:append "unnamedplus"
opt.mouse = ""
opt.splitbelow = true
opt.splitright = true
opt.winborder = "rounded"
opt.scrolloff = 8
opt.wrap = false
opt.pumheight = 10
opt.timeoutlen = 300

vim.filetype.add {
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
  extension = {
    j2 = "jinja",
    jinja = "jinja",
    jinja2 = "jinja",
  },
  pattern = {
    [".*/templates/.*%.html"] = "htmldjango",
    [".*/print_format/.*%.html"] = "htmldjango",
  },
}

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "ColorScheme" }, {
  callback = function()
    vim.o.cmdheight = 1
    vim.api.nvim_set_hl(0, "MsgArea", { link = "Normal" })
    vim.api.nvim_set_hl(0, "ModeMsg", { link = "Normal" })
  end,
})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require "core.options"
require "core.mappings"
require "core.autocmds"
require "core.globals"
require "core.lazy"
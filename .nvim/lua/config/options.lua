-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.laststatus = 0
vim.opt.conceallevel = 0

-- Always use cwd as root, prevent LazyVim from changing working directory
vim.g.root_spec = { "cwd" }

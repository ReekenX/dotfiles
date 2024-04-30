-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Automatically update LazyVim plugins on startup
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    require("lazy").update({
      wait = false,
      show = false,
    })
  end,
})

-- LspRestart eslint on saving package.json
local ts_grp = vim.api.nvim_create_augroup("TSAutocmds", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "package.json" },
  command = "LspRestart eslint",
  group = ts_grp,
})
-- EsLintAutoFix on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  command = "silent! EslintFixAll",
  group = ts_grp,
})

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cf", function()
  local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
  local abs_path = vim.fn.expand("%:p")
  local path = git_root ~= "" and abs_path:sub(#git_root + 2) or abs_path
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy File Path" })

vim.keymap.set("n", "<leader><space>", function() Snacks.picker.git_files() end, { desc = "Find Files (git-files)" })
vim.keymap.set("n", "<leader>fg", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })

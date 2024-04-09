-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Custom save keymap – ww in normal mode
vim.keymap.set({ "n" }, "ww", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.del("n", "<C-s>")

-- Copy filename to clipboard
vim.keymap.set({ "n" }, "<leader>cf", '<cmd>:let @*=expand("%")<CR>', { desc = "Filename to Clipboard" })

-- Quick shortcut to restart LSP server
vim.keymap.set({ "n" }, "<leader>R", "<cmd>:LspRestart<CR>", { desc = "Restart LSP Server" })

-- Execute previously executed tmux command in other pane
-- (useful when you have tests in other pane and want manually control when you want to
-- execute them - instead of "yarn test:watch" or similar)
vim.keymap.set(
  { "n" },
  "<leader>r",
  "<cmd>exe \"!tmux send -t 1 'UP'\" | exe \"!tmux send -t 1 'ENTER'\"<CR>",
  { desc = "Repeat command in next tmux pane" }
)

-- Remap <leader>E to show VIM native file explorer
vim.keymap.del("n", "<leader>E")
vim.keymap.set({ "n" }, "<leader>E", "<cmd>:Explore<CR>", { desc = "Native File Explorer" })

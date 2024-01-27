-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Custom save keymap – ww in normal mode
vim.keymap.set({ "n" }, "ww", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.del("n", "<C-s>")

-- Copy filename to clipboard
vim.keymap.set({ "n" }, "<leader>cf", '<cmd>:let @*=expand("%")<CR>', { desc = "Filename to Clipboard" })

-- Quick shortcut to restart LSP server
vim.keymap.set({ "n" }, "<leader>R", "<cmd>:LspRestart<CR>", { desc = "Restart LSP Server" })

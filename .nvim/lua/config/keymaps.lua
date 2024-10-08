-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Custom save keymap – ww in normal mode
vim.keymap.set({ "n" }, "ww", "<cmd>w<cr><esc>", { desc = "Save File" })

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
vim.keymap.set({ "n" }, "<leader>E", "<cmd>:Explore<CR>", { desc = "Native File Explorer" })

-- Find references to selected symbol/call
vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set({ "n", "v" }, "<leader>gi", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Incoming Calls" })

-- Different keymap to show signature
vim.keymap.set({ "n" }, "<leader>gk", vim.lsp.buf.signature_help, { desc = "Signature" })

-- Drop ALT+j and ALT+k moving lines as they cause ESC+j and ESC+k to do the same
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

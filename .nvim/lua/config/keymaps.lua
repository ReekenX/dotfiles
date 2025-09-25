-- Copy filename to clipboard
vim.keymap.set({ "n" }, "<leader>cf", '<cmd>:let @*=expand("%:.")<CR>', { desc = "Filename to Clipboard" })

-- Quick shortcut to restart LSP server
-- vim.keymap.set({ "n" }, "<leader>R", "<cmd>:LspRestart<CR>", { desc = "Restart LSP Server" })

-- Execute previously executed tmux command in other pane
-- (useful when you have tests in other pane and want manually control when you want to
-- execute them - instead of "yarn test:watch" or similar)
vim.keymap.set(
  { "n" },
  "<leader>r",
  "<cmd>exe \"!tmux send -t 1 'UP'\" | exe \"!tmux send -t 1 'ENTER'\"<CR>",
  { desc = "Repeat command in next tmux pane" }
)

-- Find references to selected symbol/call
vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set({ "n", "v" }, "<leader>gi", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Incoming Calls" })

-- Different keymap to show signature
vim.keymap.set({ "n" }, "<leader>gk", vim.lsp.buf.signature_help, { desc = "Signature" })

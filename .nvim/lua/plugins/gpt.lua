return {
  {
    "thmsmlr/gpt.nvim",
    config = function()
      require("gpt").setup({
        api_key = os.getenv("OPENAI_API_KEY"),
      })
      opts = { silent = true, noremap = true }
      vim.keymap.set("v", "<leader>gr", require("gpt").replace, {
        silent = true,
        noremap = true,
        desc = "GPT Rewrite",
      })
      vim.keymap.set("v", "<leader>gp", require("gpt").visual_prompt, {
        silent = false,
        noremap = true,
        desc = "GPT Prompt",
      })
      vim.keymap.set("n", "<leader>gp", require("gpt").prompt, {
        silent = true,
        noremap = true,
        desc = "GPT Prompt",
      })
      vim.keymap.set("n", "<leader>gx", require("gpt").cancel, {
        silent = true,
        noremap = true,
        desc = "GPT Cancel",
      })
    end,
  },
}

return {
  {
    "CoderCookE/vim-chatgpt",
    config = function()
      vim.g.chat_gpt_model = "gpt-4"
      vim.g.chat_gpt_lang = "English"
      vim.g.chat_gpt_max_tokens = 2000
    end,
  },
}

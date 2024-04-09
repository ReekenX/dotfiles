return {
  {
    "CoderCookE/vim-chatgpt",
    init = function()
      vim.g.chat_gpt_model = "gpt-4"
      vim.g.chat_gpt_lang = "English"
      vim.g.chat_gpt_max_tokens = 2000
      vim.g.chat_gpt_custom_prompts = {
        ["ask"] = "I will ask you programming question. When answering be short and straightforward. If you will be returning code sample as an example - do not explain that code.",
      }
    end,
  },
}

return {
  {
    "CoderCookE/vim-chatgpt",
    init = function()
      vim.g.chat_gpt_model = "gpt-4"
      vim.g.chat_gpt_lang = "English"
      vim.g.chat_gpt_max_tokens = 2000
      vim.g.chat_gpt_custom_prompts = {
        ["ask"] = "When answering be short and straightforward. If you will be returning code sample as an example - do not explain that code.",
      }

      -- Force markdown to see code highlights properly and hide weird characters
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = "gpt-persistent-session",
        command = "set filetype=html isprint=1-255",
      })
    end,
  },
}

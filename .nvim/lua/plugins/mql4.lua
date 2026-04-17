return {
  {
    "vobornik/vim-mql4",
    ft = "mql4",
    init = function()
      vim.filetype.add({
        extension = {
          mq4 = "mql4",
          mq5 = "mql4",
          mqh = "mql4",
        },
      })
    end,
  },
}

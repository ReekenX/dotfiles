return {
  {
    "folke/flash.nvim",
    keys = {
      {
        "<leader><leader>",
        function()
          require("flash").jump({
            search = {
              mode = function(str)
                return "\\<" .. str
              end,
            },
          })
        end,
        desc = "Flash Jump",
      },
    },
  },
}

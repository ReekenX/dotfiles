return {
  {
    "folke/flash.nvim",
    keys = {
      {
        "<leader>ss",
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

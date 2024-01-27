local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      -- default keybinding changes working directory – I don't like that
      { "<leader>ff", Util.telescope("files", { cwd = false }), desc = "Find Files (root dir)" },
    },
  },
}

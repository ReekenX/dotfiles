return {
  {
    "ddrscott/vim-side-search",
    init = function()
      vim.cmd("cabbrev S SideSearch")

      -- Default command uses --word-regexp which misses a lot results!, so
      -- overriding to fix that and adding smart case handling
      vim.g.side_search_prg = "rg --heading --stats -C 2 --smart-case --line-number"
    end,
  },
}

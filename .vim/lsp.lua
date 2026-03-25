require('Comment').setup()

-- Language parser
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "bash", "css", "dockerfile", "html", "javascript", "json", "lua", "markdown", "python", "toml", "yaml", "make", "rst", "scss", "tsx", "vim", "vue", "regex", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Indentation
  indent = {
    enable = true
  },

  highlight = {
    enable = true,
  },
}

require('notify').setup({
  top_down = false,
  background_colour = "#21252b"
})

require("noice").setup({ })

-- Requirement for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false
      }
    }
  },
  filters = {
    git_ignored = true,
    dotfiles = true,
    custom = { "__pycache__" },
    exclude = { ".claude" },
  },
  trash = {
    cmd = "rm",
  }
})

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '┃' },
    topdelete    = { text = '┃' },
    changedelete = { text = '┃' },
    untracked    = { text = '┃' },
  },
  signs_staged_enable = false
}

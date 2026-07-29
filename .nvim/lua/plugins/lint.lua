-- Markdown linting comes from two places in this config:
--   1. lazyvim.plugins.extras.lang.markdown -> nvim-lint  linters_by_ft.markdown
--   2. lazyvim.plugins.extras.lang.markdown -> none-ls    diagnostics.markdownlint_cli2
-- Both must be turned off, otherwise markdownlint diagnostics keep showing up.
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {},
        ["markdown.mdx"] = {},
      },
      linters = {
        -- Safety net: never run even if something re-adds it to a filetype.
        ["markdownlint-cli2"] = {
          condition = function()
            return false
          end,
        },
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sources = vim.tbl_filter(function(source)
        return source.name ~= "markdownlint-cli2"
      end, opts.sources or {})
    end,
  },
}

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "gleam" } },
  },

  {
    "nvim-lspconfig",
    opts = {
      servers = {
        gleam = {},
      },
    },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        gleam = { "gleam" },
      },
    },
  },
}

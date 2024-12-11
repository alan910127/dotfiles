return {
  { import = "plugins.extras.lang.typescript" },

  {
    "nvim-treesitter",
    opts = { ensure_installed = { "svelte" } },
  },

  {
    "mason.nvim",
    opts = { ensure_installed = { "svelte" } },
  },

  {
    "nvim-lspconfig",
    opts = {
      servers = {
        svelte = {},
      },
    },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        svelte = { "prettier" },
      },
    },
  },
}

return {
  {
    "mason.nvim",
    opts = { ensure_installed = { "tailwindcss" } },
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
    "roobert/tailwindcss-colorizer-cmp.nvim",
    dependencies = {
      "nvim-cmp",
      opts = function(_, opts)
        local format = opts.formatting.format
        opts.formatting.format = function(entry, item)
          format(entry, item)
          return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end
      end,
    },
  },
}

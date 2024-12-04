return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "python" } },
  },

  {
    "mason.nvim",
    opts = { ensure_installed = { "basedpyright", "ruff" } },
  },

  {
    "nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {},
        ruff = {},
      },
    },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    lazy = false,
    branch = "regexp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
    keys = {
      { "<leader>sv", vim.cmd.VenvSelect, desc = "Search Venv" },
    },
  },
}

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "javascript", "typescript", "tsx" } },
  },

  {
    "nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
        },
        eslint = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
        },
      },
    },
  },

  {
    "mason.nvim",
    opts = { ensure_installed = { "ts_ls", "prettier", "eslint" } },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        ["javascript.jsx"] = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        ["typescript.tsx"] = { "prettier" },
      },
    },
  },
}

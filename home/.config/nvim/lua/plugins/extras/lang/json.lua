return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "json5" } },
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
      },
    },
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },

  {
    "nvim-lspconfig",
    opts = {
      servers = {
        ---@module "lspconfig"
        ---@type lspconfig.Config
        jsonls = {
          on_new_config = function(new_config)
            if new_config.capabilities == nil then
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              new_config.capabilities = capabilities
            end
            new_config.capabilities.textDocument.completion.completionItem.snippetSupport = true

            new_config.settings.json.schemas = vim.tbl_deep_extend("force", new_config.settings.json.schemas or {}, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "yaml" } },
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
        yamlls = {
          on_new_config = function(new_config)
            if new_config.capabilities == nil then
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              new_config.capabilities = capabilities
            end
            new_config.capabilities.textDocument.completion.completionItem.snippetSupport = true

            new_config.settings.yaml.schemas = vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = { enable = true },
              validate = { enable = true },
              schemaStore = {
                -- Disable the builtin schemaStore support to use "b0o/schemastore.nvim"
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading "length")
                url = "",
              },
            },
          },
        },
      },
    },
  },
}

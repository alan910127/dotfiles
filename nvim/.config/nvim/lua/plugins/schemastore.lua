return {
  "b0o/schemastore.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local schemastore = require("schemastore")

    lspconfig.jsonls.setup({
      settings = {
        json = {
          schemas = schemastore.json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lspconfig.yamlls.setup({
      settings = {
        schemaStore = {
          -- Disable the builtin schemaStore support to use "b0o/schemastore.nvim"
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading "length")
          url = "",
        },
        schemas = schemastore.json.schemas(),
      },
    })
  end,
}

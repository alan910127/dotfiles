---@class LanguageServerConfig
---@field root_dir? fun(filename: string, bufnr: integer): string|nil
---@field name? string
---@field filetypes? string[]
---@field autostart? boolean
---@field single_file_support? boolean
---@field on_new_config? fun(config: LanguageServerConfig, new_root_dir: string): nil
---@field capabilities? table<string, string|table|boolean|function>
---@field cmd? string[]
---@field handlers? table<string, lsp-handler>
---@field init_options? table<string, string|table|boolean>
---@field on_attach? fun(client: table, bufnr: integer): nil
---@field settings? table<string, string|table|boolean>

---@type table<string, LanguageServerConfig>
local language_servers = {
  rust_analyzer = {},
  basedpyright = {},
  ruff_lsp = {},
  clangd = {
    cmd = { "clangd", "--offset-encoding=utf-16" },
  },

  -- Configuration file formats
  jsonls = {},
  yamlls = {},
  taplo = {}, -- TOML

  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
}

local ensure_installed = vim.list_extend(vim.tbl_keys(language_servers), {
  "stylua",
  "shfmt",
})

-- Highlight references of the word under the cursor when the cursor stays at
-- the same location for a certain amount of time.
--
-- When the cursor is moved, the highlights will be cleared.
--
---@param client table|nil
---@param buffer integer
local function highlight_cursor_on_idle(client, buffer)
  if not client or not client.server_capabilities.documentHighlightProvider then
    return
  end

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = buffer,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = buffer,
    callback = vim.lsp.buf.clear_references,
  })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("alan-lsp-attach", { clear = true }),
      callback = function(event)
        ---@param keys string
        ---@param func function
        ---@param desc string
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local builtin = require("telescope.builtin")
        map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
        map("gr", builtin.lsp_references, "[G]oto [R]eferences")
        map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        highlight_cursor_on_idle(client, event.buf)
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    require("mason").setup()
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = language_servers[server_name] or {}

          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}

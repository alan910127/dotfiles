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

---@param client vim.lsp.Client|nil
---@param buffer integer
---@param kind string
local function code_action_on_save(client, buffer, kind)
  if not client or not client.server_capabilities.codeActionProvider then
    return
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
      vim.lsp.buf.code_action({
        context = { only = { kind }, diagnostics = {} },
        apply = true,
      })
      vim.wait(100)
    end,
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
        code_action_on_save(client, event.buf, "source.fixAll")
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = require("alan.config.lsp")

    require("mason").setup()
    require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers) })
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}

          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}

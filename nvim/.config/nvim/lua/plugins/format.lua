local function get_js_formatter()
  local biome_installed = vim.fn.isdirectory(vim.fn.getcwd() .. "/node_modules/@biomejs/biome")
  if biome_installed then
    return { "biome" }
  end
  return { { "prettier", "prettierd" } }
end

return {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- Auto formatting
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_fix" },
        javascript = get_js_formatter,
        javascriptreact = get_js_formatter,
        typescript = get_js_formatter,
        typescriptreact = get_js_formatter,
        astro = { "prettier" },
        markdown = { "prettier" },
        sh = { "shfmt" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "4" },
        },
      },
    },
  },
}

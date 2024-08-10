---@param bufnr integer
---@param ... string
---@return string[]
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(bufnr, formatter).available then
      return formatter
    end
  end
  return select(1, ...)
end

return {
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- Auto formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      local conform = require("conform")

      conform.setup({
        notify_on_error = false,
        format_after_save = {
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_format", "ruff_fix" },
          javascript = function(bufnr)
            return { first(bufnr, "biome", "prettier") }
          end,
          javascriptreact = function(bufnr)
            return { first(bufnr, "biome", "prettier") }
          end,
          typescript = function(bufnr)
            return { first(bufnr, "biome", "prettier") }
          end,
          typescriptreact = function(bufnr)
            return { first(bufnr, "biome", "prettier") }
          end,
          astro = function(bufnr)
            return { first(bufnr, "prettier") }
          end,
          markdown = function(bufnr)
            return { first(bufnr, "prettier") }
          end,
          json = function(bufnr)
            return { first(bufnr, "prettier", "jsonls") }
          end,
          jsonc = function(bufnr)
            return { first(bufnr, "prettier", "jsonls") }
          end,
          sh = { "shfmt" },
        },
        formatters = {
          shfmt = {
            prepend_args = { "-i", "4" },
          },
        },
      })

      vim.keymap.set("n", "<leader>f", function()
        conform.format({ async = true })
      end, { desc = "[F]ormat Buffer" })
    end,
  },
}

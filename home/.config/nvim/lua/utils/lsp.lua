local M = {}

M.action = setmetatable({}, {
  ---@param action string
  ---@return fun():nil
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

return M

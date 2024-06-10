local IGNORED_MESSAGES = {
  "No code actions available",
}

local LEVEL_OPTS = {
  [vim.log.levels.TRACE] = { timeout = 500 },
  [vim.log.levels.DEBUG] = { timeout = 500 },
  [vim.log.levels.INFO] = { timeout = 1000 },
  [vim.log.levels.WARN] = { timeout = 10000 },
  [vim.log.levels.ERROR] = {
    timeout = 10000,
    keep = function()
      return true
    end,
  },
}

return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    notify.setup({})

    ---@param msg string
    ---@param level integer
    ---@param opts table
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(msg, level, opts)
      level = level or vim.log.levels.INFO

      if vim.list_contains(IGNORED_MESSAGES, msg) then
        return
      end

      opts = vim.tbl_extend("force", LEVEL_OPTS[level] or {}, opts or {})
      return notify.notify(msg, level, opts)
    end
  end,
}

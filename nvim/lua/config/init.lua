local M = {}

M.did_init = false
function M.init()
  if M.did_init then
    return
  end
  M.did_init = true

  -- load options here, before lazy init while sourcing plugin modules
  -- this is needed to make sure options will be correctly applied
  -- after installing missing plugins
  require("config.options")

  -- autocmds can be loaded lazily when not opening a file
  local no_args = vim.fn.argc(-1) == 0
  local arg_is_dir = vim.fn.isdirectory(vim.fn.argv(0, -1)) ~= 0
  local lazy_autocmds = no_args or arg_is_dir
  if not lazy_autocmds then
    require("config.autocmds")
  end

  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("autocmds_keymaps_lazy_load", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      if lazy_autocmds then
        require("config.autocmds")
      end
      require("config.keymaps")
    end,
  })
end

return M

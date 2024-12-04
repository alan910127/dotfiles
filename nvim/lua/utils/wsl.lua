local M = {}

---@param fn fun():nil
function M.wsl_only(fn)
  if vim.env.WSL_INTEROP ~= nil or vim.env.WSL_DISTRO_NAME ~= nil then
    fn()
  end
end

return M


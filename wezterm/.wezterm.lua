local wezterm = require 'wezterm'
local mux = wezterm.mux

-- Maximize window on startup
wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window {}
  window:gui_window():maximize()
end)

return {
  -- Font
  font = wezterm.font 'JetBrains Mono',
  -- Tab Bar
  hide_tab_bar_if_only_one_tab = true,
  -- Launch WSL by default
  default_prog = { 'wsl', '--cd', '~' },
  -- Disable Close Window Confirmation Menu
  window_close_confirmation = 'NeverPrompt',

  keys = {
    {
      mods = 'CTRL|SHIFT',
      key = 'n',
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      mods = 'CTRL|SHIFT',
      key = 'p',
      action = wezterm.action.DisableDefaultAssignment,
    },
  },
}

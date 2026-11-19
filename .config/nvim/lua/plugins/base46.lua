-- DMS (DankMaterialShell) theme: only where DMS is installed (Linux desktop).
-- colors/dms.lua needs the `dms` binary and ~/.config/dms/settings.json;
-- elsewhere LazyVim's default colorscheme stays.
local config_home = vim.env.XDG_CONFIG_HOME
if config_home == nil or #config_home == 0 then
  config_home = vim.fs.joinpath(vim.env.HOME, ".config")
end
local has_dms = vim.fn.executable("dms") == 1
  and vim.uv.fs_stat(vim.fs.joinpath(config_home, "dms", "settings.json")) ~= nil
if not has_dms then
  return {}
end

return {
  {
    "AvengeMedia/base46",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dms",
    },
  },
}

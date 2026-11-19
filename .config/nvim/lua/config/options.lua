-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = "unnamedplus"

-- herdr's server may be auto-started by a remote (SSH) client and lack the
-- desktop env; borrow the Wayland/X display from the user's systemd session.
if vim.env.HERDR_ENV and not vim.env.WAYLAND_DISPLAY and vim.fn.executable("systemctl") == 1 then
  local out = vim.fn.systemlist({ "systemctl", "--user", "show-environment" })
  for _, line in ipairs(out) do
    local k, v = line:match("^(WAYLAND_DISPLAY)=(.*)$")
    if not k then k, v = line:match("^(DISPLAY)=(.*)$") end
    if k then vim.env[k] = v end
  end
end

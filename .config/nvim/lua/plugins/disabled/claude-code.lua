return {
  "coder/claudecode.nvim",
  opts = {
    terminal = {
      provider = "external",
      provider_opts = {
        external_terminal_cmd = '~/.config/herdr/scripts/claude-split.sh "%s --ide --allow-dangerously-skip-permissions" "0.8"',
      },
    },
  },
}

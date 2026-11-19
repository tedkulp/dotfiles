return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>/", LazyVim.pick("grep", { hidden = true }), desc = "Grep (Root Dir)" },
    { "<leader>sg", LazyVim.pick("live_grep", { hidden = true }), desc = "Grep (Root Dir)" },
    { "<leader>sG", LazyVim.pick("live_grep", { root = false, hidden = true }), desc = "Grep (cwd)" },
  },
}

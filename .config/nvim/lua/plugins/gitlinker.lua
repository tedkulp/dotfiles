return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  cond = jit.os == "OSX" or jit.arch == "arm64",
  opts = {},
  keys = {
    { "<leader>goo", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    { "<leader>gob", "<cmd>GitLink! blame<cr>", mode = { "n", "v" }, desc = "Open git blame" },
  },
}

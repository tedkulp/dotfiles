return {
  "josephschmitt/pj.nvim",
  -- project.nvim (projects.lua) covers macOS/arm64; pj everywhere else
  cond = not (jit.os == "OSX" or jit.arch == "arm64"),
  -- Make sure to add your chosen picker as a dependency
  dependencies = { "folke/snacks.nvim" },
  keys = { { "<leader>fp", "<cmd>Pj<cr>", desc = "Find Projects" } },
  opts = {},
}

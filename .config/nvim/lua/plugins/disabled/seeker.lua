return {
  "2kabhishek/seeker.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "Seeker" },
  keys = {
    { "<leader><Space>", ":Seeker files<CR>", desc = "Seek Files" },
    { "<leader>fa", ":Seeker files<CR>", desc = "Seek Files" },
    { "<leader>ff", ":Seeker git_files<CR>", desc = "Seek Git Files" },
    { "<leader>fg", ":Seeker grep<CR>", desc = "Seek Grep" },
    { "<leader>/", ":Seeker grep<CR>", desc = "Seek Grep" },
  },
  -- opts = {}, -- Required unless you call seeker.setup() manually, add your configs here
  opts = {
    servers = {
      ["*"] = {
        keys = {
          -- Disable a keymap
          { "fa", false },
          { "ff", false },
          { "fg", false },
          { "<Space>", false },
          { "/", false },
        },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- Disable a keymap
            { "gr", false },
          },
        },
      },
    },
  },
  {
    "nvim-mini/mini.operators",
    keys = {
      {
        "gr",
        desc = "Replace operator",
      },
    },
    opts = {},
  },
}

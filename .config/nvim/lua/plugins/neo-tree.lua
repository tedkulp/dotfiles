return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  vscode = false,
  opts = {
    filesystem = {
      filtered_items = {
        visible = false,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          ".DS_Store",
          ".vscode",
          "thumbs.db",
          ".stfolder",
        },
        always_show = {
          ".internal",
        },
        never_show = {},
      },
    },
    window = {
      mappings = {
        ["L"] = "expand_all_nodes",
      },
    },
  },
}

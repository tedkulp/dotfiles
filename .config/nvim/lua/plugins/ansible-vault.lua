-- return {
--   "outerLeitmotiv/nvim-ansible-vault",
--   ft = "yaml.ansible",
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--   },
-- }

return {
  "apayu/nvim-ansible-vault",
  config = function()
    require("ansible-vault").setup({
      vault_password_files = { "~/.vault_pass.txt", ".vault_pass.txt", ".vault-pass" },
      vault_id = "default",
    })
  end,
  event = "BufReadPre */vault.yml",
}

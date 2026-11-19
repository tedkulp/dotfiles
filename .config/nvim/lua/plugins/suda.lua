return {
  "lambdalisue/vim-suda",
  vscode = false,
  init = function()
    vim.cmd([[
      let g:suda_smart_edit = 1
    ]])
  end,
}

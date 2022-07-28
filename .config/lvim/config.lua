--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
-- lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
vim.opt.clipboard = "unnamed,unnamedplus"
-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.which_key.mappings['W'] = { ":w<cr>", "Save Buffer" }
lvim.format_on_save = {
  timeout = 5000,
}
lvim.builtin.lualine.options.theme = "tokyonight"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
vim.keymap.set("n", "<f1>", "<nop>")

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

lvim.builtin.which_key.mappings['w'] = {
  name = "+Window",
  s = { "<cmd>split<cr>", "Split Horizontal" },
  v = { "<cmd>vsplit<cr>", "Split Vertical" },
  c = { "<cmd>close<cr>", "Close Window" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

lvim.plugins = {
  {
    "folke/tokyonight.nvim",
  },
  {
    "chiedo/vim-case-convert"
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        delimiters = {
          invalid_key_behavior = function(char)
            return { char, char }
          end
        },
      })
    end
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aC"] = "@conditional.outer",
              ["iC"] = "@conditional.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["ga"] = "@parameter.inner",
            },
            swap_previous = {
              ["gA"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,

  },
  {
    "tpope/vim-repeat"
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        filetype_exclude = { "help", "terminal", "dashboard", "lspinfo" },
        buftype_exclude = { "terminal", "dashboard", "nofile", "quickfix" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    branch = "v2",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "f",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
        , { silent = true })
      vim.api.nvim_set_keymap("n", "F",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
        , { silent = true })
      vim.api.nvim_set_keymap("n", "t",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
        , { silent = true })
      vim.api.nvim_set_keymap("n", "T",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
        , { silent = true })
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
      lvim.builtin.which_key.mappings["S"] = { "<cmd>lua require('spectre').open()<CR>", "Spectre Search" }
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup({})
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup({
        default_mappings = true;
      })
    end
  },
  {
    "editorconfig/editorconfig-vim"
  },
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      local augend = require("dial.augend")
      vim.cmd [[
        nmap <C-w> <Plug>(dial-increment)
        nmap <C-x> <Plug>(dial-decrement)
        vmap <C-w> <Plug>(dial-increment)
        vmap <C-x> <Plug>(dial-decrement)
        vmap g<C-w> <Plug>(dial-increment-additional)
        vmap g<C-x> <Plug>(dial-decrement-additional)
      ]]

      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d"],
          augend.date.alias["%H:%M"],
          augend.constant.alias.bool,
          augend.constant.new { elements = { "True", "False" } }, -- Python
          augend.hexcolor.new {
            case = "lower",
          },
        },
      }
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    "chaoren/vim-wordmotion",
    config = function()
      vim.cmd("let g:wordmotion_prefix = ','")
    end,
  },
  {
    'taybart/b64.nvim',
  },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
  },
  {
    "stevearc/dressing.nvim",
  },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker")

      vim.keymap.set("n", "<Leader><Leader>i", "<cmd>PickEverything<cr>", { noremap = true, silent = true })
      vim.keymap.set("i", "<A-i>", "<cmd>PickEverythingInsert<cr>", { noremap = true, silent = true }) -- opt-i on Mac
    end,
  },
}


-- set additional formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json" },
  },
  {
    command = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
  {
    command = "rustfmt",
    filetypes = { "rust" },
  },
  {
    command = "gofmt",
    filetypes = { "go" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.setup {
    pickers = {
      buffers = {
        mappings = {
          n = {
            ["D"] = "delete_buffer"
          },
          i = {
            ["<c-d>"] = "delete_buffer"
          }
        }
      }
    },
    extensions = {
      project = {
        base_dirs = {
          -- {path = '~/src', max_depth = 1},
          -- {path = '~/src/tmp', max_depth = 1},
          -- {path = '~/src/omuras/code', max_depth = 1},
          { path = '~/src' },
          { path = '~/src/tmp' },
          { path = '~/src/omuras/code' },
          { path = '~/org' },
        },
        hidden_files = true,
      }
    }
  }

  pcall(telescope.load_extension, "file-browser")
  pcall(telescope.load_extension, "project")
end

function Toggle_lsp_lines()
  local flag = not vim.diagnostic.config().virtual_lines
  print("LSP lines has been " .. (flag and "enabled" or "disabled"))
  vim.diagnostic.config { virtual_lines = flag, virtual_text = not flag }
end

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
})

lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
  "Projects" }
lvim.builtin.which_key.mappings["`"] = { ":edit #<CR>", "Last Buffer" }
lvim.builtin.which_key.mappings["lT"] = { "<cmd>lua Toggle_lsp_lines()<cr>", "Toggle LSP Lines" }

lvim.builtin.which_key.mappings["u"] = {
  name = "+Text Utils",
  e = { "<cmd>PickEverything<cr>", "Insert Emoji/Char" },
  c = {
    name = "+Convert Case",
    c = { "<cmd>CamelToHyphen!<cr>", "Camel => Kebab/Hyphen" },
    C = { "<cmd>CamelToSnake!<cr>", "Camel => Snake" },
    h = { "<cmd>HyphenToCamel!<cr>", "Kebab/Hyphen => Camel" },
    H = { "<cmd>HyphenToSnake!<cr>", "Kebab/Hyphen => Snake" },
    s = { "<cmd>SnakeToCamel!<cr>", "Snake => Camel" },
    S = { "<cmd>SnakeToHyphen!<cr>", "Snake => Kebab/Hyphen" },
  }
}

lvim.builtin.which_key.vmappings["u"] = {
  name = "+Text Utils",
  b = {
    name = "+Base 64",
    e = { ":<c-u>lua require('b64').encode()<cr>", "Encode Base64" },
    d = { ":<c-u>lua require('b64').decode()<cr>", "Decode Base64" },
  }
}

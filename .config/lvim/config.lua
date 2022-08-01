local utils = require "lvim.utils"

lvim.log.level = "warn"
lvim.colorscheme = "dracula"
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.which_key.mappings['W'] = { ":w<cr>", "Save Buffer" }
lvim.format_on_save = {
  timeout = 5000,
}
lvim.builtin.lualine.options.theme = "dracula-nvim"
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.numbers = "buffer_id"
lvim.builtin.bufferline.options.separator_style = "slant"

vim.keymap.set("n", "<f1>", "<nop>")
vim.keymap.set("i", "jj", "<nop>")
vim.keymap.set("i", "jk", "<nop>")
vim.keymap.set("i", "kj", "<nop>")
vim.opt.cursorline = true
vim.opt.relativenumber = true

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

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

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
  "norg",
}

lvim.builtin.treesitter.highlight.enabled = true

lvim.plugins = {
  {
    "folke/tokyonight.nvim",
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "lunarvim/horizon.nvim",
  },
  {
    "Mofiqul/dracula.nvim",
    config = function()
      vim.g.dracula_show_end_of_buffer = true
      vim.g.dracula_italic_comment = true
    end,
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
    "vladdoster/remember.nvim",
    config = function()
      require("remember").setup {
        open_folds = true,
      }
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
      lvim.builtin.which_key.mappings["sS"] = { "<cmd>lua require('spectre').open()<CR>", "Spectre Search" }
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
      vim.diagnostic.config { virtual_lines = false, virtual_text = true }
    end,
  },
  {
    "chaoren/vim-wordmotion",
    config = function()
      vim.cmd("let g:wordmotion_prefix = ','")
    end,
  },
  {
    'christianrondeau/vim-base64',
    config = function()
      vim.cmd("let g:vim_base64_disable_default_key_mappings = 1")
    end
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

      vim.keymap.set("i", "<A-i>", "<cmd>PickEverythingInsert<cr>", { noremap = true, silent = true }) -- opt-i on Mac
    end,
  },
  {
    "nvim-neorg/neorg",
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
        }
      }

      vim.list_extend(lvim.builtin.cmp.sources, {
        { name = "neorg" },
      })
    end,
    requires = "nvim-lua/plenary.nvim",
  },
}

-- luasnip jumps
vim.keymap.set("i", "<c-;>", "<cmd>lua require('luasnip').jump(1)<cr>", { noremap = true, silent = true })
vim.keymap.set("i", "<c-l>", "<cmd>lua require('luasnip').jump(-1)<cr>", { noremap = true, silent = true })

function Dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

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

local dirs_to_include = { "~/src", "~/src/tmp", "~/src/omuras/code", "~/org" }
local base_dirs = {}

for _, the_dir in ipairs(dirs_to_include) do
  the_dir = string.gsub(the_dir, "~", os.getenv("HOME") or '')
  if utils.is_directory(the_dir) then
    table.insert(base_dirs, { path = the_dir })
  end
end

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
        base_dirs = base_dirs,
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
    e = { ":<c-u>call base64#v_btoa()<cr>", "Base64 Encode", noremap = true, silent = true },
    d = { ":<c-u>call base64#v_atob()<cr>", "Base64 Decode", noremap = true, silent = true },
  }
}

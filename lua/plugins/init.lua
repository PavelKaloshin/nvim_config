return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier",
        "pyright"
  		},
  	},
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }, lazy=false
  },

  {
  	"nvim-tree/nvim-tree.lua", lazy=false
  },

  { -- folding
    'kevinhwang91/nvim-ufo', dependencies = { 'kevinhwang91/promise-async' }
  },

  { --display function params while typing
  "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },

  {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      order = {'treeOffset', 'buffers', 'tabs'},
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    lazy=false,
  },

  { --pretty code actions menu
    "luckasRanarison/clear-action.nvim",
    opts = {
    },
    lazy=false
  },


  { -- tag tree
    'simrat39/symbols-outline.nvim',
    lazy=false,
    opts ={
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        focus_location = "o",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
      },
    },
  },

  { -- highlight all instances of word under cursor
    "RRethy/vim-illuminate",
    lazy=false,
  },

  { --bookmarks
    'tomasky/bookmarks.nvim',
    dependencies = { "telescope.nvim" },
    lazy=false,
  },

  { -- undo tree
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    lazy=false,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },

  { -- doc generation
    "kkoomen/vim-doge",
    lazy=false,
  },

  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'etovxqpdygfblzhckisuran'
    },
    lazy=false,
  },

  {
    "github/copilot.vim",
    lazy=false,
  },

  { -- java lsp
    'mfussenegger/nvim-jdtls',
    lazy=false,
  },

  -- {
  --   'nvim-java/nvim-java',
  -- },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "python", "markdown"
  		},
  	},
    lazy=false,
  },
}

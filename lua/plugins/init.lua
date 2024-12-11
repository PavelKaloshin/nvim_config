return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },


  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier",
        "pyright", "gopls", "typescript-language-server", "json-lsp",
        "eslint-lsp",
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

  { -- linting for js 
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("lint").linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        javascriptreact = { "eslint" },
      }
    end,
  },

  { -- cursorai-like composer
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openai",
      auto_suggestions_provider = "openai",
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
    },
  },

  { --openai
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup(
        {
      openai_params = {
        model = "gpt-4o",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      },
      openai_edit_params = {
        model = "gpt-4o",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0,
        top_p = 0.1,
        n = 1,
      },
      {
      diff = false,
      keymaps = {
        close = "<C-c>",
        close_n = "<Esc>",
        accept = "<C-y>",
        yank = "<C-u>",
        toggle_diff = "<C-d>",
        toggle_settings = "<C-o>",
        toggle_help = "<C-h>",
        cycle_windows = "<Tab>",
        use_output_as_input = "<C-i>",
      },
    },
    })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    },
  },

  {
    'nvim-java/nvim-java',
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "python", "markdown",
        "go", "json", "yaml", "toml", "javascript",
  		},
  	},
    lazy=false,
  },
  { -- go formatting
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    lazy=false,
    opts = function ()
      return require("configs.null-ls")
    end,
  },
  { -- go debugging
    "mfussenegger/nvim-dap",
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "nvim-dap" },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function()
      require("gopher").setup()
    end,
    build = function()
      vim.cmd("GoInstallDeps")
    end,
  }

}

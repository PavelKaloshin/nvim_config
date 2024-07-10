require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!


local tree = require("nvim-tree")
tree.setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    adaptive_size = false,
  },
  renderer = {
    full_name = true,
    group_empty = true,
    special_files = {},
    symlink_destination = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "signcolumn",
      show = {
        file = true,
        folder = false,
        folder_arrow = false,
        git = true,
      },
    },
  },
  filters = {
    custom = {
      "^.git$",
    },
  },
  actions = {
    change_dir = {
      enable = false,
      restrict_above_cwd = true,
    },
    remove_file = {
      close_window = false,
    },
  },
}
)

-- lsp
local on_attach = function(client, bufnr)
  if client.name == 'ruff_lsp' then
    client.server_capabilities.hoverProvider = false
  end
  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
end

require('lspconfig').ruff_lsp.setup {
  on_attach = on_attach,
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}

--folding
local ufo = require('ufo')
ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})
vim.keymap.set('n', 'zR', ufo.openAllFolds) -- if not remap, the folds will be auto closing on editing
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
require 'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true


-- autocompletion
local cmp = require('cmp')
local cmp_mappings = cmp.mapping.preset.insert({
  ["<C-y>"] = cmp.mapping.complete(),
  ["<CR>"] = cmp.mapping.confirm({ select = false }),
});

cmp_mappings['<Tab>'] = vim.NIL
cmp_mappings['<S-Tab>'] = vim.NIL
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer',  keyword_length = 5 },
  },
  mapping = cmp_mappings,
})

require("illuminate").configure {}

-- current tocken highlighting
-- change the highlight style
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  callback = function(ev)
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
  end
})

-- bookmarks
require('telescope').load_extension('bookmarks')
require('bookmarks').setup {
  -- sign_priority = 8,  --set bookmark sign priority to cover other sign
  save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
  keywords = {
    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
    ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
    ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
  },
  on_attach = function(bufnr)
    local bm = require "bookmarks"
    local map = vim.keymap.set
    map("n", "mm", bm.bookmark_toggle)    -- add or remove bookmark at current line
    map("n", "mi", bm.bookmark_ann)       -- add or edit mark annotation at current line
    map("n", "mc", bm.bookmark_clean)     -- clean all marks in local buffer
    map("n", "mn", bm.bookmark_next)      -- jump to next mark in local buffer
    map("n", "mp", bm.bookmark_prev)      -- jump to previous mark in local buffer
    map("n", "ml", bm.bookmark_list)      -- show marked file list in quickfix window
    map("n", "mx", bm.bookmark_clear_all) -- removes all bookmarks
  end
}

-- color column
vim.cmd [[
augroup FileTypeSettings
    autocmd!
    autocmd BufEnter * lua if vim.bo.filetype == 'python' then PythonSettings() end
augroup END
]]

function PythonSettings()
  vim.bo.tabstop = 4
  vim.bo.shiftwidth = 4
  vim.api.nvim_set_option_value("colorcolumn", "80", {})
end

-- java
require('jdtls').start_or_attach(
  {
    cmd = { '/opt/homebrew/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  }
)

--copy to clipboard
vim.opt.clipboard = ""

--empty setups
require("harpoon").setup()
require('lspconfig').pyright.setup {}
require("symbols-outline").setup()

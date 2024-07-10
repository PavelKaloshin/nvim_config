require "nvchad.mappings"

local map = vim.keymap.set
local telescope = require('telescope.builtin')
local harpoon = require("harpoon")
local wk = require("which-key")
local clear_action = require("clear-action.actions")
local bm = require "bookmarks"
local undo = require("undotree")
local gitsigns = require("gitsigns")
local hop = require('hop')


local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

local list = harpoon:list()
local function remove_harpoon_item(item)
  item = item or list.config.create_list_item(list.config)
  local Extensions = require("harpoon.extensions")
  local Logger = require("harpoon.logger")

  local items = list.items
  if item ~= nil then
    for i = 1, list._length do
      local v = items[i]
      if list.config.equals(v, item) then
        -- this clears list somehow
        -- items[i] = nil
        table.remove(items, i)
        list._length = list._length - 1

        Logger:log("HarpoonList:remove", { item = item, index = i })

        Extensions.extensions:emit(
          Extensions.event_names.REMOVE,
          { list = list, item = item, idx = i }
        )
        break
      end
    end
  end
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--cleanup
vim.keymap.del("n", "<leader>b")  -- new buffer
vim.keymap.del("n", "<leader>h")  -- new horizontal terminal
vim.keymap.del("i", "<tab>")      -- accept proposal
vim.keymap.del("n", "<leader>ma") -- telescope find marks


--global
map("n", "<leader><Tab>", ":b#<cr>", { desc = "Last active buffer" })
map('n', 'L', "$")
map('n', 'H', "^")
map({'n', 'v'}, '<leader>y', '"*y', { desc = "Yank to system clipboard" })
map({'n', 'v'}, '<leader>p', '"*p', { desc = "Paste from system clipboard" })

--copilot
-- map('i', '<tab>', 'copilot#Accept("\\<CR>")', {
map('i', '<tab>', 'copilot#Accept()', {
  expr = true,
  replace_keycodes = false
})
map('i', '<C-l>', "<Plug>(copilot-accept-word)")
map('i', '<C-j>', "<Plug>(copilot-next)")
map('i', '<C-k>', "<Plug>(copilot-previous)")
map('i', '<C-h>', "<Plug>(copilot-suggest)")

--hop
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})


--groups
wk.register({
    q = { 'q', 'record macros' },
    m = {
      name = 'bookmarks',
      m = { bm.bookmark_toggle, "toggle" },
      i = { bm.bookmark_ann, "edit (@warn, @todo, @fix, @n)" },
      c = { bm.bookmark_clean, "clean all marks in local buffer" },
      n = { bm.bookmark_next, "jump to next mark in local buffer" },
      p = { bm.bookmark_prev, "jump to previous mark in local buffer" },
      l = { bm.bookmark_list, "show marked file list in quickfix window" },
      x = { bm.bookmark_clear_all, "removes all bookmarks" },
      t = { ":Telescope bookmarks list<cr>", "telescope" },
    },
    u = { undo.toggle, "undo tree" },
    g = {
      name = "git",
      s = { gitsigns.stage_hunk, "stage hunk" },
      r = { gitsigns.reset_hunk, "reset hunk" },
      -- s = {'v', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "stage hunk"},
      -- r = {'v', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, "reset hunk"},
      S = { gitsigns.stage_buffer, "stage buffer" },
      u = { gitsigns.undo_stage_hunk, "undo stage hunk" },
      R = { gitsigns.reset_buffer, "reset buffer" },
      P = { gitsigns.preview_hunk, "preview hunk" },
      b = { function() gitsigns.blame_line { full = true } end, "blame line" },
      B = { gitsigns.toggle_current_line_blame, "toggle blame line" },
      d = { gitsigns.diffthis, "diff buffer" },
      D = { function() gitsigns.diffthis('~') end, "diff buffer" },
      p = { gitsigns.preview_hunk, "prev" },
      n = { gitsigns.next_hunk, "next" },
    },
    w = {
      name = "windows",
      h = { ":wincmd h<cr>", "Pick left" },
      l = { ":wincmd l<cr>", "Pick right" },
      j = { ":wincmd j<cr>", "Pick lower" },
      k = { ":wincmd k<cr>", "Pick upper" },

      s = {
        name = "split",
        v = { ":vs<cr>", "vertical" },
        h = { ":sp<cr>", "horizontal" },
      },

      r = {
        name = "resize",
        j = { ":res -10<cr>", "vertical -" },
        k = { ":res +10<cr>", "vertical +" },
        h = { ":vertical res -10<cr>", "horizontal -" },
        l = { ":vertical res +10<cr>", "horizontal +" },
      }
    },
    h = {
      name = "harpoon",
      ["1"] = { function() harpoon:list():select(1) end, "mark 1" },
      ["2"] = { function() harpoon:list():select(2) end, "mark 2" },
      ["3"] = { function() harpoon:list():select(3) end, "mark 3" },
      ["4"] = { function() harpoon:list():select(4) end, "mark 4" },
      ["5"] = { function() harpoon:list():select(5) end, "mark 5" },
      ["6"] = { function() harpoon:list():select(6) end, "mark 6" },
      ["7"] = { function() harpoon:list():select(7) end, "mark 7" },
      ["8"] = { function() harpoon:list():select(8) end, "mark 8" },
      ["9"] = { function() harpoon:list():select(9) end, "mark 9" },
      h = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "basic menu" },
      t = { function() toggle_telescope(harpoon:list()) end, "telescope" },
      a = { function() harpoon:list():add() end, "add" },
      d = { remove_harpoon_item, "del" },
    },

    f = {
      name = "files & telescope",
      s = { ":w<cr>", "save" },
      w = { ":wq<cr>", "save and quit" },
      q = { ":q!<cr>", "force quit" },
      g = { telescope.live_grep, "live grep" },
      t = { ":NvimTreeToggle<cr>", "file tree" },
    },

    l = {
      name = "lsp",
      f = {
        name = "format",
        f = { vim.lsp.buf.format, "whole buffer" },
      },
      d = {
        "docs & hints",
        d = { vim.lsp.buf.hover, "hover doc" },
        u = { vim.lsp.buf.incoming_calls, "used by" },
        c = { vim.lsp.buf.outgoing_calls, "calls" },
        r = { vim.lsp.buf.references, "refs" },
      },
      e = {
        name = "errors",
        n = { vim.diagnostic.goto_next, "next" },
        p = { vim.diagnostic.goto_prev, "prev" },
        d = { vim.diagnostic.open_float, "describe" },
      },
      a = { clear_action.code_action, "code action" },
      r = { vim.lsp.buf.rename, "rename" },
      t = { ":SymbolsOutline<cr>", "tag tree" },
      g = { name = "generate", d = { ":DogeGenerate Sphynx<cr>", "docstring" } },
    },

    b = {
      name = "buffers",
      f = { telescope.buffers, "find telescope" },
      p = { ":BufferPrevious<cr>", "previous" },
      n = { ":BufferNext<cr>", "next" },
      q = { ":BufferClose<cr>", "close" },
      r = { ":BufferRestore<cr>", "restore" },
      b = { ":BufferPick<cr>", "pick buffer" }
    },

    ["1"] = { ":BufferGoto 1<cr>", "buffer 1" },
    ["2"] = { ":BufferGoto 2<cr>", "buffer 2" },
    ["3"] = { ":BufferGoto 3<cr>", "buffer 3" },
    ["4"] = { ":BufferGoto 4<cr>", "buffer 4" },
    ["5"] = { ":BufferGoto 5<cr>", "buffer 5" },
    ["6"] = { ":BufferGoto 6<cr>", "buffer 6" },
    ["7"] = { ":BufferGoto 7<cr>", "buffer 7" },
    ["8"] = { ":BufferGoto 8<cr>", "buffer 8" },
    ["9"] = { ":BufferGoto 9<cr>", "buffer 9" },
  },
  { prefix = "<leader>" }
)

--rm macro record from q
map('n', 'q', '<Nop>')
map('n', 'q', ':q<cr>')

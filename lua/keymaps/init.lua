------------------------------------------------------------
-- Key Mappings | Mapeo de teclas
------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Redefine the ESC for codeium--
map('i', "<Esc>", "<Esc>", { noremap = true, silent = true })
-- Clear search
map('n', '<Esc>', '<cmd>nohlsearch<cr>', opts)

-- Navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Buffers
map('n', '<S-l>', '<cmd>bnext<cr>', opts)
map('n', '<S-h>', '<cmd>bprevious<cr>', opts)
map('n', '<leader>c', '<cmd>Bdelete<cr>', opts)
map('n', '<leader>m', '<cmd>cclose<cr>', opts)
-- File operations
map('n', '<leader>w', '<cmd>w<cr>', opts)
map('n', '<leader>q', '<cmd>q<cr>', opts)

-- File Explorer
map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', opts)
map('n', '<leader>o', '<cmd>NvimTreeFocus<cr>', opts)

-- Markdown
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", opts)
map("n", "<leader>mg", "<cmd>Glow<cr>", opts)
map("n", "<leader>tm", "<cmd>TableModeToggle<cr>", opts)
map("n", "<leader>tc", "<cmd>GenTocGFM<cr>", opts)
map("n", "<leader>tC", "<cmd>RemoveToc<cr>", opts)

-- Utility
map('n', '<leader>pi', '<cmd>Mason<cr>', opts)
map('n', '<leader>gs', '<cmd>Gitsigns toggle_signs<cr>', opts)

-- Emojis
map('n', '<leader>em', '<cmd>Telescope emoji<CR>', { desc = 'Emoji Picker' })
map('i', '<C-e>', '<Esc><cmd>Telescope emoji<CR>', { desc = 'Emoji Picker in Insert' })


-- NvimTree  Node API to new tabs
--
--Definition to the new tab/buffer
vim.opt.splitright = true
function new_buffer_right()
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()
  if node and node.type == 'file' then
    vim.cmd('vsplit ' .. vim.fn.fnameescape(node.absolute_path))
    -- vim.cmd('tab split')
  end
end

map('n', '<C-s>', new_buffer_right)

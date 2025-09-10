------------------------------------------------------------
-- Key Mappings
------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

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
map('n', '<leader>c', '<cmd>bd<cr>', opts)
map('n', '<leader>m', '<cmd>cclose<cr>', opts)

-- File operations
map('n', '<leader>w', '<cmd>w<cr>', opts)
map('n', '<leader>q', '<cmd>q<cr>', opts)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

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

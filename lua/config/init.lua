------------------------------------------------------------
-- Basic Configuration
------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Performance settings
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

-- UI settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

-- Clipboard
if is_windows then
  vim.opt.clipboard = 'unnamed'
else
  vim.opt.clipboard = 'unnamedplus'
end

-- Editor behavior
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Folding (optimizado para velocidad)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10

-- Optimización de folding
vim.opt.foldminlines = 1
vim.opt.foldcolumn = "0"

-- File type detection
vim.filetype.add({
  extension = {
    md = "markdown",
    MD = "markdown",
    js = "javascript",
    jsx = "javascriptreact",
    ts = "typescript",
    tsx = "typescriptreact"
  }
})

-- Shell optimization
if is_windows then
  vim.opt.shell = 'cmd.exe'
  vim.opt.shellcmdflag = '/s /c'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

-- Autocmds
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function() vim.diagnostic.enable(false) end,
})

vim.g.table_mode_map_prefix = '<leader>T'

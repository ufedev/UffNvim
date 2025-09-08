-- NVIM CROSS-PLATFORM STARTER FOR: Python (FastAPI/SQLAlchemy/SQLModel),
-- JS/TS (React/Node/Astro), Ansible, YAML, JSON, TOML, SQL, Docker
-- Single-file init.lua. Drop in:
--   * macOS/Linux: ~/.config/nvim/init.lua
--   * Windows:     %LOCALAPPDATA%\nvim\init.lua
--   Author: Malfasi Federico

------------------------------------------------------------
-- Basics & leader / Configuración básica y tecla leader
------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'
vim.filetype.add({ extension = { md = "markdown", MD = "markdown" } })
------------------------------------------------------------
-- lazy.nvim bootstrap (plugin manager) // manejador de paquetes
------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- Plugins
------------------------------------------------------------
require('lazy').setup({
  -- UI
  { 'nvim-lualine/lualine.nvim',  config = true },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
        renderer = {
          icons = {
            show = {
              file = true, folder = true, folder_arrow = true, git = true
            }
          },
          highlight_git = true,
          highlight_opened_files = 'name',

        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },


      })
    end
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    config = function()
      require('bufferline').setup({})
    end
  },

  -- Theme (choose one; default to catppuccin) / Tema (elegi uno; por defecto onedark_dark)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
  },

  -- Navigation & search
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim',    tag = '0.1.6' },

  -- Treesitter (syntax highlighting / parsing)
  { 'nvim-treesitter/nvim-treesitter',  build = ':TSUpdate' },

  -- LSP / Completion / Snippets
  { 'williamboman/mason.nvim',          config = true },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'j-hui/fidget.nvim',                tag = 'legacy',     config = true },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },

  -- Formatting & linting
  { 'stevearc/conform.nvim' },
  { 'mfussenegger/nvim-lint' },

  -- Terminal
  { 'akinsho/toggleterm.nvim',          version = '*',      config = true },

  -- Git & quality of life
  { 'lewis6991/gitsigns.nvim',          config = true },
  { 'numToStr/Comment.nvim',            config = true },
  { 'tpope/vim-surround' },
  { 'windwp/nvim-autopairs',            config = true },

  -- YAML / Ansible extras
  { 'pearofducks/ansible-vim' },
  -- Autocomplete cmd / autocompletado cmd
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-cmdline' },
  -- Tailwindcss -- Colorizador(colorizer)
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          tailwind = true,
          css = true,
          mode = "backgroud",
        },
      })
    end
  },
  -- Markdown LSP
  { "artempyanykh/marksman",        build = "" }, -- binario lo instala Mason

  -- Preview en browser (rápido de usar)
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end
  },

  -- Preview en terminal (opcional, si preferís dentro de nvim)
  { "ellisonleao/glow.nvim",        cmd = "Glow",                                     config = true },

  -- Mejor lectura de headings, quotes, etc.
  { "lukas-reineke/headlines.nvim", dependencies = "nvim-treesitter/nvim-treesitter", config = true },

  -- Tablas Markdown
  { "dhruvasagar/vim-table-mode",   ft = { "markdown" } },

  -- Table of Contents
  { "mzlogin/vim-markdown-toc",     ft = { "markdown" } },
  -- Nginx: syntax/ftdetect
  { "chr4/nginx.vim",               ft = "nginx" },
})


------------------------------------------------------------
--- Autocompletado cmd / cmd autocomplete
------------------------------------------------------------
local cmp = require('cmp')

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
------------------------------------------------------------
-- Colorscheme / Tema (colores)
------------------------------------------------------------
---Solo si usas onedark
require("onedarkpro").setup({
  options = {
    transparency = true, -- true si usás terminal/transparency
  },
  styles = {
    comments  = "italic",
    keywords  = "bold",
    functions = "NONE",
    strings   = "NONE",
    variables = "NONE",
  },
})
-- luego:
vim.cmd.colorscheme("onedark") -- onedark(default), onedark_dark,onedark_vivid,onelight,catppuccin


------------------------------------------------------------
--- icons / Iconos
------------------------------------------------------------

require("nvim-web-devicons").setup({})

------------------------------------------------------------
--- Tailwindcss
------------------------------------------------------------
require("nvim-ts-autotag").setup({})
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    -- lo que ya tengas + estos si faltan
    "html", "css", "javascript", "typescript", "tsx", "json",
    "svelte", "vue", "astro", "nginx"
  },
  highlight = { enable = true },
  indent = { enable = true },
})
require("mason-lspconfig").setup({
  ensure_installed = {
    -- lo que ya tenías…
    "lua_ls", "html", "cssls", "jsonls", "ts_ls", "eslint",
    -- añadir:
    "tailwindcss",
  },
  automatic_installation = true,
})
local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.tailwindcss.setup({
  capabilities = capabilities,
  filetypes = {
    "html", "css", "scss", "javascript", "typescript", "javascriptreact",
    "typescriptreact", "vue", "svelte", "astro"
  },
  root_dir = require("lspconfig.util").root_pattern(
    "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts",
    "postcss.config.js", "package.json", ".git"
  ),
})



------------------------------------------------------------
-- Treesitter setup / treesitter instalación
------------------------------------------------------------
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'lua', 'vim', 'vimdoc',
    'python',
    'javascript', 'typescript', 'tsx',
    'astro', 'html', 'css',
    'json', 'yaml', 'toml',
    'sql', 'dockerfile', 'bash', 'markdown', 'markdown_inline'
  },
  highlight = { enable = true },
  indent = { enable = true },
})


------------------------------------------------------------
-- Markdown
----------------------------------------------------------
------------------------------------------------------------
-- Telescope keymaps / Telescope mapeo  de teclas
------------------------------------------------------------
local map = vim.keymap.set
map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Find files' })
map('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Grep' })
map('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Buffers' })
map('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Help' })
map('n', 'gr', vim.lsp.buf.references, { desc = "LSP references (No abre ventana de busqueda)" })
map('n', '<leader>c', ':bd<CR>')
map('n', '<leader>m', ':cclose<CR>')

------------------------------------------------------------
-- NvimTree & Bufferline keys / Mapeo telcas NvimTree (el explorador/the explorer)
------------------------------------------------------------
map('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Explorer' })
map('n', '<leader>o', ':NvimTreeFocus<CR>', { desc = 'Focus Explorer' })
map('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', ':bprevious<CR>', { desc = 'Prev buffer' })

------------------------------------------------------------
--- Markdown Preview
------------------------------------------------------------
-- Preview en browser
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview (toggle)" })

-- Preview en terminal con glow (opcional)
map("n", "<leader>mg", "<cmd>Glow<CR>", { desc = "Markdown Glow" })

-- Tablas
map("n", "<leader>tm", "<cmd>TableModeToggle<CR>", { desc = "Table Mode (toggle)" })
-- Dentro de TableMode: `||` para nueva celda, `:TableModeRealign` re-alinea

-- TOC (Table of Contents)
map("n", "<leader>tc", "<cmd>GenTocGFM<CR>", { desc = "Generate TOC (GFM)" })
map("n", "<leader>tC", "<cmd>RemoveToc<CR>", { desc = "Remove TOC" })

------------------------------------------------------------
-- ToggleTerm | Abrir/Cerrar terminal
------------------------------------------------------------
require('toggleterm').setup({
  open_mapping = [[<leader>tt]], -- press <Space> t t
  direction = 'float',
  shade_terminals = true,
})

------------------------------------------------------------
-- nvim-cmp (completion) | autocompletado
------------------------------------------------------------
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  }),
  sources = {
    { name = 'nvim_lsp' }, { name = 'path' }, { name = 'buffer' }, { name = 'luasnip' },
  }
})

------------------------------------------------------------
-- LSP
------------------------------------------------------------
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  local o = { buffer = bufnr }
  map('n', 'gd', vim.lsp.buf.definition, o)
  map('n', 'gr', vim.lsp.buf.references, o)
  map('n', 'K', vim.lsp.buf.hover, o)
  map('n', '<leader>rn', vim.lsp.buf.rename, o)
  map('n', '<leader>ca', vim.lsp.buf.code_action, o)
  map('n', '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, o)
  map('n', '[d', vim.diagnostic.goto_prev, o)
  map('n', ']d', vim.diagnostic.goto_next, o)
end

-- Mason installs
require('mason-lspconfig').setup({
  ensure_installed = {
    -- Python
    'pyright', -- or 'basedpyright' if you prefer
    -- Web/Node/React/Astro
    'ts_ls', 'eslint', 'html', 'cssls', 'jsonls', 'astro', 'dockerls',
    -- Data & infra
    'yamlls', 'ansiblels', 'taplo', 'bashls',
    -- Misc
    'lua_ls',
    -- markdown
    'marksman'
  }
})

-- LSP servers setup
local servers = {
  pyright = {},
  ts_ls = {},
  eslint = {},
  html = {},
  cssls = {},
  jsonls = {},
  astro = {},
  dockerls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
        schemas = {
          ['https://json.schemastore.org/github-workflow.json'] = '.github/workflows/*',
          kubernetes = 'k8s/*.yaml',
        },
      },
    },
  },
  ansiblels = { filetypes = { 'yaml', 'yml', 'ansible', 'ansible.yaml', 'ansible.yml' } },
  taplo = {}, -- TOML
  bashls = {},
  sqls = {},
  lua_ls = {
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
  }
}

for name, cfg in pairs(servers) do
  cfg.on_attach = on_attach
  cfg.capabilities = capabilities
  lspconfig[name].setup(cfg)
end

------------------------------------------------------------
-- Markdown
------------------------------------------------------------
require('lspconfig').marksman.setup({
  on_attach = on_attach,
  capabilities = capabilities
})
------------------------------------------------------------
-- conform.nvim (format on save) | Formatea al guardar
------------------------------------------------------------
require('conform').setup({
  formatters_by_ft = {
    python = { 'black' },
    javascript = { 'prettierd', 'prettier' },
    typescript = { 'prettierd', 'prettier' },
    javascriptreact = { 'prettierd', 'prettier' },
    typescriptreact = { 'prettierd', 'prettier' },
    astro = { 'prettierd', 'prettier' },
    json = { 'prettierd', 'prettier' },
    yaml = { 'prettierd', 'prettier' },
    toml = { 'taplo' },
    html = { 'prettierd', 'prettier' },
    css = { 'prettierd', 'prettier' },
    markdown = { 'prettierd', 'prettier' },
    sh = { 'shfmt' },
    sql = { 'sqlfluff' }, -- optional if you use sqlfluff
  },
  format_on_save = function(bufnr)
    -- Disable for very large files
    local max = 500 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max then return end
    return { timeout_ms = 1500, lsp_fallback = true }
  end,
})

------------------------------------------------------------
-- nvim-lint (linters)
------------------------------------------------------------
require('lint').linters_by_ft = {
  python = { 'ruff' },
  javascript = { 'eslint_d', 'eslint' },
  typescript = { 'eslint_d', 'eslint' },
  javascriptreact = { 'eslint_d', 'eslint' },
  typescriptreact = { 'eslint_d', 'eslint' },
  yaml = { 'yamllint' },
  dockerfile = { 'hadolint' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

------------------------------------------------------------
-- Small Python/JS helpers | solo Mac/ Linux
------------------------------------------------------------
-- Prefer project venv if present (Unix-like). Adjust for Windows if needed.
local function activate_venv()
  local cwd = vim.fn.getcwd()
  for _, dir in ipairs({ '.venv', 'venv', '.env' }) do
    local path = cwd .. '/' .. dir .. '/bin/python'
    if vim.loop.fs_stat(path) then
      vim.g.python3_host_prog = path
      return
    end
  end
end
activate_venv()

-- Quick actions
map('n', '<leader>pi', ':Mason<CR>', { desc = 'Open Mason' })
map('n', '<leader>gs', ':Gitsigns toggle_signs<CR>', { desc = 'Toggle Git signs' })

------------------------------------------------------------
-- Final tweaks
------------------------------------------------------------
vim.diagnostic.config({ virtual_text = true, severity_sort = true })

-- Tips , consejos:
-- :Mason to install language servers / formatters / linters
-- Ensure you have these CLIs somewhere in PATH for best results:
--  Python: black, ruff
--  JS/TS/Astro/JSON/YAML/HTML/CSS: node + prettier/prettierd, eslint/eslint_d
--  Shell: shfmt  |  SQL: sqlfluff (optional)
-- Your main keys:
--   <Space> e  -> file explorer
--   <Space> t t-> toggle terminal (float)
--   gd / gr / K / <Space> rn / <Space> ca / <Space> fm -> LSP
--   <Space> ff / fg -> find files / grep

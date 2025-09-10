-- NVIM CROSS-PLATFORM STARTER FOR: Python (FastAPI/SQLAlchemy/SQLModel),
-- JS/TS (React/Node/Astro), Ansible, YAML, JSON, TOML, SQL, Docker
-- Single-file init.lua optimizado para velocidad y compatibilidad
-- Author: Malfasi Federico (Optimizado)

-- Performance boost
vim.loader.enable()

------------------------------------------------------------
-- Platform Detection / Detección de Plataforma
------------------------------------------------------------
local is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
local is_mac = vim.fn.has('macunix') == 1
local is_linux = vim.fn.has('unix') == 1 and not is_mac

------------------------------------------------------------
-- Shell optimization / Optimización de shell
------------------------------------------------------------
if is_windows then
  -- Usar cmd.exe para mejor rendimiento en Windows
  vim.opt.shell = 'cmd.exe'
  vim.opt.shellcmdflag = '/s /c'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
elseif is_mac then
  -- Optimización para macOS
  vim.opt.shell = '/bin/zsh'
elseif is_linux then
  -- Optimización para Linux
  vim.opt.shell = '/bin/bash'
end

------------------------------------------------------------
-- Basic Configuration / Configuración Básica
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

-- Clipboard cross-platform
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
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Folding configuration
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99

-- File type detection
vim.filetype.add({
  extension = {
    md = "markdown",
    MD = "markdown",
    yml = "yaml",
    yaml = "yaml"
  }
})

-- Disable diagnostics for markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- Table mode prefix
vim.g.table_mode_map_prefix = '<leader>T'

------------------------------------------------------------
-- Lazy.nvim Bootstrap / Instalación de Lazy.nvim
------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- Plugins Configuration / Configuración de Plugins
------------------------------------------------------------
require('lazy').setup({
  -- Development environment
  { 'folke/neodev.nvim',           opts = {} },

  -- UI Enhancement
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = { theme = 'auto' }
      })
    end
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- File Explorer
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('nvim-tree').setup({
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true
            }
          },
          highlight_git = true,
          highlight_opened_files = 'name',
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
      })
    end
  },

  -- Buffer management
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('bufferline').setup({})
    end
  },

  -- Themes
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Navigation & Search
  { 'nvim-lua/plenary.nvim',   lazy = true },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Syntax Highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'vim', 'vimdoc',
          'python',
          'javascript', 'typescript', 'tsx', 'jsx',
          'astro', 'html', 'css', 'scss',
          'json', 'yaml', 'toml',
          'sql', 'dockerfile', 'bash',
          'markdown', 'markdown_inline',
          'nginx'
        },
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      })
    end
  },

  -- LSP Configuration
  { 'williamboman/mason.nvim', config = true },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' }
  },
  { 'neovim/nvim-lspconfig' },
  { 'j-hui/fidget.nvim',    tag = 'legacy', config = true },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  },

  -- Formatting & Linting
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' }
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' }
  },

  -- Debugging
  { 'mfussenegger/nvim-dap',   lazy = true },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    lazy = true
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    version = '*',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<leader>tt]],
        direction = 'float',
        shade_terminals = true,
        shell = vim.o.shell
      })
    end
  },

  -- Git Integration
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true
  },

  -- Editing Enhancement
  { 'numToStr/Comment.nvim',   config = true },
  { 'tpope/vim-surround',      event = 'VeryLazy' },
  { 'windwp/nvim-autopairs',   config = true },

  -- Language Specific
  { 'pearofducks/ansible-vim', ft = { 'yaml', 'yml' } },

  -- Web Development
  {
    "windwp/nvim-ts-autotag",
    ft = { 'html', 'javascript', 'typescript', 'jsx', 'tsx' },
    config = true
  },
  {
    "NvChad/nvim-colorizer.lua",
    ft = { 'css', 'scss', 'html', 'javascript', 'typescript' },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          tailwind = true,
          css = true,
          mode = "background",
        },
      })
    end
  },

  -- Markdown Support
  { "artempyanykh/marksman", ft = "markdown" },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 1
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      -- Usa el navegador del sistema
      if is_windows then
        vim.g.mkdp_browser = 'msedge'
      elseif is_mac then
        vim.g.mkdp_browser = 'safari'
      else
        vim.g.mkdp_browser = 'firefox'
      end
    end
  },
  { "ellisonleao/glow.nvim", cmd = "Glow",   config = true },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "markdown",
    config = true
  },
  { "dhruvasagar/vim-table-mode", ft = { "markdown" } },
  { "mzlogin/vim-markdown-toc",   ft = { "markdown" } },

  -- Server Configuration
  { "chr4/nginx.vim",             ft = "nginx" },

}, {
  defaults = { lazy = true },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin"
      }
    }
  }
})

------------------------------------------------------------
-- Theme Configuration / Configuración del Tema
------------------------------------------------------------
require("onedarkpro").setup({
  options = {
    transparency = false,
  },
  styles = {
    comments = "italic",
    keywords = "bold",
    functions = "NONE",
    strings = "NONE",
    variables = "NONE",
  },
})

-- Set colorscheme
vim.cmd.colorscheme("onedark")

------------------------------------------------------------
-- LSP Configuration / Configuración de LSP
------------------------------------------------------------
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local map = vim.keymap.set

  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'gr', vim.lsp.buf.references, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  map('n', '<leader>fm', function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  map('n', '[d', vim.diagnostic.goto_prev, opts)
  map('n', ']d', vim.diagnostic.goto_next, opts)
end

-- Mason LSP setup
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls', 'pyright', 'ts_ls', 'eslint',
    'html', 'cssls', 'jsonls', 'astro',
    'dockerls', 'yamlls', 'ansiblels',
    'taplo', 'bashls', 'marksman', 'tailwindcss'
  },
  automatic_installation = true,
})

-- LSP servers configuration
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
  },
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
  ansiblels = {
    filetypes = { 'yaml', 'yml', 'ansible', 'ansible.yaml', 'ansible.yml' }
  },
  taplo = {},
  bashls = {},
  marksman = {},
  tailwindcss = {
    filetypes = {
      "html", "css", "scss", "javascript", "typescript",
      "javascriptreact", "typescriptreact", "vue", "svelte", "astro"
    },
    root_dir = require("lspconfig.util").root_pattern(
      "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts",
      "postcss.config.js", "package.json", ".git"
    ),
  }
}

for name, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = capabilities
  lspconfig[name].setup(config)
end

------------------------------------------------------------
-- Autocompletion Setup / Configuración de Autocompletado
------------------------------------------------------------
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
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
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  }
})

-- Command line completion
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
-- Formatting Configuration / Configuración de Formato
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
    sql = { 'sqlfluff' },
    go = { 'gofumpt', 'golines' },
    rust = { 'rustfmt' },
  },
  format_on_save = function(bufnr)
    local max = 500 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max then return end
    return { timeout_ms = 1500, lsp_fallback = true }
  end,
})

------------------------------------------------------------
-- Linting Configuration / Configuración de Linting
------------------------------------------------------------
require('lint').linters_by_ft = {
  python = { 'ruff' },
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  yaml = { 'yamllint' },
  dockerfile = { 'hadolint' },
  go = { 'golangci-lint' },
  rust = { 'clippy' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

------------------------------------------------------------
-- Python Environment Detection / Detección de Entorno Python
------------------------------------------------------------
local function setup_python()
  local cwd = vim.fn.getcwd()
  local python_paths = {}

  if is_windows then
    python_paths = { '.venv/Scripts/python.exe', 'venv/Scripts/python.exe' }
  else
    python_paths = { '.venv/bin/python', 'venv/bin/python', '.env/bin/python' }
  end

  for _, path in ipairs(python_paths) do
    local full_path = cwd .. '/' .. path
    if vim.loop.fs_stat(full_path) then
      vim.g.python3_host_prog = full_path
      return
    end
  end
end

setup_python()

------------------------------------------------------------
-- Key Mappings / Mapeo de Teclas
------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

-- File Explorer
map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', opts)
map('n', '<leader>o', '<cmd>NvimTreeFocus<cr>', opts)

-- Buffer Navigation
map('n', '<S-l>', '<cmd>bnext<cr>', opts)
map('n', '<S-h>', '<cmd>bprevious<cr>', opts)
map('n', '<leader>c', '<cmd>bd<cr>', opts)
map('n', '<leader>m', '<cmd>cclose<cr>', opts)

-- Markdown
map('n', '<leader>mp', '<cmd>PeekOpen<cr>', opts)
map('n', '<leader>mP', '<cmd>PeekClose<cr>', opts)
map('n', '<leader>mg', '<cmd>Glow<cr>', opts)
map('n', '<leader>tm', '<cmd>TableModeToggle<cr>', opts)
map('n', '<leader>tc', '<cmd>GenTocGFM<cr>', opts)
map('n', '<leader>tC', '<cmd>RemoveToc<cr>', opts)

-- Utility
map('n', '<leader>pi', '<cmd>Mason<cr>', opts)
map('n', '<leader>gs', '<cmd>Gitsigns toggle_signs<cr>', opts)
map('n', '<leader>id', function() install_dependencies() end, { desc = 'Install Dependencies' })

-- Clear search highlighting
map('n', '<Esc>', '<cmd>nohlsearch<cr>', opts)

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

------------------------------------------------------------
-- Final Configuration / Configuración Final
------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

-- Auto-install missing parsers when entering buffer
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= "" then
      local lang = require("nvim-treesitter.parsers").ft_to_lang(ft)
      if lang and not pcall(vim.treesitter.get_parser, 0, lang) then
        vim.schedule(function()
          vim.cmd("TSInstall " .. lang)
        end)
      end
    end
  end,
})

-- Performance: reduce CursorHold delay
vim.opt.updatetime = 100

print("🚀 Neovim configurado correctamente para " .. (is_windows and "Windows" or is_mac and "macOS" or "Linux"))

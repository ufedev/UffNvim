return {
  -- Essential
  { 'folke/neodev.nvim',           opts = {} },
  { 'nvim-lua/plenary.nvim',       lazy = true },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- UI Enhancement
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    config = function()
      require('lualine').setup({
        options = { theme = 'auto' }
      })
    end
  },

  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = "nvim_lsp",
          offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "left" }
          },
        }
      })
    end
  },

  -- Themes
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = true,
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = false,
    config = function()
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
      vim.cmd.colorscheme("onedark")
    end
  },

  -- File Explorer
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('nvim-tree').setup({
        disable_netrw = true,
        hijack_netrw = true,
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
        update_focused_file = { enable = true, update_root = true },
        view = { width = 30 },
      })
    end
  },

  -- Navigation & Search
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          file_ignore_patterns = { "node_modules", ".git/" },
        }
      })
    end
  },

  -- Treesitter (Syntax Highlighting)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'vim', 'vimdoc',
          'python',
          'javascript', 'typescript', 'tsx',
          'astro', 'html', 'css',
          'json', 'yaml', 'toml',
          'sql', 'dockerfile', 'bash',
          'markdown', 'markdown_inline',
          'svelte', 'vue', 'nginx'
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        autotag = { enable = true },
      })
    end
  },

  -- LSP & Mason
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls', 'pyright', 'ts_ls', 'eslint', 'html', 'cssls',
          'jsonls', 'astro', 'dockerls', 'yamlls', 'ansiblels',
          'taplo', 'bashls', 'marksman'
          -- Tailwind se instala por separado para evitar conflictos
        },
        automatic_installation = true,
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        local map = vim.keymap.set
        map('n', 'gd', vim.lsp.buf.definition, opts)
        map('n', '<leader>ge', vim.lsp.buf.references, opts)
        map('n', 'K', vim.lsp.buf.hover, opts)
        map('n', '<leader>rn', vim.lsp.buf.rename, opts)
        map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        map('n', '<leader>fm', function() vim.lsp.buf.format({ async = true }) end, opts)
        map('n', '[d', vim.diagnostic.goto_prev, opts)
        map('n', ']d', vim.diagnostic.goto_next, opts)
      end

      -- Server configurations
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
        ts_ls = {
          filetypes = {
            "javascript", "javascriptreact",
            "typescript", "typescriptreact"
          }
        },
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
        taplo = {},
        bashls = {},
        marksman = {},
      }

      for name, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[name].setup(config)
      end

      -- Tailwind CSS setup separado (para evitar conflictos con Mason)
      vim.defer_fn(function()
        if vim.fn.executable("tailwindcss-language-server") == 1 then
          lspconfig.tailwindcss.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
              "html", "css", "scss", "javascript", "typescript",
              "javascriptreact", "typescriptreact", "vue", "svelte", "astro"
            },
            root_dir = lspconfig.util.root_pattern(
              "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts",
              "postcss.config.js", "package.json", ".git"
            ),
          })
        end
      end, 2000)
    end
  },

  { 'j-hui/fidget.nvim',     tag = 'legacy',                             event = 'LspAttach', config = true },

  -- Completion
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
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
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
    end
  },

  -- Command line completion (separate for always available)
  {
    'hrsh7th/cmp-cmdline',
    event = 'CmdlineEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      local cmp = require('cmp')

      -- Command line completion for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          },
          {
            { name = 'emoji' }
          }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Command line completion for '/' and '?'
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        },
        {
          {
            name = 'emoji'
          }
        }
      })
    end
  },

  -- Formatting & Linting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    config = function()
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
        },
        format_on_save = function(bufnr)
          local max = 500 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          if ok and stats and stats.size > max then return end
          return { timeout_ms = 1500, lsp_fallback = true }
        end,
      })
    end
  },

  {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePost' },
    config = function()
      require('lint').linters_by_ft = {
        python = { 'ruff' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        yaml = { 'yamllint' },
        dockerfile = { 'hadolint' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end
  },

  -- Debug (lazy loaded)
  { 'mfussenegger/nvim-dap', lazy = true },
  { 'rcarriga/nvim-dap-ui',  dependencies = { 'mfussenegger/nvim-dap' }, lazy = true },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    keys = { "<leader>tt" },
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

  -- Git & Quality of Life
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true
  },
  {
    'numToStr/Comment.nvim',
    keys = { "gc", "gb" },
    config = true
  },
  {
    'tpope/vim-surround',
    event = "VeryLazy"
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },

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
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          tailwind = true,
          css = true,
          mode = "background", -- Fixed typo
        },
      })
    end
  },

  -- Markdown Support
  { "artempyanykh/marksman",   ft = "markdown" },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end
  },
  { "ellisonleao/glow.nvim",        cmd = "Glow",       config = true },
  { "lukas-reineke/headlines.nvim", ft = "markdown",    config = true },
  { "dhruvasagar/vim-table-mode",   ft = { "markdown" } },
  { "mzlogin/vim-markdown-toc",     ft = { "markdown" } },

  -- Server Configuration
  { "chr4/nginx.vim",               ft = "nginx" },

}, {
  defaults = { lazy = true },
  install = { colorscheme = { "onedark" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin"
      }
    }
  }
}

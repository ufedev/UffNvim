return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    lazy = false,
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- Automatically set inlay hints
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = '<- ',
            other_hints_prefix = '=> ',
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- LSP keymaps específicos para Rust
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.keymap.set('n', '<leader>ra', function()
              vim.cmd.RustLsp('codeAction')
            end, opts)
            vim.keymap.set('n', '<leader>rr', function()
              vim.cmd.RustLsp('runnables')
            end, opts)
            vim.keymap.set('n', '<leader>rd', function()
              vim.cmd.RustLsp('debuggables')
            end, opts)
            vim.keymap.set('n', '<leader>rm', function()
              vim.cmd.RustLsp('expandMacro')
            end, opts)
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust
              checkOnSave = {
                allFeatures = true,
                command = 'clippy',
                extraArgs = { '--no-deps' },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {
          adapter = {
            type = 'executable',
            command = 'lldb-vscode',
            name = 'rt_lldb',
          },
        },
      }
    end,
  },

  -- Rust crate management
  {
    'saecki/crates.nvim',
    tag = 'stable',
    ft = { 'rust', 'toml' },
    config = function()
      require('crates').setup({
        src = {
          cmp = { enabled = true },
        },
        null_ls = {
          enabled = true,
          name = 'crates.nvim',
        },
        popup = {
          autofocus = true,
          style = 'minimal',
          border = 'rounded',
        },
      })
    end,
  }
}

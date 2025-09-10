return
-- =============================================================================
-- GO SUPPORT
-- =============================================================================
{
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        -- Auto format and import on save
        gofmt = 'gopls',
        goimports = 'gopls',
        fillstruct = 'gopls',

        -- LSP config
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = true,
        lsp_keymaps = true,
        lsp_codelens = true,

        -- Diagnostic config
        diagnostic = {
          hdlr = false,
          underline = true,
          virtual_text = { space = 0, prefix = '' },
          signs = true,
          update_in_insert = false,
        },

        -- Test config
        run_in_floaterm = true,
        floaterm = {
          posititon = 'auto',
          width = 0.45,
          height = 0.98,
        },
      })
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
  },

  -- Go tools installer
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('gopher').setup({
        commands = {
          go = 'go',
          gomodifytags = 'gomodifytags',
          gotests = 'gotests',
          impl = 'impl',
          iferr = 'iferr',
        },
      })
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  }
}

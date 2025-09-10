return
{
  {
    'allaman/emoji.nvim',
    version = '1.*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('emoji').setup({
        enable_cmp_integration = true,
      })
    end
  },

  -- Emoji picker con Telescope
  {
    'xiyaowong/telescope-emoji.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('telescope').load_extension('emoji')
    end
  }
}

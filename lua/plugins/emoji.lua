return
{
  -- Emoji picker con Telescope
  {
    'xiyaowong/telescope-emoji.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      telescope.setup({
        pickers = {
          emoji = {
            attach_mapping = function(_, map)
              map('i', '<CR>', function(prompt_bufnr)
                local emoji = action_state.get_selected_entry().value
                actions.close(prompt_bufnr)
                vim.api.nvim_feedkeys(emoji, 'n', true)
              end)
              map('n', '<CR>', function(prompt_bufnr)
                local emoji = action_state.get_selected_entry().value
                actions.close(prompt_bufnr)
                vim.api.nvim_put({ emoji }, 'c', true, true)
              end)
              return true
            end
          }
        }
      })

      require('telescope').load_extension('emoji')
    end
  }
}

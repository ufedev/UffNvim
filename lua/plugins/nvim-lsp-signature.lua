return {
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        bind = true,
        handler_opts = {
          border = "rounded"
        },
        floating_window = true,
        hint_enable = true,
        floating_window_above_cur_line = true,
        hint_prefix = "📎",
        hi_parameter = "LspSignatureActiveParameter",
        always_trigger = true,
      })
    end
  }
}

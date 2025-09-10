local M = {}


function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("OilAutoOpen", { clear = true }),
    callback = function()
      if vim.fn.argc() == 0 then
        require('oil').open()
      elseif vim.fn.argc() == 1 then
        local arg = vim.fn.argv(0)
        if vim.fn.isdirectory(arg) == 1 then
          require('oil').open(arg)
        end
      end
    end,

  })
end

return M

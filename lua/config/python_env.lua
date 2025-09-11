------------------------------------------------------------
-- Python Environment Detection
------------------------------------------------------------

local function activate_venv()
  local cwd = vim.fn.getcwd()
  local is_win = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1

  local path = is_win and
      '.venv/Scripts/python.exe'
      or
      '.venv/bin/python3'
  local fullpath = cwd .. '/' .. path
  if vim.loop.fs_stat(path) then
    vim.cmd('LspPyrightSetPythonPath ' .. fullpath)
    return
  end
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.defer_fn(activate_venv, 300)
  end
})

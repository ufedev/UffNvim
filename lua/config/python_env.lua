------------------------------------------------------------
-- Python Environment Detection
------------------------------------------------------------
local function activate_venv()
  local cwd = vim.fn.getcwd()
  local paths = is_windows and
      { '.venv/Scripts/python.exe', 'venv/Scripts/python.exe' } or
      { '.venv/bin/python', 'venv/bin/python', '.env/bin/python' }

  for _, dir in ipairs(paths) do
    local path = cwd .. '/' .. dir
    if vim.loop.fs_stat(path) then
      vim.g.python3_host_prog = path
      return
    end
  end
end
activate_venv()

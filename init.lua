-- NVIM CROSS-PLATFORM STARTER OPTIMIZADO
-- Author: Malfasi Federico (Optimizado para velocidad)
-- Performance boost
-- local vim = vim
vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
------------------------------------------------------------
-- Platform Detection
------------------------------------------------------------
is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
------------------------------------------------------------
-- Basic Configuration
------------------------------------------------------------
require('config')
local function set_transparent_bg()
  local transparent_groups = {
    "Normal",
    "NormalFloat",
    "NonText",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer"
  }

  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

-- Aplicar después de cargar cualquier tema
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_transparent_bg
})

-- Aplicar inmediatamente
set_transparent_bg()
local helpers = require('utils.helpers')

------------------------------------------------------------
-- Lazy.nvim Bootstrap
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
-- Plugins (Optimized Loading)
------------------------------------------------------------
--- List of plugins

local plugins = helpers.merge_plugins(
  require('plugins'),
  require('plugins.oil'),
  require('plugins.emoji'),
  require('plugins.go'),
  require('plugins.rust'),
  require('plugins.ui'),
  require('plugins.nvim-lsp-signature')
)
--print('Loaded Plugins :' .. #plugins)
require('lazy').setup(plugins)
------------------------------------------------------------
-- Keymaps keymaps/init.lua
------------------------------------------------------------
require('keymaps')
------------------------------------------------------------
-- Python Env detection
------------------------------------------------------------
require('config.python_env')
------------------------------------------------------------
-- Final Configuration - utils install dependencies
------------------------------------------------------------
require('utils.init')
--require('config.oil_auto').setup()
-- Message
-- print("UffNVIM was installed perfectly. enjoy it")

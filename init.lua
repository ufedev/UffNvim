-- NVIM CROSS-PLATFORM STARTER OPTIMIZADO

-- Author: Malfasi Federico (Optimizado para velocidad)
-- Performance boost
-- local vim = vim
vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.matchup_matchparen_offscreen = { method = 'popup' }
------------------------------------------------------------
-- Platform Detection
------------------------------------------------------------
is_windows = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
------------------------------------------------------------
-- Basic Configuration
------------------------------------------------------------
require('config')

-- Aplicar inmediatamente
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
  -- require('plugins.ministarter'),
  require('plugins.emoji'),
  require('plugins.go'),
  require('plugins.rust'),
  require('plugins.ui'),
  require('plugins.nvim-lsp-signature'),
  require('plugins.vim_matchup')
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

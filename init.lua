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
-- Basic Configuration ---------------------------------------------------------
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
  require('plugins.emoji'),
  require('plugins.go'),
  require('plugins.rust'),
  require('plugins.ui'),
  require('plugins.nvim_lsp_signature'),
  require('plugins.vim_matchup'),
  require("plugins.auto_tag"),
  -- Indens, Rainbow --
  require("plugins.indent_blankline"),
  require("plugins.rainbow_delimeters"),
  -- IA Plug --
  require('plugins.ia'),
  -- UI Enhancement --
  require('plugins.ui-enhancement'),
  -- Animations --
  require("plugins.animations"),
  -- Snippet --
  require("plugins.snippet")
-- which keys --
-- require('plugins.which_keys')
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
-- Corrección resaltado de imports no usados y folding de funciones o bloques de códigos
vim.api.nvim_set_hl(0, "Folded", { fg = "#256EB5", nocombine = true, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnused", { fg = "#2563EB", italic = true, nocombine = true })
vim.api.nvim_set_hl(0, "DiagnosticUnusedImport", { fg = "lightred", italic = true, bold = true })

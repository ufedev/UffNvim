return {
  -- 🌊 SMOOTH SCROLLING PRINCIPAL
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- Mapear todas estas teclas con animación smooth
        mappings = {
          '<C-u>', -- Half page up
          '<C-d>', -- Half page down
          '<C-b>', -- Page up
          '<C-f>', -- Page down
          '<C-y>', -- Scroll line up
          '<C-e>', -- Scroll line down
          'zt',    -- Top this line
          'zz',    -- Center this line
          'zb',    -- Bottom this line
        },

        -- Configuración de la animación
        hide_cursor = true,          -- Ocultar cursor mientras hace scroll
        stop_eof = true,             -- Parar en final de archivo
        respect_scrolloff = false,   -- No respetar scrolloff
        cursor_scrolls_alone = true, -- El cursor sigue scrolleando aunque la ventana no pueda
        easing_function = nil,       -- Función de easing (nil = linear)
        pre_hook = nil,              -- Función antes del scroll
        post_hook = nil,             -- Función después del scroll
        performance_mode = false,    -- Deshabilitar en archivos grandes
      })
    end
  },

  -- 🎭 ANIMACIONES DE CURSOR Y MOVIMIENTO
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- No usar animate cuando scrolling con mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        cursor = {
          timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
          path = animate.gen_path.line(),
        },
        open = { timing = animate.gen_timing.linear({ duration = 150, unit = "total" }) },
        close = { timing = animate.gen_timing.linear({ duration = 150, unit = "total" }) },
      }
    end,
  },

  -- 🔍 ANIMACIÓN EN BÚSQUEDAS
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- Configuración de flash para movimientos súper rápidos
      search = {
        multi_window = true,
        forward = true,
        wrap = true,
        incremental = false,
      },
      jump = {
        jumplist = true,
        pos = "start", -- "start" | "end" | "range"
        history = false,
        register = false,
        nohlsearch = false,
        autojump = false,
      },
      label = {
        uppercase = true,
        exclude = "",
        current = true,
        after = true,        -- show the label after the match
        before = false,      -- show the label before the match
        style = "overlay",   -- "eol" | "overlay" | "right_align" | "inline"
        reuse = "lowercase", -- "lowercase" | "all"
        distance = true,
      },
      highlight = {
        backdrop = true,
        matches = true,
        priority = 5000,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      modes = {
        search = {
          enabled = true, -- cuando usas `/` o `?`
          highlight = { backdrop = false },
          jump = { history = true, register = true, nohlsearch = true },
          search = {
            multi_window = true,
            forward = true,
            wrap = true,
            incremental = false,
          },
        },
        char = {
          enabled = true,
          config = function(opts)
            opts.autohide = opts.autohide == nil and (vim.fn.mode(true):find("no") and vim.v.operator == "y")
            opts.jump_labels = opts.jump_labels == nil and (vim.fn.mode(true):find("no") and vim.v.operator ~= "y")
          end,
          autohide = false,
          jump_labels = false,
          multi_line = true,
          label = { exclude = "hjkliardc" },
          keys = { "f", "F", "t", "T", ";" },
        },
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range" },
          search = { incremental = false },
          label = {
            before = true,
            after = true,
            style = "inline",
          },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
      },
    },
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- 🌟 ANIMACIÓN DE HIGHLIGHTING (cuando saltas a una línea)
  {
    "DanilaMihailov/beacon.nvim",
    event = "BufReadPost",
    config = function()
      vim.g.beacon_size = 40
      vim.g.beacon_fade = 1
      vim.g.beacon_minimal_jump = 10
      vim.g.beacon_show_jumps = 1
      vim.g.beacon_ignore_filetypes = {
        'qf', 'NvimTree', 'neo-tree', 'TelescopePrompt', 'noice', 'notify'
      }

      -- Keymaps para trigger manual
      vim.keymap.set('n', '<leader>b', ':Beacon<CR>', { desc = 'Flash beacon', silent = true })
    end,
  }

}

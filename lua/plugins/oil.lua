----------------------------------
--- Oil
--- ------------------------------
return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = false,
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        keymaps = {
          ["<CR>"] = "actions.select",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["g."] = "actions.toggle_hidden",
        },
        use_default_keymaps = true,
      })
    end,
  }
}

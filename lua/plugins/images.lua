return {
  -- Con lazy.nvim
  {
    "3rd/image.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    build = false,
    config = function()
      require("image").setup({
        backend = "kitty", -- o "ueberzug"
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
          },
        },
      })
    end
  }
}

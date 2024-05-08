return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('nvim-tree').setup({
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
        filters = {
            dotfiles = false,
        },
        update_focused_file = {
            enable = true,
        },
    })

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<CR>")

  end,
}

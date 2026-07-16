return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-web-devicons').setup({
      strict = true,
      override_by_extension = {
        astro = {
          icon = '',
          color = '#EF8547',
          name = 'astro',
        },
      },
    })

    require('nvim-tree').setup({
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        side = 'right',
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
    vim.keymap.set('n', '<leader>no', ':NvimTreeFindFileToggle<CR>')
  end,
}

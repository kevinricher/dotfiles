return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        astro = { 'prettier' },
        json = { 'prettier' },
        graphql = { 'prettier' },
        markdown = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        html = { 'htmlbeautifier' },
        yaml = { 'yamlfix' },
        bash = { 'beautysh' },
      },
    })
  end,
  keys = {
    {
      '<leader>f',
      function() require('conform').format({ async = true, lsp_fallback = true }) end,
      mode = '',
      desc = 'Format buffer or selection',
    },
  },
  --    opts = {
  --      notify_on_error = false,
  --      format_on_save = {
  --        timeout_ms = 500,
  --        lsp_fallback = true,
  --      },
  --      formatters_by_ft = {
  --        lua = { 'stylua' },
  --        javascript = { 'prettierd' },
  --      },
  --    },
}

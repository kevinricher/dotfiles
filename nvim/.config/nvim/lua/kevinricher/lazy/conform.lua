return { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function ()
      local conform = require('conform')

      conform.setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettierd', 'prettier' },
          typescript = { 'prettierd', 'prettier' },
          javascriptreact = { 'prettierd', 'prettier' },
          typescriptreact = { 'prettierd', 'prettier' },
          json = { 'prettierd', 'prettier' },
          graphql = { 'prettierd', 'prettier' },
          markdown = { 'prettierd', 'prettier' },
          css = { 'prettierd', 'prettier' },
          scss = { 'prettierd', 'prettier' },
          html = { 'htmlbeautifier' },
          yaml = { 'yamlfix' },
          bash = { 'beautysh' }
        }
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>lf', function ()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = 'Format file or range (in visual mode)'})
    end,
    keys = {{
        "<leader>f",
        function ()
            require("conform").format({async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
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

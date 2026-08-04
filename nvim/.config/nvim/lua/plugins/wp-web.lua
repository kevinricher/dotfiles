return {
  -- CSS treesitter for WordPress stylesheets (html/php already covered by base LazyVim)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "css" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        html = {},
        emmet_language_server = {
          -- Emmet's default filetypes don't include php, but WordPress
          -- templates mix raw HTML markup directly into .php files.
          filetypes = {
            "astro",
            "css",
            "eruby",
            "html",
            "htmlangular",
            "htmldjango",
            "javascriptreact",
            "less",
            "php",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
          },
        },
      },
    },
  },

  -- PHP step-debugging (Xdebug): the dap adapter is already defined inside
  -- lang.php's extra now that dap.core is enabled, but the binary itself
  -- still needs to be installed.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "php-debug-adapter" },
    },
  },

  -- nvim-lint's bundled phpcs linter resolves `vendor/bin/phpcs` relative to
  -- `getcwd()` (not the buffer's project root), and phpcs itself only
  -- auto-discovers phpcs.xml by walking up from its OWN process cwd, not
  -- from the file being linted. If Neovim wasn't launched from the project
  -- root, both of those silently fail: it falls back to a global phpcs
  -- binary that doesn't know where the project's WordPress/WPCS ruleset is
  -- registered, AND it can't find phpcs.xml, so it silently lints against
  -- PEAR's default standard instead - producing diagnostics that actively
  -- contradict the project's real coding standard (e.g. flagging WordPress's
  -- required tab indentation as an error).
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        phpcs = {
          cmd = function()
            local root = vim.fs.root(0, { "composer.json", "phpcs.xml", "phpcs.xml.dist" })
            local local_bin = root and (root .. "/vendor/bin/phpcs")
            if local_bin and vim.uv.fs_stat(local_bin) then
              return local_bin
            end
            return "phpcs"
          end,
          args = {
            "-q",
            "--report=json",
            function()
              local ruleset = vim.fs.find({ "phpcs.xml", "phpcs.xml.dist" }, {
                path = vim.fn.expand("%:p:h"),
                upward = true,
              })[1]
              return ruleset and ("--standard=" .. ruleset) or "-q"
            end,
            function()
              return "--stdin-path=" .. vim.fn.expand("%:p")
            end,
            "-",
          },
        },
      },
    },
  },

  -- LazyVim's lang.php extra always formats php with php_cs_fixer's PSR12
  -- preset, but php-cs-fixer has no native WordPress ruleset, and PSR12
  -- directly contradicts WPCS on things like indentation (spaces vs the
  -- tabs WordPress requires). Formatting with PSR12 while linting against
  -- WordPress means every save re-introduces the exact violations phpcs
  -- just flagged. phpcbf (phpcs's own auto-fixer) fixes to the SAME
  -- phpcs.xml ruleset that lints the file, so they can never disagree -
  -- prefer it whenever the project has actually set one up itself, and
  -- fall back to php_cs_fixer for ordinary (non-WPCS) PHP projects.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "phpcbf", "php_cs_fixer", stop_after_first = true },
      },
      formatters = {
        phpcbf = {
          -- phpcbf discovers phpcs.xml by walking up from its OWN process
          -- cwd (same as phpcs), not from $FILENAME's directory. Without
          -- this it silently falls back to a default standard and actively
          -- fights the project's real one instead of fixing to it.
          condition = function(_, ctx)
            local root = vim.fs.root(ctx.dirname, { "composer.json", "phpcs.xml", "phpcs.xml.dist" })
            return root ~= nil and vim.uv.fs_stat(root .. "/vendor/bin/phpcbf") ~= nil
          end,
          cwd = function(_, ctx)
            return vim.fs.root(ctx.dirname, { "composer.json", "phpcs.xml", "phpcs.xml.dist" })
          end,
          require_cwd = true,
        },
      },
    },
  },

}

-- friendly-snippets registers several doc-comment snippet sets under
-- VSCode's sub-language ids ("phpdoc", "jsdoc", "tsdoc", "pydoc") rather
-- than the actual buffer filetype - a distinction Neovim's flat filetype
-- model doesn't have, so blink.cmp's registry never loads them at all for
-- a plain .php/.js/.ts/.py buffer (verified: e.g. javascript loaded 209
-- snippets and 0 of jsdoc.json's 88 until this was added).
--
-- `extended_filetypes` has to go under the "snippets" PROVIDER's own opts
-- (sources.providers.snippets.opts), not the top-level `snippets` config -
-- blink.cmp never threads the top-level `snippets` table into the actual
-- running snippets source (confirmed: sources.providers.snippets.opts is
-- nil at runtime unless set here directly), so putting it there is a no-op
-- that silently does nothing.
return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              extended_filetypes = {
                php = { "phpdoc" },
                javascript = { "jsdoc" },
                javascriptreact = { "jsdoc" },
                typescript = { "jsdoc", "tsdoc" },
                typescriptreact = { "jsdoc", "tsdoc" },
                python = { "pydoc" },
              },
            },
          },
        },
      },
    },
  },
}

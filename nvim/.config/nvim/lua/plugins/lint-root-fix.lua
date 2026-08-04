-- sqlfluff/hadolint/markdownlint-cli2 all lint via stdin with no filename
-- argument, so they have no path context of their own to discover their
-- project config (.sqlfluff / .hadolint.yaml / .markdownlint-cli2.jsonc) -
-- they fall back to Neovim's raw process cwd, or (for sqlfluff via stdin)
-- fail outright. If Neovim wasn't launched from inside the project, they
-- silently lint against the wrong config or none at all - same failure
-- shape as the phpcs bug in wp-web.lua. All three tools accept an explicit
-- config-file path, which sidesteps cwd/discovery entirely.
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        sqlfluff = {
          args = {
            "lint",
            "--format=json",
            function()
              return "--stdin-filename=" .. vim.fn.expand("%:p")
            end,
            "-",
          },
        },
        hadolint = {
          args = {
            "-f",
            "json",
            function()
              local cfg = vim.fs.find({ ".hadolint.yaml", ".hadolint.yml" }, {
                path = vim.fn.expand("%:p:h"),
                upward = true,
              })[1]
              return cfg and ("--config=" .. cfg) or "-f"
            end,
            "-",
          },
        },
        -- gopls has printf/vet-family analyzers on by default, and
        -- golangci-lint's default linter set includes `govet`, which runs
        -- the same vet passes - so e.g. a bad fmt.Printf format string gets
        -- reported twice, verbatim, by two different sources. Disabling
        -- just `govet` here (not staticcheck/unused/etc., which gopls
        -- doesn't duplicate) keeps golangci-lint's other checks intact.
        golangcilint = {
          prepend_args = { "-D", "govet" },
        },

        -- nvim-lint's `args` field must be a plain table whose individual
        -- elements can be functions (each independently evaluated to one
        -- value) - it can't itself be a function returning a dynamically
        -- sized list. markdownlint-cli2 also errors hard on a --config
        -- pointing at a nonexistent path, and misparses `--config=path` as
        -- a glob rather than a flag+value. So the whole linter entry needs
        -- to be a function instead (nvim-lint calls it fresh every time, lint.lua:83),
        -- letting us build a correctly-sized args table only when a config
        -- file actually exists.
        ["markdownlint-cli2"] = function()
          local linter = vim.deepcopy(require("lint.linters.markdownlint-cli2"))
          local cfg = vim.fs.find({
            ".markdownlint-cli2.jsonc",
            ".markdownlint-cli2.yaml",
            ".markdownlint.jsonc",
            ".markdownlint.yaml",
          }, {
            path = vim.fn.expand("%:p:h"),
            upward = true,
          })[1]
          if cfg then
            linter.args = { "--config", cfg, "-" }
          end
          return linter
        end,
      },
    },
  },
}

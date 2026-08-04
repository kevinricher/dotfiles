-- lang.python's DAP block configures the adapter's command as the literal
-- string "debugpy-adapter", resolved via $PATH - but unlike lang.go (which
-- explicitly Mason-installs "delve") and lang.php (which we added
-- "php-debug-adapter" for), nothing ensures the debugpy Mason package is
-- actually installed. Without it, pressing <leader>db + <leader>dc in a
-- .py file fails immediately with "Executable `debugpy-adapter` not found".
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "debugpy" },
    },
  },
}

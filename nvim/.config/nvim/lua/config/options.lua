-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim's default root detection (`{ "lsp", { ".git", "lua" }, "cwd" }`) only
-- falls back to project-marker patterns after checking attached LSP clients, which
-- races LSP-attach timing on a freshly opened buffer. Checking common project
-- manifests first makes root detection (used by <leader>e, LazyRoot, etc.) resolve
-- correctly and instantly, even for non-git projects opened from an unrelated cwd.
vim.g.root_spec = {
  { ".git", "lua", "composer.json", "package.json", "Cargo.toml", "go.mod" },
  "lsp",
  "cwd",
}

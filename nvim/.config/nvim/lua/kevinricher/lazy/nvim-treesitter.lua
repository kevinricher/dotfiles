return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"html",
				"css",
				"javascript",
        "jsdoc",
				"typescript",
				"go",
				"c",
        "c_sharp",
				"cpp",
				"php",
				"lua",
				"sql",
        "prisma",
        "graphql",
				"vim",
				"vimdoc",
				"query",
				"toml",
				"markdown_inline",
				"regex",
				"json",
				"xml",
				"gitignore",
				"dockerfile",
				"terraform",
			},
			sync_install = false,
			auto_install = true,
			indent = { enable = true },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})

    -- Configure folding
    vim.opt.foldenable = false
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

	end,
}

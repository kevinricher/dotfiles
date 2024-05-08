-- Don't forget to install ripgrep! https://github.com/BurntSushi/ripgrep
return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>jh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>jk", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>jf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>js", builtin.builtin, {})
			vim.keymap.set("n", "<leader>jg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>jw", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
			vim.keymap.set("n", "<leader>jr", builtin.resume, {})
			vim.keymap.set("n", "<leader>jd", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>j.", builtin.oldfiles, {})

			vim.keymap.set("n", "<leader>jn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[F]ind [N]eovim files" })
		end,
	},
}

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
			vim.keymap.set("n", "<leader>jh", builtin.help_tags, { desc = "[J]ump [H]elp tags" })
			vim.keymap.set("n", "<leader>jk", builtin.keymaps, { desc = "[J]ump [K]eymaps" })
			vim.keymap.set("n", "<leader>jf", builtin.find_files, { desc = "[J]ump [F]iles" })
			vim.keymap.set("n", "<leader>jb", builtin.builtin, { desc = "[J]ump [B]uiltin" })
			vim.keymap.set("n", "<leader>jg", builtin.git_files, { desc = "[J]ump [G]it files" })
			vim.keymap.set("n", "<leader>jw", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "[J]ump [W]ord" })
			vim.keymap.set("n", "<leader>jr", builtin.resume, { desc = "[J]ump [R]esume" })
			vim.keymap.set("n", "<leader>jd", builtin.diagnostics, { desc = "[J]ump [D]iagnostics" })
			vim.keymap.set("n", "<leader>jo", builtin.oldfiles, { desc = "[J]ump [O]ldfiles"})

			vim.keymap.set("n", "<leader>jn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[J]ump [N]eovim files" })
		end,
	},
}

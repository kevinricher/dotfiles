return {
	"nvim-neotest/neotest",
	dependencies = {
    "nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",
		"thenbe/neotest-playwright",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		local neotest = require("neotest")
		-- Configure adapters
		neotest.setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
				{
					require("neotest-playwright").adapter({
						options = {
							persist_project_selection = true,
							enable_dynamic_test_discovery = true,
						},
					}),
				},
				neotest.setup({
					adapters = {
						require("neotest-go")({
							recursive_run = true,
						}),
					},
				}),
			},
		})

		vim.keymap.set("n", "<leader>kj", function()
			neotest.run.run()
		end)

		vim.keymap.set("n", "<leader>kk", function()
			neotest.run.run(vim.fn.expand("%"))
		end)
	end,
}

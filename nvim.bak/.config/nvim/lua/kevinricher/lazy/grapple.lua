return {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-telescope/telescope.nvim",
                  { "nvim-tree/nvim-web-devicons", lazy = true }},
    opts = {
      scope = "git",
      icons = true,
      status = false,
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>ea", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
      { "<leader>ee", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

      { "<leader>eh", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
      { "<leader>ej", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
      { "<leader>ek", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
      { "<leader>el", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

      { "<leader>ep", "<cmd>Grapple cycle backward<cr>", desc = "Go to previous tag" },
      { "<leader>en", "<cmd>Grapple cycle forward<cr>", desc = "Go to next tag" },
    },
  }

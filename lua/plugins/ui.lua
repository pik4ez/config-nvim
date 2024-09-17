return {
	{
		"lifepillar/vim-solarized8",
		config = function()
			vim.cmd.colorscheme("solarized8")
			vim.o.background = "light"
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(_, opts)
			require("lualine").setup({
				options = { theme = "solarized_light" },
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		opts = {
			event_handlers = {
				{
					event = "file_open_requested",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		},
		keys = {
			{ "<leader>f", "<cmd>Neotree source=filesystem<cr>", desc = "NeoTree Files" },
			{ "<leader>b", "<cmd>Neotree source=buffers<cr>", desc = "NeoTree Buffers" },
		},
	},
}

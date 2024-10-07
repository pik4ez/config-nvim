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
				options = {
					theme = "solarized_light",
					path = 1,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sharkdp/fd",
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function(_, opts)
			local actions = require("telescope.actions")
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "respect_case", -- or "ignore_case" or "smart_case"
					},
				},
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-u>"] = false, -- clear the prompt rather than scrolling the preview
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
							["<C-d>"] = actions.delete_buffer,
						},
					},
					preview = {
						filesize_limit = 0.1, -- MB
					},
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
		keys = {
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope files picker",
			},
			{
				"<leader>F",
				function()
					require("telescope").extensions.file_browser.file_browser()
				end,
				desc = "Telescope file browser",
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Telescope buffers picker",
			},
			{
				"<leader>r",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Telescope live grep picker",
			},
			{
				"\\d",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				desc = "Telescope LSP definitions picker",
			},
			{
				"\\r",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "Telescope LSP references picker",
			},
			{
				"\\t",
				function()
					require("telescope.builtin").lsp_type_definitions()
				end,
				desc = "Telescope LSP type definitions picker",
			},
		},
	},
}

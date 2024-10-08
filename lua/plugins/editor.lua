return {
	{
		"stevearc/conform.nvim",
		dependencies = { "williamboman/mason.nvim" },
		lazy = true,
		event = { "BufWritePre" },
		opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
				python = { "codespell", "isort", "ruff" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 3000,
			},
		},
	},
	{
		"williamboman/mason.nvim",
		keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				-- Formatters.
				"goimports",
				"gofumpt",
				"isort",
				"codespell",
				"ruff",
				"prettierd",
				"prettier",
				"stylua",
				"shfmt",

				-- Language servers.
				"gopls",
				"pyright",
				"marksman",
				"json-lsp",
				"yaml-language-server",
				"bash-language-server",
				"dockerfile-language-server",
				"tflint",
				"harper-ls",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function(_, opts)
			local mlc = require("mason-lspconfig")
			mlc.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			return {
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-[>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				}),
			}
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = false, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = function()
			return {
				surrounds = {
					["l"] = {
						add = function()
							local clipboard = vim.fn.getreg("+"):gsub("\n", "")
							return {
								{ "[" },
								{ "](" .. clipboard .. ")" },
							}
						end,
						find = "%b[]%b()",
						delete = "^(%[)().-(%]%b())()$",
						change = {
							target = "^()()%b[]%((.-)()%)$",
							replacement = function()
								local clipboard = vim.fn.getreg("+"):gsub("\n", "")
								return {
									{ "" },
									{ clipboard },
								}
							end,
						},
					},
				},
			}
		end,
	},
	{
		-- Install markdown preview, use npx if available.
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		init = function()
			if vim.fn.executable("npx") then
				vim.g.mkdp_filetypes = { "markdown" }
			end
		end,
	},
}

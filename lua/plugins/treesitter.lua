--[=====[
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
            ensure_installed = {
                "bash",
                "diff",
                "go",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "toml",
                "typescript",
                "yaml",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
--]=====]

return {}

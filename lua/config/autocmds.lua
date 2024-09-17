local M = {}

local function augroup(name)
  return vim.api.nvim_create_augroup("pik4ez_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

return M

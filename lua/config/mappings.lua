local M = {}

local k = vim.keymap.set

-- Open Nvim configs.
k("n", "<leader>`i", "<cmd>:e ~/.config/nvim/init.lua<cr>", { noremap = true })
k("n", "<leader>`m", "<cmd>:e ~/.config/nvim/lua/config/mappings.lua<cr>", { noremap = true })
k("n", "<leader>`a", "<cmd>:e ~/.config/nvim/lua/config/autocmds.lua<cr>", { noremap = true })
k("n", "<leader>`o", "<cmd>:e ~/.config/nvim/lua/config/options.lua<cr>", { noremap = true })

-- Unmap F1.
k("i", "<f1>", "<nop>", { noremap = true })
k("n", "<f1>", "<nop>", { noremap = true })

-- Remove search highlight.
k("n", "//", ":noh<cr>", { noremap = true })

-- Close all buffers at once.
k("n", "<f8>", ":bufdo bd<cr>", { noremap = true })

-- Save changes.
k("n", "<leader>w", ":w<cr>", { noremap = true })
k("n", "<leader>W", ":noa w<cr>", { noremap = true })

-- Delete current buffer.
k("n", "<leader>d", ":bdelete<cr>", { noremap = true })

-- Jump between neighbour buffers.
k("n", "ga", "<c-^>", { noremap = true, silent = true })
k("n", "gt", ":bnext<cr>", { noremap = true, silent = true })
k("n", "gT", ":bprev<cr>", { noremap = true, silent = true })

-- Create new line above/below the current line.
k("n", "[<leader>", ':call append(line(".")-1, "")<CR>', { noremap = true, silent = true })
k("n", "]<leader>", ':call append(line("."), "")<CR>', { noremap = true, silent = true })

-- Preserve selection while changing indentation.
k("v", "<", "<gv")
k("v", ">", ">gv")

return M

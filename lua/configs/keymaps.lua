local map  = vim.keymap.set
local opts = { silent = true }

-- Leader 键
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- 常用
map("n", "<Leader>w", "<Cmd>w<CR>", opts)
map("n", "<Leader>q", "<Cmd>q<CR>", opts)

-- 分屏移动
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Telescope
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", opts)
map("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>", opts)
map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>",   opts)
map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", opts)

-- Nvim‑tree
map("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>", opts)


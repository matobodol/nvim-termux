-- ~/.config/nvim/lua/core/keymap.lua

local map = vim.keymap.set

-- Set <leader> key (biasanya spasi)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode keymaps
map("n", "<leader>w", ":w<CR>", { desc = "Save File" })
map("n", "<leader>q", ":qa!<CR>", { desc = "Quit All" })

-- Split navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })


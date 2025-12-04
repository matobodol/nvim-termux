-- Format Fungsi Baru (keymap.set)
--
-- vim.keymap.set(mode, key, command, options)
--
-- Format ini lebih fleksibel dan direkomendasikan untuk konfigurasi modern.
--
-- Mode Neovim untuk Keymap
-- n: Normal mode
-- i: Insert mode
-- v: Visual mode
-- x: Visual block mode
-- t: Terminal mode
-- c: Command mode

vim.g.mapleader = " " -- Mengatur leader key menjadi spasi
local opts = { noremap = true, silent = true }

-- Navigasi antar window
vim.keymap.set('n', '<C-h>', '<C-w>h', opts) -- Ke window kiri
vim.keymap.set('n', '<C-l>', '<C-w>l', opts) -- Ke window kanan
vim.keymap.set('n', '<C-j>', '<C-w>j', opts) -- Ke window bawah
vim.keymap.set('n', '<C-k>', '<C-w>k', opts) -- Ke window atas

-- Menyimpan dan keluar
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)  -- Simpan file
vim.keymap.set('n', '<C-q>', ':q<CR>', opts)  -- Keluar
vim.keymap.set('n', '<C-a>', ':wa<CR>', opts) -- Simpan semua file

-- Navigasi buffer
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', opts)     -- Buffer berikutnya
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', opts) -- Buffer sebelumnya
vim.keymap.set('n', '<leader>bc', ':bdelete<CR>', opts)   -- Buffer sebelumnya

-- Mode visual: pindah indentasi sambil tetap di visual
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Memindahkan baris di visual mode
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', opts) -- Pindah baris ke atas
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', opts) -- Pindah baris ke bawah

-- Bergabungkan dua baris di normal mode tanpa memindahkan kursor
vim.keymap.set('n', 'J', 'mzJ`z', opts)

-- Mode insert: keluar cepat
vim.keymap.set('i', 'jk', '<Esc>', opts)

-- Scroll layar tanpa menggeser kursor
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts) -- Scroll setengah layar ke bawah
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts) -- Scroll setengah layar ke atas

-- Pencarian dengan pusat layar
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- hilangkan highlight Pencarian
vim.keymap.set('n', '<leader>nh', ':nohlsearch<CR>', opts)

-- Mode terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)

-- select all and indentasi
vim.keymap.set("n", "<leader>in", "ggVG=<CR>", { desc = "Reindent", silent = true })
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>', { desc = "Select all text in buffer", silent = true })

-- go to homeline
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>h', '^')
-- goto endline
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>l', 'g_')

-- Basic clipboard interaction
vim.keymap.set({ 'n', 'x' }, 'cp', '"+y')
vim.keymap.set({ 'n', 'x' }, 'cv', '"+p')

-- Delete text
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')

vim.keymap.set(
	"n",
	"<Leader>cx",
	':term cd %:h && RUSTFLAGS="-Awarnings" cargo run',
	{ noremap = true, silent = false }
)
vim.keymap.set("n", "<leader>x", function()
	require("nvidol.utils.buffrunner").buffrunner()
end, { desc = "Run current buffer" })

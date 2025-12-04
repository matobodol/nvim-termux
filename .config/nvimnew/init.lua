-- ~/.config/nvim/init.lua

-- Neovim secara otomatis mencari modul di `~/.config/nvim/lua/`.
-- Kita akan menggunakan fungsi `require()` untuk memuat konfigurasi.

-- 1. Muat Konfigurasi Dasar (Core)
require("core.options") -- Contoh untuk opsi Neovim
require("core.keymap")  -- Contoh untuk Keymaps global
require("core.lazy")    -- Wajib: Inisialisasi Lazy.nvim (Plugin Manager)

-- 2. Muat Utils (Autocmds, dll.)
-- require("utils.autocmd") -- Contoh untuk Autocommands

-- Catatan: require("plugins") akan dipanggil secara implisit oleh Lazy.nvim
-- jika kita menggunakan pola yang benar di lazy.lua (Lihat bagian Lazy.nvim).


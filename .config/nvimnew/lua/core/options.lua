-- ~/.config/nvim/lua/core/options.lua

-- General Settings
local options = {
    relativenumber = true, -- Tampilkan nomor baris relatif
    number = true,         -- Tampilkan nomor baris absolut untuk baris saat ini
    mouse = 'a',           -- Aktifkan mouse di semua mode
    clipboard = 'unnamedplus', -- Sinkronkan clipboard Neovim dengan sistem (Berguna di Termux/Android jika ada cara untuk mencapainya)
    signcolumn = 'yes',   -- Selalu tampilkan kolom untuk tanda (misalnya, LSP)
    termguicolors = true, -- Warna 24-bit

    -- Indent Settings
    tabstop = 4,          -- Lebar tab
    shiftwidth = 4,       -- Lebar indentasi otomatis
    expandtab = true,     -- Gunakan spasi alih-alih tab

    -- Search
    ignorecase = true,    -- Pencarian case-insensitive
    smartcase = true,     -- Case-sensitive jika ada huruf kapital
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

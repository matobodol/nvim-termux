-- Aktifkan Lua module loader untuk percepat require
vim.loader.enable()

-- Disable plugin bawaan yang tidak dipakai
local disabled_built_ins = {
	"gzip", "tarPlugin", "zipPlugin", "netrwPlugin",
	"matchit", "matchparen"
}
for _, plugin in ipairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Memanggil folder konfigurasi utama
require("nvidol")

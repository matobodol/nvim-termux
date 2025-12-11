-- Dapatkan root direktori konfigurasi
local config_root = vim.fn.stdpath("config") .. "/lua/nvidol"

-- Tambahkan root ke package.path agar bisa require modul custom
package.path = config_root .. "/?.lua;" .. config_root .. "/?/init.lua;" .. package.path

-- Fungsi untuk memuat modul secara aman
local function load_module(module)
	local ok, err = pcall(require, module)
	if not ok then
		vim.notify("Error loading " .. module .. ": " .. err, vim.log.levels.ERROR)
	end
end

-- Memuat modul utama core
load_module("nvidol.core")

-- Memuat semua file dari direktori tambahan
local subdirs = { "cmd" }

for _, dir in ipairs(subdirs) do
	local files = vim.fn.glob(config_root .. "/" .. dir .. "/*.lua", false, true)
	-- vim.fn.glob dengan flag 1 mengembalikan tabel langsung

	for _, file in ipairs(files) do
		local lua_module = file:match(dir .. "/(.+)%.lua$")
		if lua_module then
			load_module("nvidol." .. dir .. "." .. lua_module)
		end
	end
end

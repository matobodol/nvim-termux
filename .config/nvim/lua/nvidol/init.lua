-- Dapatkan root direktori konfigurasi
local config_root = vim.fn.stdpath("config") .. "/lua/nvidol"

-- Tambahkan root ke package.path agar bisa digunakan di require()
package.path = config_root .. "/?.lua;" ..
	 config_root .. "/?/init.lua;" ..
	 package.path

-- Fungsi untuk memuat modul secara aman
local function load_module(module)
	local ok, err = pcall(require, module)
	if not ok then
		vim.notify(
			"Error loading " .. module .. ": " .. err,
			vim.log.levels.ERROR
		)
	end
end

-- Memuat modul init.lua dari folder tertentu
load_module("core") -- Gunakan prefix 'nvidol.'


-- Memuat semua file dari direktori config_root
local subdir = { "configs", "cmd", }

local cfg_files = ''
for _, dir in ipairs(subdir) do
	cfg_files = vim.fn.glob(config_root .. '/' .. dir .. "/*.lua", true, true)

	for _, file in ipairs(cfg_files) do
		local lua_module = file:match(dir .. "/(.+)%.lua$")
		if lua_module then
			load_module(dir .. '.' .. lua_module)
		end
	end
end

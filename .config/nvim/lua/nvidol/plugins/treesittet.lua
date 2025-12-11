return {
	'nvim-treesitter/nvim-treesitter',
	event = { "BufReadPost", "BufNewFile" },
	run = ':TSUpdate', -- Menjalankan update treesitter setelah pemasangan
	setup = {
		auto_install = true,
		ensure_installed = {},                  -- Pasang bahasa yang didukung secara otomatis
		highlight = {
			enable = true,                       -- Mengaktifkan syntax highlighting
			additional_vim_regex_highlighting = false, -- Mematikan regex untuk highlight (opsional)
		},
		indent = {
			enable = true, -- Mengaktifkan indentasi otomatis berdasarkan treesitter
		},
		autotag = {
			enable = true, -- Mengaktifkan auto-close tag HTML/XML
		},
		matchup = {
			enable = true, -- Menambahkan highlight pasangan tanda kurung
		},
	}
}

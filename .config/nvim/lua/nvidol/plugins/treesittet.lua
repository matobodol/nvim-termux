return {
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate', -- Menjalankan update treesitter setelah pemasangan
	config = function()
		require 'nvim-treesitter.configs'.setup {
			auto_install = true,
			ensure_installed = { "lua", },         -- Pasang bahasa yang didukung secara otomatis
			highlight = {
				enable = true,                      -- Mengaktifkan syntax highlighting
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
	end
}

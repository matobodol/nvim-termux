return {
	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate', -- Menjalankan update treesitter setelah pemasangan
		config = function()
			require 'nvim-treesitter.configs'.setup {
				auto_install = true,
				ensure_installed = { "lua", },      -- Pasang bahasa yang didukung secara otomatis
				highlight = {
					enable = true,                   -- Mengaktifkan syntax highlighting
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
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		name = "dracula",
		config = function()
			require("dracula").setup({
				-- customize dracula color palette
				colors = {
					bg = "#282A36",
					fg = "#F8F8F2",
					selection = "#44475A",
					comment = "#6272A4",
					red = "#FF5555",
					orange = "#FFB86C",
					yellow = "#F1FA8C",
					green = "#50fa7b",
					purple = "#BD93F9",
					cyan = "#8BE9FD",
					pink = "#FF79C6",
					bright_red = "#FF6E6E",
					bright_green = "#69FF94",
					bright_yellow = "#FFFFA5",
					bright_blue = "#D6ACFF",
					bright_magenta = "#FF92DF",
					bright_cyan = "#A4FFFF",
					bright_white = "#FFFFFF",
					menu = "#21222C",
					visual = "#3E4452",
					gutter_fg = "#4B5263",
					nontext = "#3B4048",
					white = "#ABB2BF",
					black = "#191A21",
				},
				-- show the '~' characters after the end of buffers
				show_end_of_buffer = true, -- default false
				-- use transparent background
				transparent_bg = false, -- default false
				-- set custom lualine background color
				lualine_bg_color = "#44475a", -- default nil
				-- set italic comment
				italic_comment = false, -- default false
			})

			-- vim.cmd("colorscheme tokyonight")
			vim.cmd("colorscheme dracula")
		end,
	},
}

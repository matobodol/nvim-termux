local M = {
	'nvim-lualine/lualine.nvim',
	event = { "BufReadPre", "BufNewFile" },
	dependencies = 'nvim-tree/nvim-web-devicons',
}

M.config = function()
	local status_ok, lualine = pcall(require, "lualine")
	if not status_ok then
		return
	end

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = 'auto', -- Pertahankan tema 'auto' atau 'onedark' untuk nuansa NvChad

			-- MENGGUNAKAN PEMISAH SEPERTI SEMULA
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },

			disabled_filetypes = { 'alpha', 'dashboard' },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = {
				'branch',
				'diff',
			},
			lualine_c = {
				{
					'filename',
					file_status = true,
					path = 1, -- Path relatif
					symbols = {
						modified = '  ',
						readonly = '  ',
						unnamed = ' [No Name] ',
						newfile = '  ',
					}
				}
			},
			lualine_x = {
				{
					'substitute',
				},
				{
					'diagnostics',
					sources = { 'nvim_lsp' },
					sections = { 'error', 'warn', 'info', 'hint' },
					symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
					colored = true,
					update_in_insert = false,
				}
			},
			lualine_y = { 'filetype' },
			lualine_z = {
				'location',
				{
					function()
						return " " .. os.date("%R")
					end,
				},
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = { function() return " " .. os.date("%R") end, },
		},
		tabline = {},
		extensions = { 'nvim-tree' }
	})
end

return M

-- AUTOPAIRS
local M = { 'windwp/nvim-autopairs' }

M.event = 'InsertEnter'

-- Optional dependency
M.dependencies = { 'hrsh7th/nvim-cmp' }

M.config = function()
	require('nvim-autopairs').setup {}
	-- If you want to automatically add `(` after selecting a function or method
	local status_cmp_ok, cmp = pcall(require, "cmp")
	if not status_cmp_ok then
		return
	end

	local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
	local cmp = require 'cmp'
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M

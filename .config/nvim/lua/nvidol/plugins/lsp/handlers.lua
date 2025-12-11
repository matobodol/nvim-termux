vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gh", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "gf", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)

local signs = {
	Error = " ",
	Warn  = " ",
	Hint  = " ",
	Info  = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Konfigurasi awal diagnostic
local diagnostics_enabled = true -- aktif default

-- Fungsi untuk mengatur diagnostic
local function set_diagnostics()
	vim.diagnostic.config({
		virtual_text = diagnostics_enabled,
		float = {
			source = true,
			border = "rounded",
		},
		update_in_insert = false,
	})
end

-- Konfigurasi awal
set_diagnostics()

-- Keymap toggle
vim.keymap.set("n", "<leader>td", function()
	diagnostics_enabled = not diagnostics_enabled
	set_diagnostics()
	local status = diagnostics_enabled and "enabled" or "disabled"
	vim.notify("Diagnostic virtual_text " .. status, vim.log.levels.INFO)
end, { desc = "Toggle Diagnostic virtual_text", noremap = true, silent = true })

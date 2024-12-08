-- LSP PLUGINS
-- Plugin utama untuk LSP
-- { "neovim/nvim-lspconfig" },

-- Plugin untuk installer LSP otomatis
-- { "williamboman/mason.nvim", build = ":MasonUpdate" },
-- { "williamboman/mason-lspconfig.nvim" },

-- Mengubah tanda diagnostik
local signs = {
	Error = " ", -- Ikon untuk error
	Warn = " ", -- Ikon untuk warning
	Hint = " ", -- Ikon untuk hint
	Info = " ", -- Ikon untuk info
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Keymaps untuk navigasi LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Mason Setup
require("mason").setup()


-- Mason-LSPConfig Integration
-- lsp want to install
local ensure_installed = {
	"pyright",
	"bashls",
}

require("mason-lspconfig").setup {
	ensure_installed = ensure_installed,
	automatic_installation = false,
}

-- LSPConfig

-- Mengambil daftar server yang telah dipasang via mason
local servers_mason = require("mason-lspconfig").get_installed_servers()

-- lists server installed by system
local servers = { 'lua_ls', 'rust_analyzer' }

for _, v in ipairs(servers_mason) do
	table.insert(servers, v)
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end

-- Integrasi LSP dengan Nvim-CMP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		capabilities = capabilities,
	}
end

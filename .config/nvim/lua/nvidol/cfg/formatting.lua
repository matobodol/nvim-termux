-- FORMATTING

-- Variabel untuk mengaktifkan/mematikan formatting
local formatting_enabled = true

-- Fungsi untuk toggle formatting
function toggle_formatting()
	formatting_enabled = not formatting_enabled
	if formatting_enabled then
		print("Formatting enabled")
	else
		print("Formatting disabled")
	end
end

-- Fungsi untuk mengatur format on save
local function setup_format_on_save(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				if formatting_enabled then
					vim.lsp.buf.format({
						async = false,
						bufnr = bufnr,
						filter = function(cli)
							return cli.name == client.name
						end,
					})
				end
			end,
		})
	end
end

-- Fungsi untuk mengatur fallback null-ls
local function setup_null_ls_format_on_save(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			if formatting_enabled then
				vim.lsp.buf.format({
					async = false,
					filter = function(client)
						return client.name == "null-ls"
					end,
				})
			end
		end,
	})
end

-- Integrasi Null-LS
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier, -- Untuk JavaScript, TypeScript
		null_ls.builtins.formatting.black, -- Untuk Python
		null_ls.builtins.formatting.shfmt, -- Untuk Shell Script
	},
	on_attach = function(client, bufnr)
		-- Jika null-ls mendukung formatting, atur format on save
		if client.server_capabilities.documentFormattingProvider then
			setup_null_ls_format_on_save(bufnr)
		end
	end,
})

-- Konfigurasi untuk LSP
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "pyright", "bashls", "lua_ls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			-- Jika LSP mendukung formatting
			if client.server_capabilities.documentFormattingProvider then
				setup_format_on_save(client, bufnr)
			else
				-- Gunakan null-ls jika LSP tidak mendukung formatting
				setup_null_ls_format_on_save(bufnr)
			end

			-- Tambahkan keymap untuk toggle formatting
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tf", "<cmd>lua toggle_formatting()<CR>",
				{ noremap = true, silent = true, desc = "Toggle Formatting" })
		end,
	})
end

-- Command untuk toggle formatting
-- vim.api.nvim_create_user_command("ToggleFormatting", toggle_formatting, { desc = "Toggle Formatting On/Off" })

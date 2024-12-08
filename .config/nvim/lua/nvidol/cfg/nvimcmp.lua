-- Plugin untuk autocompletion
-- { "hrsh7th/nvim-cmp" },
-- { "hrsh7th/cmp-nvim-lsp" },
-- { "hrsh7th/cmp-buffer" },
-- { "hrsh7th/cmp-path" },
-- {'hrsh7th/cmp-cmdline'},

-- SNIPPETS ENGINE
-- {
-- 	"saadparwaiz1/cmp_luasnip",
-- 	"L3MON4D3/LuaSnip",
-- },

-- Nvim-CMP Setup
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Konfirmasi pilihan
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- Sumber LSP
		{ name = "luasnip" }, -- Snippet luasnip
		{ name = "path" }, -- Penyelesaian path
		{ name = "buffer" }, -- Penyelesaian buffer
	}),
})

-- Pengaturan khusus untuk cmdline
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" }, -- Path untuk cmdline
	}, {
		{ name = "cmdline" }, -- Penyelesaian cmdline
	}),
})

-- Pengaturan untuk pencarian (/ atau ?)
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" }, -- Penyelesaian dari buffer
	},
})

return {
	-- Plugin untuk autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ 'hrsh7th/cmp-cmdline' },

			-- SNIPPETS ENGINE
			{
				-- for user kuasnip
				-- "saadparwaiz1/cmp_luasnip",
				-- "L3MON4D3/LuaSnip",

				-- " For vsnip users.
				'hrsh7th/cmp-vsnip',
				'hrsh7th/vim-vsnip',
			},
		},
		config = function()
			local status_ok, cmp = pcall(require, "cmp")
			if not status_ok then
				return
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						-- require("luasnip").lsp_expand(args.body)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
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
					-- { name = "luasnip" }, -- Snippet luasnip
					vsnip = '⋗', --'⋗ ',
					{ name = "path" }, -- Penyelesaian path
					{ name = "buffer" }, -- Penyelesaian buffer
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, vim_item)
						local menu_icon = {
							nvim_lsp = 'λ', --'λ ',
							vsnip = '>', -- For vsnip users.
							-- luasnip = '⋗', --'⋗ ',
							buffer = 'Ω', --'Ω ',
							path = '::', --'Ω ',
						}
						-- size menu char
						local ELLIPSIS_CHAR = '~' --'…'
						local MAX_LABEL_WIDTH = 16
						local MIN_LABEL_WIDTH = 5

						local label = vim_item.abbr
						local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
						if truncated_label ~= label then
							vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
						elseif string.len(label) < MIN_LABEL_WIDTH then
							local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
							vim_item.abbr = label .. padding
						end

						vim_item.menu = menu_icon[entry.source.name]
						return vim_item
					end,
				},
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
		end,
	}
}

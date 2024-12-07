return {
	-- TELESCOPE
	{
		"nvim-telescope/telescope.nvim",  -- Menambahkan telescope
		dependencies = {
			"nvim-lua/plenary.nvim",         -- Menambahkan dependensi plenary.nvim
			"nvim-telescope/telescope-fzy-native.nvim",  -- Menambahkan dependensi fzy-native untuk pencarian lebih cepat
		},
	},

	--TREESITTER
	{ "nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons", },
		keys = { { '<leader>e', '<cmd>NvimTreeToggle<cr>' }, },
	},

	-- LSP PLUGINS
	-- Plugin utama untuk LSP
	{ "neovim/nvim-lspconfig" },

	-- Plugin untuk installer LSP otomatis
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- Plugin untuk autocompletion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ 'hrsh7th/cmp-cmdline'},

	-- SNIPPETS ENGINE
	{
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},

	-- FORMATTING
  { "jose-elias-alvarez/null-ls.nvim" },
  { "jayp0521/mason-null-ls.nvim" },

	-- AUTOPAIRS
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		-- Optional dependency
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require('nvim-autopairs').setup {}
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},
}

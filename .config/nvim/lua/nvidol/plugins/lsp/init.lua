return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "jayp0521/mason-null-ls.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		-- contohnya menggunakan lazy.nvim
	},

	config = function()
		require("nvidol.plugins.lsp.mason")
		require("nvidol.plugins.lsp.handlers")
		require("nvidol.plugins.lsp.autoformat")
	end,
}

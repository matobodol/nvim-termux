return {
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate', -- Menjalankan update treesitter setelah pemasangan
        config = function()
            require'nvim-treesitter.configs'.setup {
                auto_install = true,
                ensure_installed = {"lua",}, -- Pasang bahasa yang didukung secara otomatis
                highlight = {
                    enable = true, -- Mengaktifkan syntax highlighting
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
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- Pilih varian: latte, frappe, macchiato, mocha
                background = {
                    light = "latte", -- Background untuk mode terang
                    dark = "mocha",  -- Background untuk mode gelap
                },
                transparent_background = false, -- Background transparan
                term_colors = true,            -- Sinkronisasi warna terminal
                styles = {
                    comments = { "italic" },     -- Gaya untuk komentar
                    functions = { "bold" },      -- Gaya untuk fungsi
                    keywords = { "italic" },     -- Gaya untuk keyword
                    strings = {},                -- Gaya untuk string
                    variables = {},              -- Gaya untuk variabel
                },
                integrations = {
                    treesitter = true,           -- Integrasi dengan Treesitter
                    telescope = true,            -- Integrasi dengan Telescope
                    nvimtree = true,             -- Integrasi dengan NvimTree
                    lsp_trouble = true,          -- Integrasi dengan LSP Trouble
                    cmp = true,                  -- Integrasi dengan cmp
                    gitsigns = true,             -- Integrasi dengan GitSigns
                },
            })

            -- Terapkan tema Catppuccin
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}

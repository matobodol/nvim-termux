-- ~/.config/nvim/lua/config/telescope.lua

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    vim.api.nvim_err_writeln("Telescope not installed! Please install it first.")
    return
end

local actions = require('telescope.actions')

-- Setup Telescope
telescope.setup{
    defaults = {
        -- Menyesuaikan Keymap
        mappings = {
            i = {
                ["<Esc>"] = actions.close,  -- Menutup dengan Esc
                ["<C-n>"] = actions.move_selection_next, -- Navigasi ke bawah
                ["<C-p>"] = actions.move_selection_previous, -- Navigasi ke atas
                ["<C-j>"] = actions.cycle_history_next,  -- Sejarah pencarian
                ["<C-k>"] = actions.cycle_history_prev,  -- Sejarah pencarian sebelumnya
            },
            n = {
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,  -- Menambahkan hasil ke quickfix list
                ["<C-c>"] = actions.close,  -- Menutup dengan Ctrl+C
            },
        },

        -- Menyesuaikan Tampilan
        prompt_prefix = "🔍 ",  -- Menambahkan ikon pada prompt
        selection_caret = " ",  -- Ikon caret saat memilih item
        path_display = { "truncate" },  -- Memotong nama path untuk menampilkan file
        layout_strategy = "vertical",  -- Menyusun layout secara vertikal
        layout_config = {
            width = 0.80,
            height = 0.65,
            prompt_position = "top",
            horizontal = {
                mirror = true,
                preview_width = 20,
            },
            vertical = {
                mirror = false,
                preview_width = 0.70,
            },
        },
    },

    -- Menambahkan opsi untuk mencari file tersembunyi
    pickers = {
        find_files = {
            hidden = true,  -- Mencari file yang ada di folder tersembunyi
        },
        live_grep = {
            additional_args = function(_)
                return { "--hidden", "-g", "!.git/*" }  -- Menyertakan file tersembunyi, mengecualikan folder .git
            end,
        },
    },
}

-- Keymap untuk membuka Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', ":Telescope find_files<CR>", { noremap = true, silent = true })  -- Mencari file
vim.api.nvim_set_keymap('n', '<leader>fg', ":Telescope live_grep<CR>", { noremap = true, silent = true })  -- Mencari dalam file
vim.api.nvim_set_keymap('n', '<leader>fb', ":Telescope buffers<CR>", { noremap = true, silent = true })  -- Mencari buffer
vim.api.nvim_set_keymap('n', '<leader>fh', ":Telescope help_tags<CR>", { noremap = true, silent = true })  -- Mencari tag bantuan
vim.api.nvim_set_keymap('n', '<leader>fr', ":Telescope oldfiles<CR>", { noremap = true, silent = true })  -- Mencari file yang sudah dibuka
vim.api.nvim_set_keymap('n', '<leader>fd', ":Telescope file_browser<CR>", { noremap = true, silent = true })  -- Mencari file dengan file browser

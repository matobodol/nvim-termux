-- ~/.config/nvim/lua/plugins/nvim-tree.lua

local M = {}

M.setup = function()
    -- Lakukan setup NvimTree
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30, -- Lebar sidebar
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false, -- Tampilkan file tersembunyi
        },
    })

    -- Definisikan Keymap untuk NvimTree
    -- Gunakan leader key + e (leader biasanya adalah Spasi)
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer (NvimTree)" })

    -- Atur Colorscheme saat NvimTree selesai diinisialisasi
    vim.cmd.colorscheme("tokyonight-night")
end

return M


-- ~/.config/nvim/lua/utils/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Grup Autocmd Kustom
local my_group = augroup("MyCustomConfig", { clear = true })

-- Autocmd: Secara otomatis simpan saat Neovim kehilangan fokus
autocmd("FocusLost", {
    group = my_group,
    callback = function()
        vim.cmd("wa") -- write all
    end
})

-- Autocmd: Atur ukuran indentasi khusus untuk file Python
autocmd("FileType", {
    group = my_group,
    pattern = "python",
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
    end,
})


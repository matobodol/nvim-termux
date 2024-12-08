-- Fungsi toggle untuk number dan relative number

local function toggle_number()
    if vim.o.number and vim.o.relativenumber then
        vim.o.number = false
        vim.o.relativenumber = false
        print("Number OFF")
    else
        vim.o.number = true
        vim.o.relativenumber = true
        print("Number ON")
    end
end

-- Keymap untuk toggle
vim.keymap.set('n', '<leader>.', toggle_number, { noremap = true, silent = true })


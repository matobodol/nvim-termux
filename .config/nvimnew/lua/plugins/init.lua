-- ~/.config/nvim/lua/plugins/init.lua
return {
    -- 1. Plugin Manager itu sendiri
    { "folke/lazy.nvim", version = "auto" },

    -- 2. Colorscheme
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
    
    -- 3. NvimTree (File Explorer)
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
             "nvim-tree/nvim-web-devicons",
        },
        -- Perubahan: Memanggil dari "plugins.config.nvim-tree"
        config = function()
            -- require() secara otomatis mencari di lua/
            require("plugins.config.nvim-tree").setup() 
        end,
    },
}


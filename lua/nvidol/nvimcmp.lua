
-- " For vsnip users.
-- 'hrsh7th/cmp-vsnip''
-- 'hrsh7th/vim-vsnip'

-- " For luasnip users.
-- 'L3MON4D3/LuaSnip'
-- 'saadparwaiz1/cmp_luasnip'
--
-- " For ultisnips users.
-- 'SirVer/ultisnips'
-- 'quangnguyen30192/cmp-nvim-ultisnips'
--
-- " For snippy users.
-- 'dcampos/nvim-snippy'
-- 'dcampos/cmp-snippy'
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    return
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    -- Here we choose how the completion window will appear
    formatting = {
        fields = { "abbr", "kind", "menu"},
        format = function(entry, vim_item)
            local menu_icon = {
                nvim_lsp = 'λ',     --'λ ',
                luasnip = '⋗',      --'⋗ ',
                buffer = 'Ω',       --'Ω ',
            }
            -- size menu char
            local ELLIPSIS_CHAR = '~'    --'…'
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
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
            { name = 'buffer' },
        })
})


-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        }),
    matching = { disallow_symbol_nonprefix_matching = false }
})




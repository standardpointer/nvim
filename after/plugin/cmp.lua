local status, cmp = pcall(require, "cmp")
if not status then
    return
end

local lspkind = require("lspkind")
local cmp_npairs = require("nvim-autopairs.completion.cmp")


local ls = require "luasnip"
ls.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
}

local is_enabled = function()
    local in_prompt = vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt'
    if in_prompt then
        return false
    end
    local ctx = require("cmp.config.context")
    return not (ctx.in_treesitter_capture("comment") == true or ctx.in_syntax_group("Comment"))
end


cmp.event:on("confirm_done", cmp_npairs.on_confirm_done())
local WIDE_HEIGHT = 40
cmp.setup({
    enabled = is_enabled,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            maxheight = 20,
            icons = true,
            ellipsis_char = "...",
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "treesitter" },
    },
})



cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "cmp_git" },
    }, {
        { name = "buffer" },
    }),
})

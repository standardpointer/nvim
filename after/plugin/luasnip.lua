local status, ls = pcall(require, "luasnip")
if not stauts then
    return
end
ls.filetype_extend("javascript", { "javascriptreact" })
ls.filetype_extend("typescript", { "typescriptreact" })
ls.filetype_extend("javascript", { "html" })
-- some shorthands...
local snip = ls.snippet
local func = ls.function_node

local date = function()
    return { os.date("%Y-%m-%d") }
end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
    },
})

ls.filetype_extend("javascript", { "javascriptreact", "javascript", "html" })
ls.filetype_extend("javascript", { "html" })
ls.filetype_extend("typescript", { "typescriptreact", "typescript", "html" })

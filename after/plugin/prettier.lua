local status, prettier = pcall(require, "prettier")
if not status then
    return
end

prettier.setup({
    bin = "prettier",
    filetypes = {
        "astro",
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "scss",
        "less",
    },
})
vim.cmd([[let g:prettier#config#tab_width = 'auto']])

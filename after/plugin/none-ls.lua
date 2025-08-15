local status, null_ls = pcall(require, "null-ls")
if not status then
    return
end

local util = require("null-ls.utils")
local formatting = null_ls.builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local config = {
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    sources = {
        formatting.stylua,
        formatting.autopep8.with({
            filetypes = { "python" }
        }),
        formatting.prettier.with({
            filetypes = {
                "astro",
                "css",
                "html",
                "javascript",
                "jsx",
                "json",
                "yaml",
                "typescript",
                "tsx",
            },
            condition = function()
                return vim.bo.filetype ~= "python"
            end,
        }),
    },
}

null_ls.setup(config)

local ts = "typescript-language-server"
return {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { ts, "--stdio" },
    root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
}

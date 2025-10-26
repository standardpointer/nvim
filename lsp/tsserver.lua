local ts = "typescript-language-server"
return {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { ts, "--stdio" },
    root_markers = { "package.json", "tsconfig.json", ".git" }
}

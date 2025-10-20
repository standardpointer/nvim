local s_path = (name == "Darwin") and
    vim.fs.joinpath(home, "Library/pnpm/global/5/node_modules/typescript/lib/tsserverlibrary.js") or ""
return {
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    init_options = {
        configuration = {},
        typescript = { serverPath = s_path },
    },
    root_markers = vim.fs.root(0, { "astro.config.mjs", "package.json", "tsconfig.json", ".git" }),
}

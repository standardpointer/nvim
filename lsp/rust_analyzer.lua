return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = { group = "module" },
                prefix = "self",
            },
            diagnostics = { enable = false },
        },
    },
    root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json" }),
}

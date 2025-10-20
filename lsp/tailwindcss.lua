return {
    filetypes = {
        "astro", "html", "markdown", "css", "scss", "javascript",
        "typescript", "vue", "svelte",
    },
    root_dir = vim.fs.root(0, {
        "tailwind.config.*",
        "postcss.config.*",
        "package.json",
        "node_modules",
        ".git"
    }
    ),
}

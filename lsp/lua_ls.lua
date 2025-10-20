-- === Lua ===
vim.lsp.config("lua_ls", {
    capabilities = cmp_capabilities,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
    root_dir = vim.fs.root(0, { ".stylua.toml", "stylua.toml" }),
})

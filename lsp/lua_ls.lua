return {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".stylua.toml", "stylua.toml" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api and vim.api.nvim_get_runtime_file("", true) or {},
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}

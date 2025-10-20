-- Fallback flags (platform specific)
local name = vim.loop.os_uname().sysname
local function set_fallback_flags()
    if name == "Darwin" then
        return {
            "-target=arm64-apple-darwin",
            "stdlib=libc++",
            "-std=c++23",
            "-Wall",
            "-isystem", "/opt/homebrew/opt/llvm/include/c++/v1",
        }
    else
        return { "-target=x86_64-w64-windows-gnu", "-std=c++23", "-Wall" }
    end
end

local clangd_path = ""
if name == "Darwin" then
    clangd_path = "/opt/homebrew/opt/llvm/bin/clangd"
elseif name == "Windows_NT" then
    clangd_path = "C:/msys64/mingw64/bin/clangd"
end

-- === Clangd ===
return {
    on_attach = function(client, bufnr)
        local orig_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
        vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            if result and result.diagnostics then
                result.diagnostics = vim.tbl_filter(function(d)
                    return not (d.message and d.message:find("No global header file was included!"))
                end, result.diagnostics)
            end
            orig_handler(_, result, ctx, config)
        end
    end,
    flags = lsp_flags,
    capabilities = cmp_capabilities,
    cmd = { clangd_path, "--background-index", "--clang-tidy" },
    single_file_support = true,
    settings = { fallbackFlags = set_fallback_flags() },
    root_dir = vim.fs.root(0, {
        "clangd", ".clang-format", ".clang-tidy",
        "compile_commands.json", "compile_flags.txt", ".git"
    }),
}

-- === Web stack (HTML, TS, Tailwind, Astro) ===
local vscode = "vscode-html-language-server"

return {
    capabilities = cmp_capabilities,
    cmd = { vscode, "--stdio" },
    filetypes = { "html" },
    init_options = { provideFormatter = false },
}

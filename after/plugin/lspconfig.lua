local status, nvimlsp = pcall(require, "lspconfig")
if not status then
    return
end

local name = vim.loop.os_uname().sysname
local util = nvimlsp.util

local bufnr = vim.api.nvim_get_current_buf()
local bufname = vim.api.nvim_buf_get_name(bufnr)

local opts = {
    noremap = true,
    silent = true,
}

-- Setup nvim-cmp.
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local protocol = require("vim.lsp.protocol")
local on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
end

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(protocol.make_client_capabilities())

local fold_capabilities = vim.lsp.protocol.make_client_capabilities()
fold_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
}

local lsp_flags = {
    debounce_text_changes = 150,
}

local set_fallback_flags = function()
    local fallback_flags = {}
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "cpp",
        callback = function()
            if name == "Darwin" then
                fallback_flags = { "-target=arm64-apple-darwin", "-std=c++2a", "-Wall" }
            else
                fallback_flags = { "-target=x86_64-w64-windows-gnu", "-std=c++17", "-Wall" }
            end
        end,
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "c",
        callback = function()
            if name == "Darwin" then
                fallback_flags = { "-target=arm64-apple-darwin", "-std=gnu2x", "-Wall" }
            else
                fallback_flags = { "-std=gnu2x", "-Wall" }
            end
        end,
    })
    return fallback_flags
end

local clangd_path = ""
if name == "Darwin" then
    clangd_path = clangd_path .. "clangd"
else
    clangd_path = clangd_path .. "C:/msys64/mingw64/bin/clangd"
end

-- MAIN LANGUAGE SERVER SETUP
nvimlsp["clangd"].setup({
    -- on_attach = on_attach,
    on_attach = function(client, bufnr)
        -- Modify diagnostic behavior (optional)
        vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            if not result then return end
            local diagnostics = result.diagnostics
            -- Filter out "no global header found" error
            local filtered_diagnostics = {}
            for _, diagnostic in ipairs(diagnostics) do
                if diagnostic.message and not diagnostic.message:find("no global module included") then
                    table.insert(filtered_diagnostics, diagnostic)
                end
            end
            result.diagnostics = filtered_diagnostics
            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end
    end,
    flags = lsp_flags,
    capabilities = cmp_capabilities,
    cmd = {
        clangd_path,
        "--background-index",
        "--clang-tidy",
    },
    single_file_support = true,
    settings = {
        fallbackFlags = set_fallback_flags(),
    },
    root_dir = util.root_pattern(
        "clangd",
        ".clang-format",
        ".clang-tidy",
        "compile_commands.json",
        "compile_flags.txt",
        ".git"
    ),
    util.path.dirname,
})

nvimlsp["pyright"].setup({
    -- -- on_attach = on_attach,
    flags = lsp_flags,
    capabilities = cmp_capabilities,
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = function()
        return vim.fn.getcwd()
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
            },
        },
    },
})

local rt_opts = {
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
}

--local rt_status, rust_tools = pcall(require, "rust-tools")
--if not rt_status then return end
--rust_tools.setup(rt_opts)


nvimlsp["rust_analyzer"].setup({
    -- on_attach = on_attach,
    flags = lsp_flags,
    capabilities = cmp_capabilities,
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    settings = {
        ['rust_analyzer'] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            diagnostics = {
                enable = false,
            }
        }
    },
    single_file_support = true,
    root_dir = util.root_pattern("Cargo.toml", "rust-project.json"),
})

nvimlsp["jdtls"].setup({
    -- on_attach = on_attach,
    flags = lsp_flags,
    capabilities = cmp_capabilities,
    root_dir = function()
        return vim.fn.getcwd()
    end,
})

nvimlsp["lua_ls"].setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = cmp_capabilities,
    single_file_support = true,
    root_dir = util.root_pattern(".stylua.toml", "stylua.toml"),
})

nvimlsp["gopls"].setup({
    -- on_attach = on_attach,
    capabilities = cmp_capabilities,
})

cmp_capabilities.textDocument.completion.snippetSupport = true

nvimlsp["dockerls"].setup({
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
    root_dir = util.root_pattern("Dockerfile"),
})

nvimlsp["bashls"].setup({
    -- on_attach = on_attach,
    capabilities = cmp_capabilities,
    cmd = { "bash-language-server", "start" },
    cmd_env = { GLOB_PATTERN = "*@(.sh|.zshrc)" },
    root_dir = function()
        return vim.fn.getcwd()
    end,
    single_file_support = true,
})

nvimlsp["cmake"].setup({
    capabilities = cmp_capabilities,
    -- on_attach = on_attach,
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    single_file_support = true,
    root_dir = util.root_pattern("CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake"),
    init_options = {
        buildDirectory = "build",
    },
})

local vscode = "vscode-html-language-server"
local ts = "typescript-language-server"
local s_path = ""
if name == "Darwin" then
    ts = ts
    vscode = vscode
    s_path = "/Users/jonahperry/Library/pnpm/global/5/node_modules/typescript/lib/tsserverlibrary.js"
elseif name == "Windows_NT" then
    ts = ts
    vscode = vscode
end

nvimlsp["html"].setup({
    capabilities = cmp_capabilities,
    cmd = { vscode, "--stdio" },
    filetypes = { "html" },
    init_options = {
        provideFormatter = false,
    },
})

nvimlsp["ts_ls"].setup({
    -- on_attach = on_attach,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    cmd = { ts, "--stdio" },
    root_dir = function()
        return vim.fn.getcwd()
    end,
    capabilities = cmp_capabilities,
    flag = lsp_flags,
})

nvimlsp["tailwindcss"].setup({
    -- on_attach = on_attach,
    capabilities = cmp_capabilities,
    filetypes = {
        "astro",
        "astro-markdown",
        "html",
        "liquid",
        "markdown",
        "nunjucks",
        "php",
        "css",
        "less",
        "postcss",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
    },
    root_dir = nvimlsp.util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.cjs",
        "postcss.config.mjs",
        "postcss.config.ts",
        "package.json",
        "node_modules",
        ".git"
    ),
})

nvimlsp["astro"].setup({
    -- on_attach = on_attach,
    capabilities = cmp_capabilities,
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    init_options = {
        configuration = {},
        typescript = {
            serverPath = s_path,
        },
    },
    root_dir = nvimlsp.util.root_pattern("astro.config.mjs", "package.json", "tsconfig.json", ".git", ".npmrc"),
})

nvimlsp["zls"].setup({
    -- on_attach = on_attach,
})

local function get_language_id()
    -- You can use various methods to determine the language ID here.
    -- For example, you can check the file's extension or look for specific content patterns.

    -- Example: Check if the file has a .ml extension.
    if vim.fn.expand('%:e') == 'ml' then
        return 'ocaml' -- Set the language ID to 'ocaml' for OCaml files.
    end

    if vim.fn.expand('%:e') == 're' then
        return 'reason'
    end

    -- Return a default language ID if no specific criteria match.
    return 'plaintext'
end
nvimlsp['ocamllsp'].setup({
    cmd = { "ocamllsp" },
    -- on_attach = on_attach,
    capabilities = cmp_capabilities,
    get_language_id = get_language_id,
    filetypes = { "ocaml", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
    root_dir = nvimlsp.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace")
})

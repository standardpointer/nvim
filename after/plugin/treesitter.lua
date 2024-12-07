local status, treesitter_conf = pcall(require, "nvim-treesitter.configs")
local status2, treesitter_install = pcall(require, "nvim-treesitter.install")
require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

local vim = vim
if not status or not status2 then
    return
end

if vim.loop.os_uname().sysname == "Windows_NT" then
    treesitter_install.prefer_git = false
end

treesitter_conf.setup({
    ensure_installed = {
        "astro",
        "c",
        "lua",
        "rust",
        "cpp",
        "fish",
        "html",
        "css",
        "javascript",
        "markdown",
        "markdown_inline",
        "typescript",
        "tsx",
        "vim",
        "python",
        "vimdoc",
        "latex",
        "zig",
        "powershell",
        "swift",
        "asm"
    },
    indent = { enable = true, disable = { "python" } },



    sync_install = false,

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        additional_vim_regex_highlighting = false,
    },
    --
})
